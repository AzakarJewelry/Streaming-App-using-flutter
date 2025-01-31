import 'package:flutter/material.dart';
import 'favorite_manager.dart'; // Import the favorite manager

class FavoriteScreen extends StatefulWidget {
  const FavoriteScreen({super.key});

  @override
  State<FavoriteScreen> createState() => _FavoriteScreenState();
}

class _FavoriteScreenState extends State<FavoriteScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Favorites'),
      ),
      body: favoriteManager.favoriteMovies.isEmpty
          ? const Center(
              child: Text('Your favorite movies will appear here.'),
            )
          : ListView.builder(
              itemCount: favoriteManager.favoriteMovies.length,
              itemBuilder: (context, index) {
                final movie = favoriteManager.favoriteMovies[index];
                return ListTile(
                  leading: Image.network(movie['imageUrl']!, width: 50, height: 50, fit: BoxFit.cover),
                  title: Text(movie['title']!),
                  subtitle: Text(movie['genre']!),
                  trailing: IconButton(
                    icon: const Icon(Icons.delete, color: Colors.red),
                    onPressed: () {
                      setState(() {
                        favoriteManager.toggleFavorite(movie);
                      });
                    },
                  ),
                );
              },
            ),
    );
  }
}
