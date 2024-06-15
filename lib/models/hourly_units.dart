class HourlyUnit {
  final String time;
  final double temperature2m;
  final double apparentTemperature;
  final double rain;
  final double visibility;
  final int windDirection10m;
  final double windGusts10m;

  HourlyUnit({
    required this.time,
    required this.temperature2m,
    required this.apparentTemperature,
    required this.rain,
    required this.visibility,
    required this.windDirection10m,
    required this.windGusts10m,
  });

  factory HourlyUnit.fromJson(Map<String, dynamic> json) {
    return HourlyUnit(
      time: json['time'],
      temperature2m: json['temperature_2m'],
      apparentTemperature: json['apparent_temperature'],
      rain: json['rain'],
      visibility: json['visibility'],
      windDirection10m: json['wind_direction_10m'],
      windGusts10m: json['wind_gusts_10m'],
    );
  }
}