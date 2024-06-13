class HourlyUnit {
  final String time;
  final double temperature2m;

  HourlyUnit({
    required this.time,
    required this.temperature2m,
  });

  factory HourlyUnit.fromJson(Map<String, dynamic> json) {
    return HourlyUnit(
      time: json['time'],
      temperature2m: json['temperature_2m'],
    );
  }
}