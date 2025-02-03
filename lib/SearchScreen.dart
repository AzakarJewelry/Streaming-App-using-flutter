import 'package:azakarstream/movie_details_screen.dart';
import 'package:flutter/material.dart';

class SearchScreen extends StatefulWidget {
  final List<Map<String, String>> allMovies;

  const SearchScreen({super.key, required this.allMovies});

  @override
  _SearchScreenState createState() => _SearchScreenState();
}

class _SearchScreenState extends State<SearchScreen> {
  final TextEditingController _searchController = TextEditingController();
  List<Map<String, String>> _searchResults = [];

  void _searchMovies(String query) {
    setState(() {
      _searchResults = widget.allMovies
          .where((movie) =>
              movie['title']!.toLowerCase().contains(query.toLowerCase()))
          .toList();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Search Movies'),
      ),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: TextField(
              controller: _searchController,
              decoration: InputDecoration(
                hintText: 'Search for movies...',
                suffixIcon: IconButton(
                  icon: const Icon(Icons.search),
                  onPressed: () {
                    _searchMovies(_searchController.text);
                  },
                ),
              ),
              onSubmitted: (value) {
                _searchMovies(value);
              },
            ),
          ),
          Expanded(
            child: ListView.builder(
              itemCount: _searchResults.length,
              itemBuilder: (context, index) {
                final movie = _searchResults[index];
                return ListTile(
                  title: Text(movie['title']!),
                  subtitle: Text(movie['genre']!),
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => MovieDetailsScreen(
                          title: movie['title']!,
                          genre: movie['genre']!,
                          duration: movie['duration']!,
                          rating: movie['rating']!,
                          description: 'This is a detailed description of the movie ${movie['title']!}.',
                          imageUrl: movie['imageUrl']!,
                        ),
                      ),
                    );
                  },
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}