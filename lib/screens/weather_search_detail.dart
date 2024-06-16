import 'package:aquatech_weather/style/styled_body_text.dart';
import 'package:flutter/material.dart';
import '../models/weather.dart';
import '../services/favoriteService.dart';
import '../services/utils.dart';

class WeatherSearchScreen extends StatelessWidget {
  final Weather weather;
  final String cityName;


  const WeatherSearchScreen({Key? key, required this.weather, required this.cityName})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const StyledBodyText("Détail météo", true, 30.0),
        actions: [
          IconButton(
            icon: const Icon(Icons.favorite, color: Colors.white,),
            onPressed: () async {
              await FavoritesManager.addFavoriteCity(cityName);
              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(content: StyledBodyText('$cityName ajouté aux favoris',
                    false, 15.0)),
              );
            },
          ),
        ],
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
        child: ListView.builder(
          padding: const EdgeInsets.all(16.0),
          itemCount: weather.hourly.hourlyUnits.length,
          itemBuilder: (context, index) {
            final hourlyUnit = weather.hourly.hourlyUnits[index];

            return Card(
              elevation: 4.0,
              margin: const EdgeInsets.symmetric(vertical: 8.0),
              child: ListTile(
                title: StyledBodyText(formatTimeFull(hourlyUnit.time), true, 25.0),
                subtitle: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Container(
                      margin: const EdgeInsets.only(top: 8.0),
                      child: Row(
                        children: [
                          const Icon(Icons.thermostat_outlined),
                          const SizedBox(width: 5.0),
                          StyledBodyText(
                              "Temperature: ${hourlyUnit.temperature2m}°C",
                              false,
                              20.0),
                        ],
                      ),
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
                  ],
                ),
              ),
            );
          },
        ),
      ),
    );
  }
}



