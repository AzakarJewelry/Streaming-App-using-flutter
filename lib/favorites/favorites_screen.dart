import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:azakarstream/drama/watch_video_screen.dart';
import 'favorite_manager.dart'; // Import the favorite manager
import '../dashboard/movie_details_screen.dart'; // Import the movie details screen
import '../dashboard/dashboard_screen.dart'; // Import your dashboard screen
import '../profile/profile_screen.dart'; // Import your profile screen
import 'dart:ui'; // Required for BackdropFilter and ImageFilter

class FavoriteScreen extends StatefulWidget {
  const FavoriteScreen({super.key});

  @override
  State<FavoriteScreen> createState() => _FavoriteScreenState();
}

class _FavoriteScreenState extends State<FavoriteScreen> {
  final int _selectedIndex = 1; // Index for Favorites tab (0-indexed)

  void _onItemTapped(int index) {
    if (index == _selectedIndex) return;

    if (index == 0) {
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (context) => const DashboardScreen()),
      );
    } else if (index == 1) {
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (context) => const FavoriteScreen()),
      );
    } else if (index == 2) {
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (context) => const ProfileScreen()),
      );
    } else if (index == 3) {
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (context) => const WatchVideoScreen()),
      );
    }
  }

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final isDarkMode = Theme.of(context).brightness == Brightness.dark;

    return Scaffold(
      backgroundColor: isDarkMode ? Colors.black : Colors.white,
      appBar: AppBar(
        title: const Text('Favorites'),
        backgroundColor: isDarkMode ? Colors.black : Colors.white,
        foregroundColor: isDarkMode ? Colors.white : Colors.black,
        elevation: 0,
      ),
      body: Stack(
        children: [
          favoriteManager.favoriteMovies.isEmpty
              ? Center(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Icon(
                        Icons.favorite_border,
                        size: 80,
                        color: isDarkMode ? Colors.grey[600] : Colors.grey[400],
                      ),
                      const SizedBox(height: 16),
                      Text(
                        'Your favorite movies will appear here.',
                        style: TextStyle(
                          fontSize: 18,
                          color: isDarkMode ? Colors.grey[400] : Colors.grey,
                        ),
                      ),
                      const SizedBox(height: 16),
                      ElevatedButton(
                        onPressed: () {
                          Navigator.pushReplacement(
                            context,
                            MaterialPageRoute(
                                builder: (context) => const DashboardScreen()),
                          );
                        },
                        style: ElevatedButton.styleFrom(
                          backgroundColor: const Color(0xFF6152FF),
                          foregroundColor: Colors.white,
                        ),
                        child: const Text('Explore Movies'),
                      ),
                    ],
                  ),
                )
              : ListView.builder(
                  padding: const EdgeInsets.all(8.0),
                  itemCount: favoriteManager.favoriteMovies.length,
                  itemBuilder: (context, index) {
                    final movie = favoriteManager.favoriteMovies[index];
                    return Card(
                      margin: const EdgeInsets.symmetric(vertical: 8.0),
                      elevation: 4,
                      color: isDarkMode ? Colors.grey[900] : Colors.white,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(12),
                      ),
                      child: ListTile(
                        contentPadding: const EdgeInsets.all(12.0),
                        leading: ClipRRect(
                          borderRadius: BorderRadius.circular(8.0),
                          child: Image.network(
                            movie['imageUrl']!,
                            width: 70,
                            height: 100,
                            fit: BoxFit.cover,
                          ),
                        ),
                        title: Text(
                          movie['title']!,
                          style: TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.bold,
                            color: isDarkMode ? Colors.white : Colors.black,
                          ),
                        ),
                        subtitle: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            const SizedBox(height: 4),
                            Text(
                              "Genre: ${movie['genre']}",
                              style: TextStyle(
                                fontSize: 14,
                                color: isDarkMode ? Colors.white70 : Colors.black54,
                              ),
                            ),
                            const SizedBox(height: 4),
                          ],
                        ),
                        trailing: IconButton(
                          icon: const Icon(Icons.delete, color: Colors.red),
                          onPressed: () {
                            setState(() {
                              favoriteManager.toggleFavorite(movie);
                            });
                            ScaffoldMessenger.of(context).showSnackBar(
                              SnackBar(
                                content: Text(
                                  "${movie['title']} removed from favorites.",
                                  style: const TextStyle(fontSize: 14),
                                ),
                                duration: const Duration(seconds: 2),
                              ),
                            );
                          },
                        ),
                        onTap: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => MovieDetailsScreen(
                                title: movie['title']!,
                                genre: movie['genre']!,
                                duration: movie['duration']!,
                                
                                description: movie['description']!,
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
          Positioned(
            left: 0,
            right: 0,
            bottom: 0,
            child: Padding(
              padding: const EdgeInsets.only(bottom: 12.0),
              child: ClipRRect(
                borderRadius: BorderRadius.circular(30),
                child: BackdropFilter(
                  filter: ImageFilter.blur(sigmaX: 10, sigmaY: 10), // Stronger blur
                  child: Container(
                    margin: const EdgeInsets.symmetric(horizontal: 5),
                    padding: const EdgeInsets.symmetric(vertical: 5),
                    decoration: BoxDecoration(
                      color: Colors.transparent,
                    ),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      children: [
                        _buildNavItem('assets/icons/home.svg', 'Home', 0),
                        _buildNavItem('assets/icons/heart.svg', 'Favorites', 1),
                        _buildNavItem('assets/icons/user.svg', 'Profile', 2),
                        _buildNavItem('assets/icons/play-circle.svg', 'Reels', 3),
                      ],
                    ),
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  /// Build bottom nav item
  Widget _buildNavItem(String iconPath, String label, int index) {
    final isSelected = _selectedIndex == index;
    final isDarkMode = Theme.of(context).brightness == Brightness.dark;

    return GestureDetector(
      onTap: () => _onItemTapped(index),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          SvgPicture.asset(
            iconPath,
            height: 24,
            width: 24,
            colorFilter: ColorFilter.mode(
              isSelected
                  ? (isDarkMode ? Colors.white : const Color(0xFF6152FF))
                  : (isDarkMode ? Colors.grey[400]! : Colors.black),
              BlendMode.srcIn,
            ),
          ),
          const SizedBox(height: 4),
          Text(
            label,
            style: TextStyle(
              fontSize: 12,
              color: isSelected
                  ? (isDarkMode ? Colors.white : const Color(0xFF6152FF))
                  : (isDarkMode ? Colors.grey[400] : Colors.black),
              fontWeight: isSelected ? FontWeight.bold : FontWeight.normal,
            ),
          ),
        ],
      ),
    );
  }
}