import 'package:aquatech_weather/style/styled_body_text.dart';
import 'package:flutter/material.dart';
import '../weather.dart';

class WeatherSearchScreen extends StatelessWidget {
  final Weather weather;

  const WeatherSearchScreen({Key? key, required this.weather}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Weather Details"),
      ),
      body: ListView.builder(
        padding: const EdgeInsets.all(16.0),
        itemCount: weather.hourly.hourlyUnits.length,
        itemBuilder: (context, index) {
          final hourlyUnit = weather.hourly.hourlyUnits[index];
          final formattedTime = formatTime(hourlyUnit.time);

          return Card(
            elevation: 4.0,
            margin: const EdgeInsets.symmetric(vertical: 8.0),
            child: ListTile(
              title:StyledBodyText(formattedTime, true, 30.0),
              subtitle: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Container(
                    margin: const EdgeInsets.only(top: 8.0),
                    child: Row(
                      children: [
                        const Icon(Icons.thermostat_outlined),
                        const SizedBox(width: 5.0),
                        StyledBodyText("Temperature: ${hourlyUnit.temperature2m}°C", false, 20.0),
                      ],
                    ),
                  ),
                  StyledBodyText("Temperature ressenti: ${hourlyUnit.apparentTemperature}°C", false, 17.0),
                  StyledBodyText("Précipitaion prévue: ${hourlyUnit.rain} mm", false, 17.0),
                  StyledBodyText("Visibilité: ${formatVisibility(hourlyUnit.visibility)} m", false, 17.0),
                  StyledBodyText("Direction et vitesse du vent: ${hourlyUnit.windGusts10m} km/h "
                      "${formatWindDirection(hourlyUnit.windDirection10m)}", false, 17.0),
                ],
              ),
            ),
          );
        },
      ),
    );
  }

  String formatTime(String time) {
    final parsedTime = DateTime.parse(time);
    return "${parsedTime.day}/${parsedTime.month}/${parsedTime.year} ${parsedTime.hour}:${parsedTime.minute}0";
  }

  // Space out the visibility value to make it more readable
  String formatVisibility(double visibility) {
    return visibility.toString().replaceAllMapped(RegExp(r'(\d{1,3})(?=(\d{3})+(?!\d))'), (Match m) => '${m[1]} ');
  }
  
  //Display the wind direction in cardinal points
  String formatWindDirection(int windDirection) {
    if (windDirection >= 337.5 || windDirection < 22.5) {
      return "N";
    } else if (windDirection >= 22.5 && windDirection < 67.5) {
      return "NE";
    } else if (windDirection >= 67.5 && windDirection < 112.5) {
      return "E";
    } else if (windDirection >= 112.5 && windDirection < 157.5) {
      return "SE";
    } else if (windDirection >= 157.5 && windDirection < 202.5) {
      return "S";
    } else if (windDirection >= 202.5 && windDirection < 247.5) {
      return "SW";
    } else if (windDirection >= 247.5 && windDirection < 292.5) {
      return "W";
    } else {
      return "NW";
    }
  }
}