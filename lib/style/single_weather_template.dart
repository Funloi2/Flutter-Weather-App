
import 'package:aquatech_weather/style/styled_body_text.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class SingleWeatherTemplate extends StatelessWidget {
  const SingleWeatherTemplate(this.temperature, this.hour, {super.key});

  final double temperature;
  final String hour;

  @override
  Widget build(BuildContext context) {
    String formattedTime = formatTime(hour);
    return Card (
      elevation : 6.0,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(50.0),
      ),
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: <Widget>[
            StyledBodyText("$temperature°C", true, 15.0),
            StyledBodyText(formattedTime, false, 15.0),
          ],
        ),
      ),
    );
  }
}

String formatTime(String isoTime) {
  DateTime dateTime = DateTime.parse(isoTime);
  return "${dateTime.hour.toString().padLeft(2, '0')}:${dateTime.minute.toString().padLeft(2, '0')}";
}

