import 'package:flutter/material.dart';
import '../services/favoriteService.dart';


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
      ),
      body: FutureBuilder<List<String>>(
        future: _favoriteCities,
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          } else if (snapshot.hasError) {
            return Center(child: Text('Error: ${snapshot.error}'));
          } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
            return const Center(child: Text('No favorite cities added.'));
          } else {
            return ListView.builder(
              itemCount: snapshot.data!.length,
              itemBuilder: (context, index) {
                String city = snapshot.data![index];
                return ListTile(
                  title: Text(city),
                  trailing: IconButton(
                    icon: const Icon(Icons.delete),
                    onPressed: () async {
                      await FavoritesManager.removeFavoriteCity(city);
                      setState(() {
                        _favoriteCities = FavoritesManager.getFavoriteCities();
                      });
                      ScaffoldMessenger.of(context).showSnackBar(
                        SnackBar(content: Text('$city retiré des favoris')),
                      );
                    },
                  ),
                );
              },
            );
          }
        },
      ),
    );
  }
}
