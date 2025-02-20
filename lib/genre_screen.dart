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
        backgroundColor: const Color(0xFF4d0066),
        foregroundColor: const Color(0xFFF5EFE6),
      ),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: GridView.builder(
          gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 2, // 2 items per row
            crossAxisSpacing: 10,
            mainAxisSpacing: 10,
            childAspectRatio: 0.55, // Adjusted for larger posters
          ),
          itemCount: filteredMovies.length,
          itemBuilder: (context, index) {
            final movie = filteredMovies[index];

            return GestureDetector(
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
                      videoUrl: movie['videoUrl']!,
                    ),
                  ),
                );
              },
              child: Card(
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(16),
                ),
                elevation: 4,
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(16),
                  child: Column(
                    children: [
                      Expanded(
                        child: Image.network(
                          movie['imageUrl']!,
                          width: double.infinity,
                          fit: BoxFit.cover,
                        ),
                      ),
                      Container(
                        color: Colors.transparent,
                        padding: const EdgeInsets.symmetric(vertical: 8, horizontal: 8),
                        child: Text(
                          movie['title']!,
                          style: const TextStyle(fontWeight: FontWeight.bold),
                          overflow: TextOverflow.ellipsis,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            );
          },
        ),
      ),
    );
  }
}
