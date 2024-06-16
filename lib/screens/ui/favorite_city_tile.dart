import 'package:flutter/material.dart';
import '../../services/favoriteService.dart';

class FavoriteCityTile extends StatelessWidget {
  final String city;
  final VoidCallback onRemove;

  const FavoriteCityTile({
    Key? key,
    required this.city,
    required this.onRemove,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ListTile(
      title: Text(city),
      trailing: IconButton(
        icon: const Icon(Icons.delete),
        onPressed: () async {
          await FavoritesManager.removeFavoriteCity(city);
          onRemove();
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(content: Text('$city retiré des favoris')),
          );
        },
      ),
    );
  }
}
