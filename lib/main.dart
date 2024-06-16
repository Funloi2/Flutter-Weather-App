import 'package:aquatech_weather/screens/favorite_screen.dart';
import 'package:aquatech_weather/screens/weather_search_detail.dart';
import 'package:aquatech_weather/services/geocoding_service.dart';
import 'package:aquatech_weather/screens/ui/weather_bubble.dart';
import 'package:aquatech_weather/services/utils.dart';
import 'package:aquatech_weather/style/styled_body_text.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'models/hourly_units.dart';
import 'services/weather_service.dart';
import 'models/weather.dart';

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

  Future<void> _searchCity(String city) async {
    if (_startDate == null || _endDate == null) {
      setState(() {
        _error = "Veuillez choisir une date de début et de fin.";
      });
      return;
    }

    // Fetch coordinates from city
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

  // Show a date range picker
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
  void initState() {
    super.initState();
    futureWeather = WeatherService().fetchWeatherData(43.6109, 3.8763,"2024-06-15","2024-06-15");
  }

  @override
  Widget build(BuildContext context) {

    return Scaffold(
      backgroundColor: const Color.fromARGB(255, 43, 196, 229),
      appBar: AppBar(
        title: const Text("Application météo"),
        actions: [
          IconButton(
            icon: const Icon(Icons.favorite),
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
        // graadient background
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
            // Search bar
            Container(
              margin: const EdgeInsets.only(top: 20.0, left: 20.0, right: 20.0),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  TextField(
                    controller: _controller,
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
                    onSubmitted: (value) {
                      _searchCity(value);
                    },
                  ),
                  const SizedBox(height: 5.0),
                  ElevatedButton(
                    onPressed: () => _selectDateRange(context),
                    child: const Text("Choisir une date"),
                  ),
                  if (_startDate != null && _endDate != null)
                    Padding(
                      padding: const EdgeInsets.symmetric(vertical: 10.0),
                      child: StyledBodyText(
                        "Dates choisit: ${DateFormat('dd/MM/yyyy').format(_startDate!)} "
                            "- ${DateFormat('dd/MM/yyyy').format(_endDate!)}",
                        false,
                        15.0
                      ),
                    ),
                  _error != null
                      ? Text(
                    _error!,
                    style: const TextStyle(color: Colors.red),
                  )
                      : Container(),
                ],
              ),
            ),
            // Weather card
            Center(
              child: Card(
                elevation: 8.0,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(16.0),
                ),
                margin: const EdgeInsets.only(top: 10.0, left: 20.0, right: 20.0),
                child: Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: Column(
                    // Default city
                    mainAxisSize: MainAxisSize.max,
                    children: <Widget>[
                      const StyledBodyText("Montpellier", true, 25),
                      const Divider(),
                      Container(
                        margin: const EdgeInsets.only(top: 15.0, bottom: 15.0),
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(16.0),
                          gradient: const LinearGradient(
                            colors: [
                              Color.fromARGB(255, 43, 196, 229),
                              Color.fromARGB(255, 24, 109, 127),
                            ],
                            begin: Alignment.topLeft,
                            end: Alignment.bottomRight,
                          ),
                        ),
                        child: Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: FutureBuilder<Weather>(
                            future: futureWeather,
                            builder: (context, snapshot) {
                              if (snapshot.hasData) {
                                List<HourlyUnit> hourlyUnits = snapshot.data!.hourly.hourlyUnits;
                                return SingleChildScrollView(
                                  scrollDirection: Axis.horizontal,
                                  child: Row(
                                    children: hourlyUnits.map((hourlyUnit) {
                                      return WeatherBubble(
                                        hourlyUnit.temperature2m,
                                        hourlyUnit.time,
                                        hourlyUnit,
                                      );
                                    }).toList(),
                                  ),
                                );
                              } else if (snapshot.hasError) {
                                return StyledBodyText(
                                  "Erreur: ${snapshot.error}",
                                  false,
                                  20.0,
                                );
                              }
                              return const CircularProgressIndicator();
                            },
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ],
        )

      ),
    );
  }
}