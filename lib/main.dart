import 'package:aquatech_weather/screens/ui/default_weather_card.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:aquatech_weather/screens/favorite_screen.dart';
import 'package:aquatech_weather/screens/weather_search_detail.dart';
import 'package:aquatech_weather/services/geocoding_service.dart';
import 'package:aquatech_weather/services/weather_service.dart';
import 'package:aquatech_weather/models/hourly_units.dart';
import 'package:aquatech_weather/models/weather.dart';
import 'package:aquatech_weather/style/styled_body_text.dart';
import 'package:aquatech_weather/screens/ui/weather_bubble.dart';
import 'package:aquatech_weather/services/utils.dart';

void main() {
  runApp(MaterialApp(
    home: WeatherScreen(),
  ));
}

class WeatherScreen extends StatefulWidget {
  @override
  _WeatherScreenState createState() => _WeatherScreenState();
}

class _WeatherScreenState extends State<WeatherScreen> {
  late Future<Weather> futureWeather;
  final TextEditingController _controller = TextEditingController();
  String? _error;
  DateTime? _startDate;
  DateTime? _endDate;

  @override
  void initState() {
    super.initState();
    DateTime now = DateTime.now();
    String formattedDate = DateFormat('yyyy-MM-dd').format(now);
    futureWeather = WeatherService().fetchWeatherData(43.6109, 3.8763, formattedDate, formattedDate);
  }

  Future<void> _searchCity(String city) async {
    if (_startDate == null || _endDate == null) {
      setState(() {
        _error = "Veuillez choisir une date de début et de fin.";
      });
      return;
    }

    try {
      final coordinates = await GeocodingService().getCoordinatesFromCity(city);
      final startDay = DateFormat('yyyy-MM-dd').format(_startDate!);
      final endDay = DateFormat('yyyy-MM-dd').format(_endDate!);
      final weather = await WeatherService().fetchWeatherData(coordinates.latitude, coordinates.longitude, startDay, endDay);
      setState(() {
        _error = null;
      });
      Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) => WeatherSearchScreen(weather: weather, cityName: capitalize(city)),
        ),
      );
    } catch (e) {
      setState(() {
        _error = e.toString();
      });
    }
  }

  Future<void> _selectDateRange(BuildContext context) async {
    final picked = await showDateRangePicker(
      context: context,
      firstDate: DateTime.now().subtract(Duration(days: 365)),
      lastDate: DateTime.now().add(Duration(days: 365)),
      initialDateRange: _startDate != null && _endDate != null
          ? DateTimeRange(start: _startDate!, end: _endDate!)
          : null,
    );
    if (picked != null) {
      setState(() {
        _startDate = picked.start;
        _endDate = picked.end;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const StyledBodyText("Application météo", true, 25.0),
        actions: [
          IconButton(
            icon: const Icon(Icons.favorite, color: Colors.white),
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => FavoritesScreen()),
              );
            },
          ),
        ],
        centerTitle: true,
        flexibleSpace: Container(
          decoration: const BoxDecoration(
            gradient: LinearGradient(
              colors: [
                Color.fromARGB(255, 43, 196, 229),
                Color.fromARGB(255, 24, 109, 127)
              ],
            ),
          ),
        ),
      ),
      body: Container(
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            colors: [
              Color.fromARGB(255, 43, 196, 229),
              Color.fromARGB(255, 24, 109, 127)
            ],
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
          ),
        ),
        child: Column(
          children: [
            SearchBar(
              controller: _controller,
              startDate: _startDate,
              endDate: _endDate,
              onSubmitted: _searchCity,
              onSelectDateRange: () => _selectDateRange(context),
              error: _error,
            ),
            DefaultWeatherCard(futureWeather: futureWeather),
          ],
        ),
      ),
    );
  }
}

class SearchBar extends StatelessWidget {
  final TextEditingController controller;
  final DateTime? startDate;
  final DateTime? endDate;
  final Function(String) onSubmitted;
  final VoidCallback onSelectDateRange;
  final String? error;

  const SearchBar({
    required this.controller,
    required this.startDate,
    required this.endDate,
    required this.onSubmitted,
    required this.onSelectDateRange,
    this.error,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(top: 20.0, left: 20.0, right: 20.0),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          TextField(
            controller: controller,
            decoration: const InputDecoration(
              hintText: "Choisir une ville",
              hintStyle: TextStyle(
                color: Colors.black,
              ),
              border: OutlineInputBorder(
                borderRadius: BorderRadius.all(Radius.circular(10.0)),
                borderSide: BorderSide.none,
              ),
              filled: true,
              fillColor: Colors.white,
              prefixIcon: Icon(
                Icons.search,
                color: Colors.black,
              ),
            ),
            style: const TextStyle(
              color: Colors.black,
            ),
            onSubmitted: onSubmitted,
          ),
          const SizedBox(height: 5.0),
          ElevatedButton(
            onPressed: onSelectDateRange,
            child: const Text("Choisir une date"),
          ),
          if (startDate != null && endDate != null)
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 10.0),
              child: StyledBodyText(
                "Dates choisit: ${DateFormat('dd/MM/yyyy').format(startDate!)} - ${DateFormat('dd/MM/yyyy').format(endDate!)}",
                false,
                15.0,
              ),
            ),
          if (error != null)
            Text(
              error!,
              style: const TextStyle(color: Colors.red),
            ),
        ],
      ),
    );
  }
}


