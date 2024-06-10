import 'dart:convert';
import 'package:http/http.dart' as http;
import '../Weather.dart';


class WeatherService {
  final String apiUrl = "https://api.open-meteo.com/v1/forecast?latitude=43.6109&longitude=3.8763&hourly=temperature_2m&timezone=auto";

  Future<WeatherResponse> fetchWeatherData() async {
    final response = await http.get(Uri.parse(apiUrl));

    if (response.statusCode == 200) {
      return WeatherResponse.fromJson(json.decode(response.body));
    } else {
      throw Exception("Failed to load weather data");
    }
  }
}
