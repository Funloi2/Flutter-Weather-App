import 'package:flutter/material.dart';
import '../models/hourly_units.dart';
import '../services/utils.dart';
import '../style/styled_body_text.dart';
import 'ui/weather_bubble.dart';

class WeatherDetailScreen extends StatelessWidget {
  final HourlyUnit hourlyUnit;

  const WeatherDetailScreen({Key? key, required this.hourlyUnit})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    String formattedTime = formatTime(hourlyUnit.time);

    return Scaffold(
      appBar: AppBar(
        title: const Text("Weather Details"),
      ),
      body: Container(
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            colors: [
              Color.fromARGB(255, 43, 196, 229),
              Color.fromARGB(255, 24, 109, 127),
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
            margin: const EdgeInsets.all(20.0),
            child: Padding(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: <Widget>[
                  Text(
                    "Temperature: ${hourlyUnit.temperature2m}°C",
                    style: const TextStyle(
                        fontSize: 20.0, fontWeight: FontWeight.bold),
                  ),
                  StyledBodyText(
                    "Heure: $formattedTime",
                    false,
                    17.0
                  ),
                  StyledBodyText(
                      "Temperature ressenti: ${hourlyUnit.apparentTemperature}°C",
                      false,
                      17.0),
                  StyledBodyText("Précipitaion: ${hourlyUnit.rain} mm",
                      false, 17.0),
                  StyledBodyText(
                      "Visibilité: ${formatVisibility(hourlyUnit.visibility)} m",
                      false,
                      17.0),
                  StyledBodyText(
                      "Direction et vitesse du vent: ${hourlyUnit.windGusts10m} km/h "
                          "${formatWindDirection(hourlyUnit.windDirection10m)}",
                      false,
                      17.0),
                  // Add more information as needed
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}

