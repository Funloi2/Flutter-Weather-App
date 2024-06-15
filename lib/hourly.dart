import 'hourly_units.dart';

class Hourly {
  final List<HourlyUnit> hourlyUnits;

  Hourly({
    required this.hourlyUnits,
  });

  factory Hourly.fromJson(Map<String, dynamic> json) {
    var timeList = List<String>.from(json['time']);
    var temp2mList = List<double>.from(json['temperature_2m']);


    List<HourlyUnit> hourlyUnits = [];
    for (int i = 0; i < timeList.length; i++) {
      hourlyUnits.add(HourlyUnit(time: timeList[i],
          temperature2m: temp2mList[i],
          apparentTemperature: json['apparent_temperature'][i],
          rain: json['rain'][i],
          visibility: json['visibility'][i],
          wind_direction_10m: json['wind_direction_10m'][i],
          wind_gusts_10m: json['wind_gusts_10m'][i]));
    }

    return Hourly(
      hourlyUnits: hourlyUnits,
    );
  }
}
