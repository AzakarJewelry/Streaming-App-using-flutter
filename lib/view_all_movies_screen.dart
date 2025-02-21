import 'package:flutter/material.dart';
import 'movie_details_screen.dart';

class ViewAllMoviesScreen extends StatelessWidget {
  final List<Map<String, String>> movies;

  const ViewAllMoviesScreen({super.key, required this.movies});

  @override
  Widget build(BuildContext context) {
    final bool isDarkMode = Theme.of(context).brightness == Brightness.dark;

    return Scaffold(
      backgroundColor: isDarkMode ? Colors.black : const Color(0xFFF5EFE6),
      appBar: AppBar(
        backgroundColor: const Color(0xFF4d0066),
        foregroundColor: const Color(0xFFF5EFE6),
        title: const Text('All Movies'),
      ),
      body: LayoutBuilder(
        builder: (context, constraints) {
          int crossAxisCount = constraints.maxWidth > 600 ? 4 : 2;

          return GridView.builder(
            padding: const EdgeInsets.all(16.0),
            gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: crossAxisCount,
              crossAxisSpacing: 16.0,
              mainAxisSpacing: 16.0,
              childAspectRatio: 0.65,
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
                        genre: movie['genre']!,
                        duration: movie['duration']!,
                        rating: movie['rating']!,
                        description:
                            'This is a detailed description of the movie ${movie['title']}.',
                        imageUrl: movie['imageUrl']!,
                        videoUrl: movie['videoUrl']!,
                      ),
                    ),
                  );
                },
                child: Card(
                  color: isDarkMode ? Colors.grey[900] : Colors.white, // Dark mode color
                  elevation: 4,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(15),
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Expanded(
                        child: Container(
                          decoration: BoxDecoration(
                            borderRadius: const BorderRadius.vertical(
                              top: Radius.circular(15),
                            ),
                            image: DecorationImage(
                              image: NetworkImage(movie['imageUrl']!),
                              fit: BoxFit.cover,
                            ),
                          ),
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              movie['title']!,
                              maxLines: 1,
                              overflow: TextOverflow.ellipsis,
                              style: TextStyle(
                                color: isDarkMode ? Colors.white : const Color(0xFF4d0066),
                                fontWeight: FontWeight.bold,
                                fontSize: 14,
                              ),
                            ),
                            const SizedBox(height: 4),
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
                                Flexible(
                                  child: Text(
                                    movie['reviews']!,
                                    maxLines: 1,
                                    overflow: TextOverflow.ellipsis,
                                    style: TextStyle(
                                      color: isDarkMode
                                          ? Colors.white70
                                          : const Color(0xFF4d0066).withOpacity(0.5),
                                      fontSize: 12,
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ],
                        ),
                      ),
                    ],
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
