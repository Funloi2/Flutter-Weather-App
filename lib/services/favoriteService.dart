import 'package:shared_preferences/shared_preferences.dart';

class FavoritesManager {
  static const String _favoritesKey = 'favorite_cities';

  static Future<void> addFavoriteCity(String city) async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    List<String>? favorites = prefs.getStringList(_favoritesKey) ?? [];
    if (!favorites.contains(city)) {
      favorites.add(city);
      await prefs.setStringList(_favoritesKey, favorites);
    }
  }

  static Future<void> removeFavoriteCity(String city) async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    List<String>? favorites = prefs.getStringList(_favoritesKey) ?? [];
    if (favorites.contains(city)) {
      favorites.remove(city);
      await prefs.setStringList(_favoritesKey, favorites);
    }
  }

  static Future<List<String>> getFavoriteCities() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    return prefs.getStringList(_favoritesKey) ?? [];
  }
}

