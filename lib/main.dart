import 'package:aquatech_weather/style/single_weather_template.dart';
import 'package:aquatech_weather/style/styled_body_text.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'services/api.dart';
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

  @override
  void initState() {
    super.initState();
    futureWeather = WeatherService().fetchWeatherData();
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
        child: Center(
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
                    child: const Padding(
                      padding: EdgeInsets.all(16.0),
                      child: Text("text"),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
