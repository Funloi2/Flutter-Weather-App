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
        title: Text("Weather App"),
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
                  Text("Timezone Abbreviation: ${snapshot.data!.timezoneAbbreviation}"),
                  Text("Elevation: ${snapshot.data!.elevation}"),
                  Text("Hourly Units: ${snapshot.data!.hourlyUnits.time}, ${snapshot.data!.hourlyUnits.temperature2m}"),
                  Text("Hourly: ${snapshot.data!.hourly.time}, ${snapshot.data!.hourly.temperature2m}"),
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
