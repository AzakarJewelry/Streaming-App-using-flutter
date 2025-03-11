import 'package:azakarstream/dashboard/movie_details_screen.dart';
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
    bool isDarkMode = Theme.of(context).brightness == Brightness.dark;

    return Scaffold(
      appBar: AppBar(
        title: const Text('Search Movies'),
      ),
      body: Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            colors: isDarkMode
                ? [
                    const Color(0xFF660066),
                    const Color(0xFF4d004d),
                    const Color(0xFF330033),
                    const Color(0xFF1a001a),
                    const Color(0xFF993366),
                    const Color(0xFF000000),
                  ]
                : [
                    const Color(0xFFf9e6ff),
                    const Color(0xFFf9e6ff),
                    const Color(0xFFf2ccff),
                    const Color(0xFFecb3ff),
                    const Color(0xFFe699ff),
                    const Color(0xFFdf80ff),
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
                decoration: InputDecoration(
                  hintText: 'Search for movies...',
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(8.0),
                  ),
                  suffixIcon: IconButton(
                    icon: const Icon(Icons.search),
                    onPressed: () {
                      _searchMovies(_searchController.text);
                    },
                  ),
                ),
                // This callback will trigger every time the text changes.
                onChanged: (value) {
                  _searchMovies(value);
                },
              ),
            ),
            Expanded(
              child: _searchResults.isEmpty && _searchController.text.isNotEmpty
                  ? const Center(
                      child: Text(
                        'No movies found!',
                        style: TextStyle(fontSize: 18, color: Colors.grey),
                      ),
                    )
                  : ListView.builder(
                      itemCount: _searchResults.length,
                      itemBuilder: (context, index) {
                        final movie = _searchResults[index];
                        return Card(
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
                              movie['title']!,
                              style: const TextStyle(
                                fontWeight: FontWeight.bold,
                                fontSize: 16,
                              ),
                            ),
                            subtitle: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                const SizedBox(height: 4),
                                Text(
                                  "Genre: ${movie['genre']}",
                                  style: const TextStyle(fontSize: 14),
                                ),
                                const SizedBox(height: 4),
                                Text(
                                  "Rating: ${movie['rating']}",
                                  style: const TextStyle(fontSize: 14),
                                ),
                                const SizedBox(height: 4),
                                Text(
                                  "Duration: ${movie['duration']}",
                                  style: const TextStyle(fontSize: 14),
                                ),
                              ],
                            ),
                            trailing: const Icon(Icons.arrow_forward_ios),
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
                                        'This is a detailed description of the movie ${movie['title']!}.',
                                    imageUrl: movie['imageUrl']!,
                                    videoUrl: movie['videoUrl']!,
                                  ),
                                ),
                              );
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
