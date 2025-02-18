import 'package:flutter/material.dart';
import 'play_movie_screen.dart';
import 'favorite_manager.dart'; // Ensure this is implemented

class MovieDetailsScreen extends StatefulWidget {
  final String title;
  final String genre;
  final String duration;
  final String rating;
  final String description;
  final String imageUrl;
  final String videoUrl;

  const MovieDetailsScreen({
    super.key,
    required this.title,
    required this.genre,
    required this.duration,
    required this.rating,
    required this.description,
    required this.imageUrl,
    required this.videoUrl,
  });

  @override
  State<MovieDetailsScreen> createState() => _MovieDetailsScreenState();
}

class _MovieDetailsScreenState extends State<MovieDetailsScreen> {
  @override
  Widget build(BuildContext context) {
    // Debug print to verify theme brightness
    print('MovieDetailsScreen brightness: ${Theme.of(context).brightness}');

    final bool isFavorite = favoriteManager.isFavorite(widget.title);

    return Scaffold(
      // Force black background for testing
      backgroundColor: Colors.black,
      body: CustomScrollView(
        slivers: [
          SliverAppBar(
            expandedHeight: 400,
            floating: false,
            pinned: true,
            // Force appBar color to a dark color
            backgroundColor: Colors.grey[900],
            leading: IconButton(
              icon: const Icon(Icons.arrow_back, color: Colors.white),
              onPressed: () => Navigator.pop(context),
            ),
            flexibleSpace: FlexibleSpaceBar(
              background: Image.network(
                widget.imageUrl,
                fit: BoxFit.cover,
              ),
            ),
          ),
          SliverToBoxAdapter(
            child: Padding(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  // Title & Favorite Button
                  Row(
                    children: [
                      Expanded(
                        child: Text(
                          widget.title,
                          style: const TextStyle(
                            color: Colors.white,
                            fontSize: 24,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                      IconButton(
                        icon: Icon(
                          isFavorite ? Icons.favorite : Icons.favorite_border,
                          color: isFavorite ? Colors.red : Colors.white,
                          size: 30,
                        ),
                        onPressed: () async {
                          setState(() {
                             favoriteManager.toggleFavorite({
                              'title': widget.title,
                              'genre': widget.genre,
                              'duration': widget.duration,
                              'rating': widget.rating,
                              'description': widget.description,
                              'imageUrl': widget.imageUrl,
                              'videoUrl': widget.videoUrl,
                            });
                          });
                        },
                      ),
                    ],
                  ),
                  const SizedBox(height: 8),
                  // Genre
                  Text(
                    widget.genre,
                    style: const TextStyle(
                      color: Colors.white70,
                      fontSize: 16,
                    ),
                    textAlign: TextAlign.center,
                  ),
                  const SizedBox(height: 8),
                  // Duration & Rating
                  Column(
                    children: [
                      Text(
                        widget.duration,
                        style: const TextStyle(
                          color: Colors.white70,
                          fontSize: 16,
                        ),
                      ),
                      const SizedBox(height: 4),
                      Text(
                        widget.rating,
                        style: const TextStyle(
                          color: Colors.amber,
                          fontSize: 16,
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 16),
                  // Description
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 16.0),
                    child: Text(
                      widget.description,
                      style: const TextStyle(
                        color: Colors.white,
                        fontSize: 16,
                      ),
                      textAlign: TextAlign.center,
                    ),
                  ),
                  const SizedBox(height: 80),
                ],
              ),
            ),
          ),
        ],
      ),
      floatingActionButton: FloatingActionButton.extended(
        onPressed: () {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => PlayMovie(videoUrl: widget.videoUrl),
            ),
          );
        },
        backgroundColor: const Color(0xFF1A4D2E),
        icon: const Icon(Icons.play_arrow, color: Colors.white),
        label: const Text('Play Movie', style: TextStyle(color: Colors.white)),
      ),
    );
  }
}
