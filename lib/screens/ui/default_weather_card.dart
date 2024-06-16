import 'package:aquatech_weather/screens/ui/weather_bubble.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../../models/hourly_units.dart';
import '../../models/weather.dart';
import '../../style/styled_body_text.dart';

class DefaultWeatherCard extends StatelessWidget {
  final Future<Weather> futureWeather;

  const DefaultWeatherCard({
    required this.futureWeather,
  });

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Card(
        elevation: 8.0,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(16.0),
        ),
        margin: const EdgeInsets.only(top: 10.0, left: 20.0, right: 20.0),
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            mainAxisSize: MainAxisSize.max,
            children: <Widget>[
              const StyledBodyText("Montpellier", true, 25),
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
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: FutureBuilder<Weather>(
                    future: futureWeather,
                    builder: (context, snapshot) {
                      if (snapshot.hasData) {
                        List<HourlyUnit> hourlyUnits = snapshot.data!.hourly.hourlyUnits;
                        return SingleChildScrollView(
                          scrollDirection: Axis.horizontal,
                          child: Row(
                            children: hourlyUnits.map((hourlyUnit) {
                              return WeatherBubble(
                                hourlyUnit.temperature2m,
                                hourlyUnit.time,
                                hourlyUnit,
                              );
                            }).toList(),
                          ),
                        );
                      } else if (snapshot.hasError) {
                        return StyledBodyText(
                          "Erreur: ${snapshot.error}",
                          false,
                          20.0,
                        );
                      }
                      return const CircularProgressIndicator();
                    },
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}