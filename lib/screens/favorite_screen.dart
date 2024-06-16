import 'package:aquatech_weather/screens/ui/favorite_city_tile.dart';
import 'package:flutter/material.dart';
import '../services/favoriteService.dart';
import '../style/styled_body_text.dart';

class FavoritesScreen extends StatefulWidget {
  @override
  _FavoritesScreenState createState() => _FavoritesScreenState();
}

class _FavoritesScreenState extends State<FavoritesScreen> {
  late Future<List<String>> _favoriteCities;

  @override
  void initState() {
    super.initState();
    _favoriteCities = FavoritesManager.getFavoriteCities();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Favorite Cities"),
        centerTitle: true,
        flexibleSpace: Container(
          decoration: const BoxDecoration(
            gradient: LinearGradient(
              colors: [
                Color.fromARGB(255, 43, 196, 229),
                Color.fromARGB(255, 24, 109, 127)
              ],
            ),
          ),
        ),
      ),
      body: Container(
        // graadient background
          decoration: const BoxDecoration(
            gradient: LinearGradient(
              colors: [
                Color.fromARGB(255, 43, 196, 229),
                Color.fromARGB(255, 24, 109, 127)
              ],
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
            ),
          ),
          child:
          FutureBuilder<List<String>>(
        future: _favoriteCities,
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          } else if (snapshot.hasError) {
            return Center(
                child: StyledBodyText('Error: ${snapshot.error}', false, 20.0));
          } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
            return const Center(
                child: StyledBodyText('No favorite cities added.', true, 20.0));
          } else {
            return ListView.builder(
              itemCount: snapshot.data!.length,
              itemBuilder: (context, index) {
                String city = snapshot.data![index];
                return Card(
                  elevation: 8.0,
                  margin: const EdgeInsets.all(8.0),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(8.0),
                  ),
                  child: FavoriteCityTile(
                    city: city,
                    onRemove: () {
                      setState(() {
                        _favoriteCities = FavoritesManager.getFavoriteCities();
                      });
                    },
                  ),
                );
              },
            );
          }
        },
      )),
    );
  }
}
