import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:provider_test/models/favorite_model.dart';

class FavoritesPage extends StatefulWidget {
  const FavoritesPage({super.key});

  @override
  State<FavoritesPage> createState() => _FavoritesPageState();
}

class _FavoritesPageState extends State<FavoritesPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Favorites"), centerTitle: true),
      body: Consumer<FavoriteModel>(
        builder: (context, value, child) {
          var favorites = value.favorites.reversed.toList();
          return ListView.builder(
            itemCount: favorites.length,
            itemBuilder: (context, index) {
              return ListTile(
                title: Text(
                  favorites[index].body,
                  overflow: TextOverflow.ellipsis,
                ),
                subtitle: Text(favorites[index].email),
                trailing: IconButton(
                  onPressed: () {
                    value.addRemove(favorites[index]);
                  },
                  icon: Icon(
                    favorites.contains(favorites[index])
                        ? Icons.favorite
                        : Icons.favorite_border,
                  ),
                ),
              );
            },
          );
        },
      ),
    );
  }
}
