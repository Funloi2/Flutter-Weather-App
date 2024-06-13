
import 'package:aquatech_weather/style/styled_body_text.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class SingleWeatherTemplate extends StatelessWidget {
  const SingleWeatherTemplate(this.temperature, this.hour, {super.key});

  final double temperature;
  final String hour;

  @override
  Widget build(BuildContext context) {
    return Card (
      elevation : 6.0,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(30.0),
      ),
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: <Widget>[
            StyledBodyText("$temperature°C", true, 20.0),
            const Divider(),
            StyledBodyText(hour, true, 20.0),
          ],
        ),
      ),
    );
  }
}
