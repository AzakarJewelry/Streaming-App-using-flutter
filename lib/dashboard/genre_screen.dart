import 'package:flutter/material.dart';
import 'movie_details_screen.dart';
import 'play_drama_screen.dart'; // Add this import statement

class GenreScreen extends StatelessWidget {
  final String genre;
  final List<Map<String, dynamic>> allMovies;

  const GenreScreen({super.key, required this.genre, required this.allMovies});

  @override
  Widget build(BuildContext context) {
    final bool isDarkMode = Theme.of(context).brightness == Brightness.dark;

    // Split genres and check for exact match
    final filteredMovies = allMovies.where((movie) {
      final genres = movie['genre']!.toString().split(', ').map((g) => g.trim().toLowerCase()).toList();
      return genres.contains(genre.toLowerCase());
    }).toList();

    return Scaffold(
      appBar: AppBar(
        title: Text('$genre Movies or Dramas'),
        backgroundColor: const Color(0xFF9610ff),
        foregroundColor: const Color(0xFFF5EFE6),
      ),
      body: Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            colors: isDarkMode
              ? [
                const Color(0xFF06041F), // Dark Blue
                const Color(0xFF06041F),
              ]
            : [
                const Color(0xFFFFFFFF), // Same for light mode
                const Color(0xFFFFFFFF),
              ],
        begin: Alignment.topLeft,
        end: Alignment.bottomRight,
      ),
    ),
        child: filteredMovies.isEmpty
            ? Center(
                child: Text(
                  'No movies found in the $genre genre.',
                  style: TextStyle(
                    fontSize: 18,
                    color: isDarkMode ? Colors.white : Colors.black,
                  ),
                ),
              )
            : GridView.builder(
                padding: const EdgeInsets.all(8.0),
                gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 2,
                  crossAxisSpacing: 10,
                  mainAxisSpacing: 10,
                  childAspectRatio: 0.55,
                ),
                itemCount: filteredMovies.length,
                itemBuilder: (context, index) {
                  final movie = filteredMovies[index];
                  return GestureDetector(
                    onTap: () {
                              if (movie['type'] == 'featured') {
                                Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                    builder: (context) => PlayDramaScreen(
                                      videoList: movie['episodes']!,
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
                                    
                                      description:
                                          'This is a detailed description of the movie ${movie['title']!}.',
                                      imageUrl: movie['imageUrl']!,
                                      videoUrl: movie['videoUrl']!,
                                    ),
                                  ),
                                );
                              }
                            },
                    child: Card(
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(16),
                      ),
                      elevation: 4,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.stretch,
                        children: [
                          Expanded(
                            child: ClipRRect(
                              borderRadius: const BorderRadius.vertical(top: Radius.circular(16)),
                              child: Image.network(
                                movie['imageUrl']!,
                                fit: BoxFit.cover,
                              ),
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Text(
                              movie['title']!,
                              style: const TextStyle(
                                fontWeight: FontWeight.bold,
                                fontSize: 16,
                              ),
                              maxLines: 2,
                              overflow: TextOverflow.ellipsis,
                            ),
                          ),
                        ],
                      ),
                    ),
                  );
                },
              ),
      ),
    );
  }
}