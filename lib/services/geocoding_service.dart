import 'dart:convert';
import 'package:http/http.dart' as http;

class GeocodingService {
  final String apiUrl = "https://geocoding-api.open-meteo.com/v1/search";

  Future<Coordinates> getCoordinatesFromCity(String city) async {
    final response = await http.get(Uri.parse('$apiUrl?name=$city'));

    if (response.statusCode == 200) {
      final data = json.decode(response.body);
      if (data['results'] != null && data['results'].isNotEmpty) {
        final result = data['results'][0];
        return Coordinates(result['latitude'], result['longitude']);
      } else {
        throw Exception("Ville non trouvée");
      }
    } else {
      throw Exception("Erreur lors de la recherche de la ville");
    }
  }
}

class Coordinates {
  final double latitude;
  final double longitude;

  Coordinates(this.latitude, this.longitude);
}
