class Hourly {
  final List<String> time;
  final List<double> temperature2m;

  Hourly({
    required this.time,
    required this.temperature2m,
  });

  factory Hourly.fromJson(Map<String, dynamic> json) {
    return Hourly(
      time: List<String>.from(json['time']),
      temperature2m: List<double>.from(json['temperature_2m']),
    );
  }
}