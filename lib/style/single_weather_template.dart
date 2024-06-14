
import 'package:aquatech_weather/style/styled_body_text.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../hourly_units.dart';
import '../screens/weather_detail_screen.dart';

class SingleWeatherTemplate extends StatelessWidget {
  const SingleWeatherTemplate(this.temperature, this.hour, this.hourlyUnit, {super.key});

  final double temperature;
  final String hour;
  final HourlyUnit hourlyUnit;

  @override
  Widget build(BuildContext context) {
    String formattedTime = formatTime(hour);

    return GestureDetector(
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => WeatherDetailScreen(hourlyUnit: hourlyUnit),
          ),
        );
      },
      child: Card(
        elevation: 6.0,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(50.0),
        ),
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: <Widget>[
              Text(
                "$temperature°C",
                style: const TextStyle(
                  fontSize: 20.0,
                  fontWeight: FontWeight.bold,
                ),
              ),
              Text(
                formattedTime,
                style: const TextStyle(
                  fontSize: 20.0,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}


String formatTime(String isoTime) {
  DateTime dateTime = DateTime.parse(isoTime);
  return "${dateTime.hour.toString().padLeft(2, '0')}:${dateTime.minute.toString().padLeft(2, '0')}";
}

