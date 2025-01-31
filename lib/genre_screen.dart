import 'package:flutter/material.dart';
import 'movie_details_screen.dart';

class GenreScreen extends StatelessWidget {
  final String genre;
  final List<Map<String, String>> allMovies;

  const GenreScreen({super.key, required this.genre, this.allMovies = const []});

  @override
  Widget build(BuildContext context) {
    // Filter movies based on the selected genre
    final filteredMovies = allMovies.where((movie) => movie['genre'] == genre).toList();

    return Scaffold(
      appBar: AppBar(
        title: Text('$genre Movies'),
      ),
      body: ListView.builder(
        itemCount: filteredMovies.length,
        itemBuilder: (context, index) {
          final movie = filteredMovies[index];
          return ListTile(
            leading: Image.network(movie['imageUrl']!),
            title: Text(movie['title']!),
            subtitle: Text('${movie['rating']} ${movie['reviews']}'),
            onTap: () {
              // Navigate to movie details screen
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => MovieDetailsScreen(
                    title: movie['title']!,
                    genre: movie['genre']!,
                    duration: movie['duration']!,
                    rating: movie['rating']!,
                    description: 'This is a detailed description of the movie ${movie['title']}.',
                    imageUrl: movie['imageUrl']!,
                  ),
                ),
              );
Navigator.pushReplacement(
  context,
  MaterialPageRoute(
    builder: (context) => MovieDetailsScreen(
      title: movie['title']!,
      genre: movie['genre']!,
      duration: movie['duration']!,
      rating: movie['rating']!,
      description: 'This is a detailed description of the movie ${movie['title']}.',
      imageUrl: movie['imageUrl']!,
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