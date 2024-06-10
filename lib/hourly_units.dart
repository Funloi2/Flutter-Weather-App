class HourlyUnits {
  final String time;
  final String temperature2m;

  HourlyUnits({
    required this.time,
    required this.temperature2m,
  });

  factory HourlyUnits.fromJson(Map<String, dynamic> json) {
    return HourlyUnits(
      time: json['time'],
      temperature2m: json['temperature_2m'],
    );
  }
}