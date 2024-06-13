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
      hourlyUnits.add(HourlyUnit(time: timeList[i], temperature2m: temp2mList[i]));
    }

    return Hourly(
      hourlyUnits: hourlyUnits,
    );
  }
}
