import 'dart:convert';
import 'package:http/http.dart' as http;
import '../weather.dart';

class WeatherService {
  final String apiUrl = "https://api.open-meteo.com/v1/forecast";

  Future<Weather> fetchWeatherData(double latitude, double longitude) async {
    final response = await http.get(Uri.parse('$apiUrl?latitude=$latitude&longitude=$longitude&hourly=temperature_2m,apparent_temperature,rain,visibility,wind_direction_10m,wind_gusts_10m&forecast_days=1'));

    if (response.statusCode == 200) {
      return Weather.fromJson(json.decode(response.body));
    } else {
      throw Exception("Failed to load weather data");
    }
  }
}
