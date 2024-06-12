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
      appBar: AppBar(
        title: const Text("Weather App"),
        centerTitle: true,
          flexibleSpace: Container(
            decoration: const BoxDecoration(
              gradient: LinearGradient(
                colors: [
                  Color.fromARGB(100, 24, 109, 127),
                  Color.fromARGB(100, 33, 148, 174),
                  Color.fromARGB(100, 43, 196, 229)
                ],
                stops: [0.15, 0.25, 0.9],
                begin: Alignment.bottomRight,
                end: Alignment.bottomLeft,
              ),
            ),
          ),
      ),
      body: FutureBuilder<Weather>(
        future: futureWeather,
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            return Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  Text("Latitude: ${snapshot.data!.latitude}"),
                  Text("Longitude: ${snapshot.data!.longitude}"),
                  Text("Generation Time: ${snapshot.data!.generationTimeMs}"),
                  Text("UTC Offset: ${snapshot.data!.utcOffsetSeconds}"),
                  Text("Timezone: ${snapshot.data!.timezone}"),
                  Text(
                      "Timezone Abbreviation: ${snapshot.data!.timezoneAbbreviation}"),
                  Text("Elevation: ${snapshot.data!.elevation}"),
                  Text(
                      "Hourly Units: ${snapshot.data!.hourlyUnits.time}, ${snapshot.data!.hourlyUnits.temperature2m}"),
                  Text(
                      "Hourly: ${snapshot.data!.hourly.time}, ${snapshot.data!.hourly.temperature2m}"),
                ],
              ),
            );
          } else if (snapshot.hasError) {
            return Center(
              child: Text("${snapshot.error}"),
            );
          }

          return Center(
            child: CircularProgressIndicator(),
          );
        },
      ),
    );
  }
}
