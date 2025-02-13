import 'package:flutter/material.dart';
import 'dashboard_screen.dart';
import 'favorites_screen.dart';
import 'profile_screen.dart';
import 'play_movie_screen.dart';
import 'favorite_manager.dart'; // Ensure you have this file for managing favorites

class MovieDetailsScreen extends StatefulWidget {
  final String title;
  final String genre;
  final String duration;
  final String rating;
  final String description;
  final String imageUrl;
  final String videoUrl;

  const MovieDetailsScreen({
    Key? key,
    required this.title,
    required this.genre,
    required this.duration,
    required this.rating,
    required this.description,
    required this.imageUrl,
    required this.videoUrl,
  }) : super(key: key);

  @override
  State<MovieDetailsScreen> createState() => _MovieDetailsScreenState();
}

class _MovieDetailsScreenState extends State<MovieDetailsScreen> {
  int _selectedNavIndex = 0;

  @override
  Widget build(BuildContext context) {
    // Retrieve the current favorite status.
    final bool isFavorite = favoriteManager.isFavorite(widget.title);

    return Scaffold(
      backgroundColor: const Color(0xFFF5EFE6),
      body: CustomScrollView(
        slivers: [
          SliverAppBar(
            expandedHeight: 400,
            floating: false,
            pinned: true,
            backgroundColor: const Color(0xFF1A4D2E),
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
                  Row(
                    children: [
                      Expanded(
                        child: Text(
                          widget.title,
                          style: const TextStyle(
                            color: Color(0xFF1A4D2E),
                            fontSize: 24,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                      IconButton(
                        icon: Icon(
                          isFavorite ? Icons.favorite : Icons.favorite_border,
                          color: isFavorite ? Colors.red : Colors.grey,
                          size: 30,
                        ),
                        onPressed: () {
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
                  Text(
                    widget.genre,
                    style: TextStyle(
                      color: const Color(0xFF1A4D2E).withOpacity(0.8),
                      fontSize: 16,
                    ),
                    textAlign: TextAlign.center,
                  ),
                  const SizedBox(height: 8),
                  Column(
                    children: [
                      Text(
                        widget.duration,
                        style: TextStyle(
                          color: const Color(0xFF1A4D2E).withOpacity(0.8),
                          fontSize: 16,
                        ),
                      ),
                      const SizedBox(height: 4),
                      Text(
                        widget.rating,
                        style: const TextStyle(
                          color: Color(0xFFF3C63F),
                          fontSize: 16,
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 16),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 16.0),
                    child: Text(
                      widget.description,
                      style: const TextStyle(
                        color: Color(0xFF1A4D2E),
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
      bottomNavigationBar: _buildBottomNavigationBar(),
      floatingActionButton: FloatingActionButton.extended(
        onPressed: () {
          // Navigate to the PlayMovie screen with the movie's videoUrl.
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => PlayMovie(videoUrl: widget.videoUrl),
            ),
          );
        },
        backgroundColor: const Color(0xFF1A4D2E),
        icon: const Icon(Icons.play_arrow, color: Colors.white),
        label: const Text(
          'Play Movie',
          style: TextStyle(color: Colors.white),
        ),
      ),
    );
  }

  Widget _buildBottomNavigationBar() {
    return BottomNavigationBar(
      backgroundColor: const Color(0xFF1A4D2E),
      selectedItemColor: const Color(0xFFF5EFE6),
      unselectedItemColor: const Color(0xFFF5EFE6).withOpacity(0.5),
      currentIndex: _selectedNavIndex,
      onTap: (index) {
        setState(() {
          _selectedNavIndex = index;
        });
        if (index == 0) {
          Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => const DashboardScreen()),
          );
        } else if (index == 1) {
          Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => const FavoriteScreen()),
          );
        } else if (index == 2) {
          Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => const ProfileScreen()),
          );
        }
      },
      items: const [
        BottomNavigationBarItem(
          icon: Icon(Icons.home),
          label: 'Home',
        ),
        BottomNavigationBarItem(
          icon: Icon(Icons.favorite),
          label: 'Favorites',
        ),
        BottomNavigationBarItem(
          icon: Icon(Icons.person),
          label: 'Profile',
        ),
      ],
    );
  }
}
