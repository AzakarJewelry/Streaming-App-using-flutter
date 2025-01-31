import 'package:flutter/material.dart';
import 'movie_details_screen.dart';

class ViewAllMoviesScreen extends StatelessWidget {
  final List<Map<String, String>> movies;

  const ViewAllMoviesScreen({super.key, required this.movies});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF5EFE6),
      appBar: AppBar(
        backgroundColor: const Color(0xFF1A4D2E),
        foregroundColor: const Color(0xFFF5EFE6),
        title: const Text('All Movies'),
      ),
      body: GridView.builder(
        padding: const EdgeInsets.all(16.0),
        gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 2,
          crossAxisSpacing: 16.0,
          mainAxisSpacing: 16.0,
          childAspectRatio: 0.7,
        ),
        itemCount: movies.length,
        itemBuilder: (context, index) {
          final movie = movies[index];
          return GestureDetector(
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => MovieDetailsScreen(
                    title: movie['title']!,
                    imageUrl: movie['imageUrl']!,
                    description: 'This is a detailed description of the movie ${movie['title']}.',
                  ),
                ),
              );
            },
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Expanded(
                  child: Container(
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(15),
                      image: DecorationImage(
                        image: NetworkImage(movie['imageUrl']!),
                        fit: BoxFit.cover,
                      ),
                    ),
                  ),
                ),
                const SizedBox(height: 8),
                Text(
                  movie['title']!,
                  style: const TextStyle(
                    color: Color(0xFF1A4D2E),
                    fontWeight: FontWeight.bold,
                  ),
                ),
                Row(
                  children: [
                    Text(
                      movie['rating']!,
                      style: const TextStyle(
                        color: Color(0xFFF3C63F),
                        fontSize: 12,
                      ),
                    ),
                    const SizedBox(width: 5),
                    Text(
                      movie['reviews']!,
                      style: TextStyle(
                        color: const Color(0xFF1A4D2E).withOpacity(0.5),
                        fontSize: 12,
                      ),
                    ),
                  ],
                ),
              ],
            ),
          );
        },
      ),
    );
  }
}