import 'package:flutter/material.dart';
import 'favorite_manager.dart'; // Import the favorite manager
import 'movie_details_screen.dart'; // Import the movie details screen
import 'dashboard_screen.dart'; // Import your dashboard screen
import 'profile_screen.dart';   // Import your profile screen


class FavoriteScreen extends StatefulWidget {
  const FavoriteScreen({super.key});

  @override
  State<FavoriteScreen> createState() => _FavoriteScreenState();
}

class _FavoriteScreenState extends State<FavoriteScreen> {
  int _selectedIndex = 1; // Index for Favorites tab (0-indexed)

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;

      if (index == 0) {
        Navigator.pushReplacement( // Use pushReplacement to avoid stacking screens
          context,
          MaterialPageRoute(builder: (context) => const DashboardScreen()),
        );
      } else if (index == 2) {
        Navigator.pushReplacement( // Use pushReplacement
          context,
          MaterialPageRoute(builder: (context) => const ProfileScreen()),
        );
      }
    });
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Favorites'),
      ),
      body: favoriteManager.favoriteMovies.isEmpty
          ? const Center(
              child: Text('Your favorite movies will appear here.'),
            )
          : ListView.builder(
              itemCount: favoriteManager.favoriteMovies.length,
              itemBuilder: (context, index) {
                final movie = favoriteManager.favoriteMovies[index];
                return ListTile(
                  leading: GestureDetector(
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => MovieDetailsScreen(
                            title: movie['title']!,
                            genre: movie['genre']!,
                            duration: movie['duration']!,
                            rating: movie['rating']!,
                            description: movie['description']!,
                            imageUrl: movie['imageUrl']!,
                          ),
                        ),
                      );
                    },
                    child: Image.network(
                      movie['imageUrl']!,
                      width: 50,
                      height: 50,
                      fit: BoxFit.cover,
                    ),
                  ),
                  title: Text(movie['title']!),
                  subtitle: Text(movie['genre']!),
                  trailing: IconButton(
                    icon: const Icon(Icons.delete, color: Colors.red),
                    onPressed: () {
                      setState(() {
                        favoriteManager.toggleFavorite(movie);
                      });
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
                          rating: movie['rating']!,
                          description: movie['description']!,
                          imageUrl: movie['imageUrl']!,
                        ),
                      ),
                    );
                  },
                );
              },
            ),
      bottomNavigationBar: BottomNavigationBar(
        items: const <BottomNavigationBarItem>[
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
        currentIndex: _selectedIndex,
        backgroundColor: const Color(0xFF1A4D2E),
        selectedItemColor: const Color(0xFFF5EFE6),
        unselectedItemColor: const Color(0xFFF5EFE6).withOpacity(0.5),
        onTap: _onItemTapped,
      ),
    );
  }
}