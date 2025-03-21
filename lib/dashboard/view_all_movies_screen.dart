import 'package:flutter/material.dart';
import 'movie_details_screen.dart';
import 'play_drama_screen.dart';

class ViewAllMoviesScreen extends StatelessWidget {
  final List<Map<String, dynamic>> movies;

  const ViewAllMoviesScreen({super.key, required this.movies});

  @override
  Widget build(BuildContext context) {
    final bool isDarkMode = Theme.of(context).brightness == Brightness.dark;

    return Scaffold(
      backgroundColor: isDarkMode ? Color(0xFF06041f) : Color(0xFFFFFFFF), // Dark theme background
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        foregroundColor: isDarkMode ? Colors.white : Colors.black, // White icons and text for dark mode, black for light mode
        title: Text(
          'All Movies',
          style: TextStyle(
        color: isDarkMode ? Colors.white : Colors.black, // White text for dark mode, black for light mode
          ),
        ),
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
                  if (movie['type'] == 'featured') {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => PlayDramaScreen(
                          videoList: (movie['videoList'] as List<dynamic>).cast<String>(),
                          title: movie['title']!,
                        ),
                      ),
                    );
                  } else {
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
                  }
                },
                child: Card(
                  color: const Color(0xFF6152FF), // Changed to 6152FF
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
                        child: Text(
                          movie['title']!,
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
                          style: const TextStyle(
                            color: Colors.white, // White text for dark mode
                            fontWeight: FontWeight.bold,
                            fontSize: 14,
                          ),
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
