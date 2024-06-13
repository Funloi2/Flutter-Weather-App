import 'dart:convert';
import 'package:http/http.dart' as http;
import '../weather.dart';


class WeatherService {
  final String apiUrl = "https://api.open-meteo.com/v1/forecast?latitude=43.6109&longitude=3.8763&hourly=temperature_2m,apparent_temperature&timezone=auto&forecast_days=1";

  Future<Weather> fetchWeatherData() async {
    final response = await http.get(Uri.parse(apiUrl));

    if (response.statusCode == 200) {
      return Weather.fromJson(json.decode(response.body));
    } else {
      throw Exception("Failed to load weather data");
    }
  }
}
