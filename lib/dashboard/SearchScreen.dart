import 'package:azakarstream/dashboard/movie_details_screen.dart';
import 'package:flutter/material.dart';
import 'play_drama_screen.dart';
import 'dart:async';

class SearchScreen extends StatefulWidget {
  final List<Map<String, dynamic>> allMovies;

  const SearchScreen({super.key, required this.allMovies});

  @override
  _SearchScreenState createState() => _SearchScreenState();
}

class _SearchScreenState extends State<SearchScreen> {
  final TextEditingController _searchController = TextEditingController();
  List<Map<String, dynamic>> _searchResults = [];
  Timer? _debounce;

  void _searchMovies(String query) {
    if (_debounce?.isActive ?? false) _debounce!.cancel();
    _debounce = Timer(const Duration(milliseconds: 300), () {
      setState(() {
        _searchResults = widget.allMovies
            .where((movie) =>
                movie['title']!.toLowerCase().contains(query.toLowerCase()))
            .toList();
      });
    });
  }

  @override
  void dispose() {
    _debounce?.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    bool isDarkMode = Theme.of(context).brightness == Brightness.dark;

    return Scaffold(
      appBar: AppBar(
        foregroundColor: Colors.white,
        backgroundColor: Colors.transparent,
        title: const Text('Search Movies or Dramas', style: TextStyle(color: Colors.white)),
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
                    const Color(0xFF06041F), // Same for light mode
                    const Color(0xFF06041F),
                  ],
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
          ),
        ),
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.all(16.0),
              child: TextField(
                controller: _searchController,
                style: const TextStyle(color: Colors.white), // Typed text is white
                decoration: InputDecoration(
                  hintText: 'Search for movies or dramas...',
                  hintStyle: const TextStyle(color: Colors.white), // Hint text is white
                  enabledBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(8.0),
                    borderSide: const BorderSide(color: Colors.white), // White border
                  ),
                  focusedBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(8.0),
                    borderSide: const BorderSide(color: Colors.white), // White border when focused
                  ),
                  suffixIcon: _searchController.text.isNotEmpty
                      ? IconButton(
                          icon: const Icon(Icons.clear, color: Colors.white), // White icon
                          onPressed: () {
                            _searchController.clear();
                            setState(() {
                              _searchResults = [];
                            });
                          },
                        )
                      : IconButton(
                          icon: const Icon(Icons.search, color: Colors.white), // White icon
                          onPressed: () {
                            _searchMovies(_searchController.text);
                          },
                        ),
                ),
                onChanged: (value) {
                  _searchMovies(value);
                },
              ),
            ),
            Expanded(
              child: _searchResults.isEmpty && _searchController.text.isNotEmpty
                  ? Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        const Icon(Icons.movie_filter, size: 80, color: Colors.grey),
                        const SizedBox(height: 10),
                        const Text(
                          'No movies found!',
                          style: TextStyle(fontSize: 18, color: Colors.grey),
                        ),
                      ],
                    )
                  : ListView.builder(
                      itemCount: _searchResults.length,
                      itemBuilder: (context, index) {
                        final movie = _searchResults[index];
                        return Card(
                          color: Colors.black, // Dark background for movie item
                          margin: const EdgeInsets.symmetric(
                              vertical: 8.0, horizontal: 16.0),
                          elevation: 4,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(12),
                          ),
                          child: ListTile(
                            contentPadding: const EdgeInsets.all(16.0),
                            leading: movie['imageUrl'] != null &&
                                    movie['imageUrl']!.isNotEmpty
                                ? ClipRRect(
                                    borderRadius: BorderRadius.circular(8.0),
                                    child: Image.network(
                                      movie['imageUrl']!,
                                      width: 60,
                                      height: 90,
                                      fit: BoxFit.cover,
                                    ),
                                  )
                                : Container(
                                    width: 60,
                                    height: 90,
                                    color: Colors.grey[300],
                                    child: const Icon(
                                      Icons.movie,
                                      size: 40,
                                      color: Colors.grey,
                                    ),
                                  ),
                            title: Text(
                              movie['title'] ?? 'Unknown',
                              style: const TextStyle(
                                fontWeight: FontWeight.bold,
                                fontSize: 16,
                                color: Colors.white, // White text
                              ),
                            ),
                            subtitle: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                const SizedBox(height: 4),
                                Text(
                                  "Genre: ${movie['genre'] ?? 'N/A'}",
                                  style: const TextStyle(fontSize: 14, color: Colors.white70),
                                ),
                              ],
                            ),
                            trailing: const Icon(Icons.arrow_forward_ios, color: Colors.white), // White icon
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
                                      description:
                                          'This is a detailed description of the movie ${movie['title']!}.',
                                      imageUrl: movie['imageUrl']!,
                                      videoUrl: movie['videoUrl']!,
                                      duration: movie['duration']!,
                                      rating: movie['rating']!,
                                    ),
                                  ),
                                );
                              }
                            },
                          ),
                        );
                      },
                    ),
            ),
          ],
        ),
      ),
    );
  }
}
