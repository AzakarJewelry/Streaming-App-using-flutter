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
        foregroundColor: isDarkMode ? Colors.white : Colors.black,
        backgroundColor: Colors.transparent,
        title: Text(
          'Search Movies or Dramas',
          style: TextStyle(color: Color(0xFF5F666C)),
        ),
      ),
      body: Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            colors: isDarkMode
                ? [
                    const Color(0xFF1F1B24), // Dark Blue
                    const Color(0xFF1F1B24),
                  ]
                : [
                    const Color(0xFFFFFFFF), // Same for light mode
                    const Color(0xFFFFFFFF),
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
                style: TextStyle(
                    color: isDarkMode ? Colors.white : Colors.black), // Typed text color based on theme
                decoration: InputDecoration(
                  hintText: 'Search for movies or dramas...',
                  hintStyle: TextStyle(color: Color(0xFF5F666C)), // Hint text color changed to 5F666C
                  enabledBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(8.0),
                    borderSide: BorderSide(
                        color: isDarkMode ? Colors.white : Colors.black), // Border color based on theme
                  ),
                  focusedBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(8.0),
                    borderSide: BorderSide(
                        color: isDarkMode ? Colors.white : Colors.black), // Border color when focused based on theme
                  ),
                  suffixIcon: _searchController.text.isNotEmpty
                      ? IconButton(
                          icon: Icon(Icons.clear,
                              color: isDarkMode ? Colors.white : Colors.black), // Icon color based on theme
                          onPressed: () {
                            _searchController.clear();
                            setState(() {
                              _searchResults = [];
                            });
                          },
                        )
                      : IconButton(
                          icon: Icon(Icons.search,
                              color: isDarkMode ? Colors.white : Colors.black), // Icon color based on theme
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
                        const Icon(Icons.movie_filter,
                            size: 80, color: Colors.grey),
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
                          color: isDarkMode
                              ? Colors.black
                              : Colors.white, // Background color based on theme
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
                              style: TextStyle(
                                fontWeight: FontWeight.bold,
                                fontSize: 16,
                                color: isDarkMode
                                    ? Colors.white
                                    : Colors.black, // Text color based on theme
                              ),
                            ),
                            subtitle: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                const SizedBox(height: 4),
                                Text(
                                  "Genre: ${movie['genre'] ?? 'N/A'}",
                                  style: TextStyle(
                                      fontSize: 14,
                                      color: isDarkMode
                                          ? Colors.white
                                          : Colors.black), // Text color based on theme
                                ),
                              ],
                            ),
                            trailing: Icon(Icons.arrow_forward_ios,
                                color: isDarkMode
                                    ? Colors.white
                                    : Colors.black), // Icon color based on theme
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
