import 'dart:convert';

import 'package:aquatech_weather/screens/weather_search_detail.dart';
import 'package:aquatech_weather/services/geocoding_service.dart';
import 'package:aquatech_weather/style/single_weather_template.dart';
import 'package:aquatech_weather/style/styled_body_text.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'hourly_units.dart';
import 'services/api.dart';
import 'package:http/http.dart' as http;
import 'weather.dart';

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

  Future<void> _searchCity(String city) async {
    try {
      final coordinates = await GeocodingService().getCoordinatesFromCity(city);
      final weather = await WeatherService().fetchWeatherData(coordinates.latitude,
          coordinates.longitude, "2024-06-01", "2024-06-01");
      setState(() {
        _error = null;
      });
      // Navigate to the WeatherDetailScreen
      Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) => WeatherSearchScreen(weather: weather),
        ),
      );
    } catch (e) {
      setState(() {
        _error = e.toString();
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
        title: const Text("Weather App"),
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
            Container(
              margin: const EdgeInsets.all(30.0),
              child: TextField(
                controller: _controller,
                decoration: const InputDecoration(
                  hintText: "Enter a city",
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
            ),
            Center(
              child: Card(
                elevation: 8.0,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(16.0),
                ),
                margin: const EdgeInsets.all(30.0),
                child: Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: Column(
                    mainAxisSize: MainAxisSize.max,
                    children: <Widget>[
                      const Text(
                        "Montpellier",
                        style: TextStyle(
                          fontSize: 30.0,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
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
                                      return SingleWeatherTemplate(
                                        hourlyUnit.temperature2m,
                                        hourlyUnit.time,
                                        hourlyUnit,
                                      );
                                    }).toList(),
                                  ),
                                );
                              } else if (snapshot.hasError) {
                                return Text(
                                  "Error: ${snapshot.error}",
                                  style: const TextStyle(
                                    fontSize: 20.0,
                                    fontWeight: FontWeight.bold,
                                  ),
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