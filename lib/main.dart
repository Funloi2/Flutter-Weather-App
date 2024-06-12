import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
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
            ),
          ),
          child: Padding(
              padding: const EdgeInsets.all(16.0),
              child: Center(
                child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      // TODO : Set main card white background color and display data into it
                      Container (
                        decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(10),
                        ),
                      )
                    ]),
              ))),
    );
  }
}
