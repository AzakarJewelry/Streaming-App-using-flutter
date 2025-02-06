// dashboard_screen.dart
// ignore_for_file: library_private_types_in_public_api, deprecated_member_use

import 'package:azakarstream/SearchScreen.dart';
import 'package:flutter/material.dart';
import 'movie_details_screen.dart';
import 'view_all_movies_screen.dart'; // Import the new screen
import 'genre_screen.dart'; // Import the GenreScreen
import 'favorites_screen.dart'; // Import the FavoriteScreen
import 'profile_screen.dart'; // Import the ProfileScreen

class DashboardScreen extends StatefulWidget {
  const DashboardScreen({super.key});

  @override
  _DashboardScreenState createState() => _DashboardScreenState();
}

class _DashboardScreenState extends State<DashboardScreen> {
  String? _selectedGenre; // Track the selected genre
  int _selectedNavIndex = 0; // Track the selected navigation index

  // Updated movie lists with videoUrl field.
  final List<Map<String, String>> newReleases = [
    {
      'title': 'One Piece',
      'rating': '★★★★★',
      'reviews': '(100k)',
      'imageUrl':
          'https://m.media-amazon.com/images/M/MV5BMTNjNGU4NTUtYmVjMy00YjRiLTkxMWUtNzZkMDNiYjZhNmViXkEyXkFqcGc@._V1_.jpg',
      'genre': 'Action',
      'duration': '2h 4m',
      'videoUrl': 'https://res.cloudinary.com/dywykbqpw/video/upload/zrf1mbajhv8m24n9gxi7.mp4', // Unique video URL
    },
    {
      'title': 'One Punch Man',
      'rating': '★★★★☆',
      'reviews': '(55k)',
      'imageUrl':
          'https://upload.wikimedia.org/wikipedia/en/c/c3/OnePunchMan_manga_cover.png',
      'genre': 'Adventure',
      'duration': '2h 4m',
      'videoUrl': 'https://res.cloudinary.com/dywykbqpw/video/upload/One_Punch_Man_Season_1_-_Episode_05_English_Sub_gvmv1g.mp4',
    },
    {
      'title': 'Aquaman',
      'rating': '★★★☆☆',
      'reviews': '(35k)',
      'imageUrl':
          'https://images.squarespace-cdn.com/content/v1/57b29c442994cab73855c706/1545901747909-0M8FCPH08T51S65T0S5Q/Aquaman.jpg?format=1000w',
      'genre': 'Action',
      'duration': '2h 4m',
      'videoUrl': 'https://example.com/aquaman.mp4',
    },
    {
      'title': 'Infinity War',
      'rating': '★★★★★',
      'reviews': '(105k)',
      'imageUrl':
          'https://es.web.img3.acsta.net/c_310_420/pictures/18/03/16/15/33/3988420.jpg',
      'genre': 'Action',
      'duration': '2h 4m',
      'videoUrl': 'https://example.com/infinity_war.mp4',
    },
    {
      'title': 'Spider-Man: No Way Home',
      'rating': '★★★★★',
      'reviews': '(200k)',
      'imageUrl':
          'https://m.media-amazon.com/images/M/MV5BZWMyYzFjYTYtNTRjYi00OGExLWE2YzgtOGRmYjAxZTU3NzBiXkEyXkFqcGdeQXVyMzQ0MzA0NTM@._V1_FMjpg_UX1000_.jpg',
      'genre': 'Action',
      'duration': '2h 4m',
      'videoUrl': 'https://example.com/spiderman_no_way_home.mp4',
    },
    {
      'title': 'Labyrinth',
      'rating': '★★★★★',
      'reviews': '(10k)',
      'imageUrl':
          'https://i5.walmartimages.com/asr/1732b38b-054d-49a7-9447-375f7ef523fc_1.5d63679e850c08000081448f9a897369.jpeg',
      'genre': 'Fantasy',
      'duration': '2h 4m',
      'videoUrl': 'https://example.com/labyrinth.mp4',
    },
  ];

  final List<Map<String, String>> mostPopular = [
    {
      'title': 'The Batman',
      'rating': '★★★★☆',
      'reviews': '(95k)',
      'imageUrl':
          'https://m.media-amazon.com/images/M/MV5BMDdmMTBiNTYtMDIzNi00NGVlLWIzMDYtZTk3MTQ3NGQxZGEwXkEyXkFqcGdeQXVyMzMwOTU5MDk@._V1_.jpg',
      'genre': 'Action',
      'duration': '2h 56m',
      'videoUrl': 'https://example.com/the_batman.mp4',
    },
    {
      'title': 'Black Panther',
      'rating': '★★★★★',
      'reviews': '(150k)',
      'imageUrl':
          'https://m.media-amazon.com/images/M/MV5BNTM4NjIxNmEtYWE5NS00NDczLTkyNWQtYThhNmQyZGQzMjM0XkEyXkFqcGdeQXVyODk4OTc3MTY@._V1_FMjpg_UX1000_.jpg',
      'genre': 'Action',
      'duration': '2h 14m',
      'videoUrl': 'https://example.com/black_panther.mp4',
    },
    {
      'title': 'Avatar: The Way of Water',
      'rating': '★★★★☆',
      'reviews': '(120k)',
      'imageUrl':
          'https://m.media-amazon.com/images/M/MV5BYjhiNjBlODctY2ZiOC00YjVlLWFlNzAtNTVhNzM1YjI1NzMxXkEyXkFqcGdeQXVyMjQxNTE1MDA@._V1_FMjpg_UX1000_.jpg',
      'genre': 'Drama',
      'duration': '2h 14m',
      'videoUrl': 'https://example.com/avatar_the_way_of_water.mp4',
    },
    {
      'title': 'Top Gun: Maverick',
      'rating': '★★★★★',
      'reviews': '(180k)',
      'imageUrl':
          'https://m.media-amazon.com/images/M/MV5BZWYzOGEwNTgtNWU3NS00ZTQ0LWJkODUtMmVhMjIwMjA1ZmQwXkEyXkFqcGdeQXVyMjkwOTAyMDU@._V1_FMjpg_UX1000_.jpg',
      'genre': 'Action',
      'duration': '2h 14m',
      'videoUrl': 'https://example.com/top_gun_maverick.mp4',
    },
    {
      'title': 'Titanic',
      'rating': '★★★★★',
      'reviews': '(180k)',
      'imageUrl': 'https://picfiles.alphacoders.com/140/thumb-1920-140026.jpg',
      'genre': 'Romance',
      'duration': '2h 14m',
      'videoUrl': 'https://example.com/titanic.mp4',
    },
    {
      'title': 'The Little Man',
      'rating': '★★★★☆',
      'reviews': '(95k)',
      'imageUrl':
          'https://th.bing.com/th/id/OIP.VcW6HtnsQerz4KJBq6IxAwHaKb?w=588&h=828&rs=1&pid=ImgDetMain',
      'genre': 'Comedy',
      'duration': '2h 56m',
      'videoUrl': 'https://example.com/the_little_man.mp4',
    },
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF5EFE6), // Cream background
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Top Bar (Time, Location, Icons)
              _buildTopBar(),
              const SizedBox(height: 20),
              // Featured Movie
              _buildFeaturedMovie(),
              const SizedBox(height: 25),
              // Genres
              _buildGenres(),
              const SizedBox(height: 25),
              // New Releases
              _buildNewReleases(),
              // More Movies Section Below
              _buildMoreMovies(),
            ],
          ),
        ),
      ),
      bottomNavigationBar: _buildBottomNavigationBar(),
    );
  }

  Widget _buildTopBar() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        // Time and Location
        Row(
          children: [
            Text(
              '', // Replace with actual time if needed
              style: TextStyle(
                color: const Color(0xFF1A4D2E).withOpacity(0.6),
                fontSize: 16,
              ),
            ),
            const SizedBox(width: 10),
            Padding(
              padding: const EdgeInsets.only(top: 40.0),
              child: const Text(
                'StreamScape',
                style: TextStyle(
                  color: Color(0xFF1A4D2E),
                  fontSize: 20,
                ),
              ),
            ),
          ],
        ),
        // Search and Notifications
        Row(
          children: [
            IconButton(
              icon: const Icon(Icons.search, color: Color(0xFF1A4D2E)),
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => SearchScreen(
                      allMovies: [...newReleases, ...mostPopular],
                    ),
                  ),
                );
              },
            ),
            IconButton(
              icon: const Icon(Icons.notifications, color: Color(0xFF1A4D2E)),
              onPressed: () {
                // Implement notifications
              },
            ),
          ],
        ),
      ],
    );
  }

  Widget _buildFeaturedMovie() {
    return Container(
      height: 300,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(15),
        image: const DecorationImage(
          image: NetworkImage(
              'https://cdn.mos.cms.futurecdn.net/NJXQ8h3mUd9mhsh2m8xpba-1200-80.jpg'),
          fit: BoxFit.cover,
        ),
      ),
      child: Align(
        alignment: Alignment.bottomLeft,
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Text(
            'DOCTOR STRANGE MULTIVERSE OF MADNESS',
            style: const TextStyle(
              color: Colors.white,
              fontSize: 20,
              fontWeight: FontWeight.bold,
              shadows: [
                Shadow(
                  blurRadius: 10,
                  color: Color(0xCC000000),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildGenres() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text(
          'Genres',
          style: TextStyle(
            color: Color(0xFF1A4D2E),
            fontSize: 20,
            fontWeight: FontWeight.bold,
          ),
        ),
        const SizedBox(height: 10),
        SizedBox(
          height: 40,
          child: ListView(
            scrollDirection: Axis.horizontal,
            children: [
              _GenreChip(
                title: 'Fantasy',
                genre: 'Fantasy',
                isSelected: _selectedGenre == 'Fantasy',
                onSelected: (genre) {
                  setState(() {
                    _selectedGenre = genre;
                  });
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => GenreScreen(
                        genre: genre,
                        allMovies: [...newReleases, ...mostPopular],
                      ),
                    ),
                  );
                },
              ),
              _GenreChip(
                title: 'Drama',
                genre: 'Drama',
                isSelected: _selectedGenre == 'Drama',
                onSelected: (genre) {
                  setState(() {
                    _selectedGenre = genre;
                  });
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => GenreScreen(
                        genre: genre,
                        allMovies: [...newReleases, ...mostPopular],
                      ),
                    ),
                  );
                },
              ),
              _GenreChip(
                title: 'Action',
                genre: 'Action',
                isSelected: _selectedGenre == 'Action',
                onSelected: (genre) {
                  setState(() {
                    _selectedGenre = genre;
                  });
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => GenreScreen(
                        genre: genre,
                        allMovies: [...newReleases, ...mostPopular],
                      ),
                    ),
                  );
                },
              ),
              _GenreChip(
                title: 'Romance',
                genre: 'Romance',
                isSelected: _selectedGenre == 'Romance',
                onSelected: (genre) {
                  setState(() {
                    _selectedGenre = genre;
                  });
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => GenreScreen(
                        genre: genre,
                        allMovies: [...newReleases, ...mostPopular],
                      ),
                    ),
                  );
                },
              ),
              _GenreChip(
                title: 'Comedy',
                genre: 'Comedy',
                isSelected: _selectedGenre == 'Comedy',
                onSelected: (genre) {
                  setState(() {
                    _selectedGenre = genre;
                  });
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => GenreScreen(
                        genre: genre,
                        allMovies: [...newReleases, ...mostPopular],
                      ),
                    ),
                  );
                },
              ),
            ],
          ),
        ),
      ],
    );
  }

  Widget _buildNewReleases() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            const Text(
              'New Releases',
              style: TextStyle(
                color: Color(0xFF1A4D2E),
                fontSize: 20,
                fontWeight: FontWeight.bold,
              ),
            ),
            TextButton(
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (context) =>
                          ViewAllMoviesScreen(movies: newReleases)),
                );
              },
              child: const Text(
                'View All',
                style: TextStyle(
                  color: Color(0xFF1A4D2E),
                ),
              ),
            ),
          ],
        ),
        const SizedBox(height: 15),
        SizedBox(
          height: 220,
          child: ListView(
            scrollDirection: Axis.horizontal,
            children: newReleases
                .map(
                  (movie) => _MovieCard(
                    title: movie['title']!,
                    rating: movie['rating']!,
                    reviews: movie['reviews']!,
                    imageUrl: movie['imageUrl']!,
                    genre: movie['genre']!,
                    duration: movie['duration']!,
                    videoUrl: movie['videoUrl']!,
                  ),
                )
                .toList(),
          ),
        ),
      ],
    );
  }

  Widget _buildMoreMovies() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            const Text(
              'Most Popular',
              style: TextStyle(
                color: Color(0xFF1A4D2E),
                fontSize: 20,
                fontWeight: FontWeight.bold,
              ),
            ),
            TextButton(
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (context) =>
                          ViewAllMoviesScreen(movies: mostPopular)),
                );
              },
              child: const Text(
                'View All',
                style: TextStyle(
                  color: Color(0xFF1A4D2E),
                ),
              ),
            ),
          ],
        ),
        const SizedBox(height: 15),
        SizedBox(
          height: 220,
          child: ListView(
            scrollDirection: Axis.horizontal,
            children: mostPopular
                .map(
                  (movie) => _MovieCard(
                    title: movie['title']!,
                    rating: movie['rating']!,
                    reviews: movie['reviews']!,
                    imageUrl: movie['imageUrl']!,
                    genre: movie['genre']!,
                    duration: movie['duration']!,
                    videoUrl: movie['videoUrl']!,
                  ),
                )
                .toList(),
          ),
        ),
      ],
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

        if (index == 1) {
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

class _GenreChip extends StatelessWidget {
  final String title;
  final String genre;
  final bool isSelected;
  final Function(String) onSelected;

  const _GenreChip({
    required this.title,
    required this.genre,
    required this.isSelected,
    required this.onSelected,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => onSelected(genre),
      child: Container(
        margin: const EdgeInsets.only(right: 10),
        padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 8),
        decoration: BoxDecoration(
          color: isSelected ? const Color(0xFF1A4D2E) : Colors.white,
          borderRadius: BorderRadius.circular(20),
          border: Border.all(
            color: const Color(0xFF1A4D2E),
            width: 1,
          ),
        ),
        child: Text(
          title,
          style: TextStyle(
            color: isSelected ? const Color(0xFFF5EFE6) : const Color(0xFF1A4D2E),
            fontSize: 16,
          ),
        ),
      ),
    );
  }
}

class _MovieCard extends StatelessWidget {
  final String title;
  final String rating;
  final String reviews;
  final String imageUrl;
  final String genre;
  final String duration;
  final String videoUrl;

  const _MovieCard({
    required this.title,
    required this.rating,
    required this.reviews,
    required this.imageUrl,
    required this.genre,
    required this.duration,
    required this.videoUrl,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        // Pass all details including videoUrl to the MovieDetailsScreen
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => MovieDetailsScreen(
              title: title,
              genre: genre,
              duration: duration,
              rating: rating,
              description: 'This is a detailed description of the movie $title.',
              imageUrl: imageUrl,
              videoUrl: videoUrl,
            ),
          ),
        );
      },
      child: Container(
        width: 150,
        margin: const EdgeInsets.only(right: 15),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              height: 150,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(15),
                image: DecorationImage(
                  image: NetworkImage(imageUrl),
                  fit: BoxFit.cover,
                ),
              ),
            ),
            const SizedBox(height: 8),
            Text(
              title,
              style: const TextStyle(
                color: Color(0xFF1A4D2E),
                fontWeight: FontWeight.bold,
              ),
            ),
            Row(
              children: [
                Text(
                  rating,
                  style: const TextStyle(
                    color: Color(0xFFF3C63F),
                    fontSize: 12,
                  ),
                ),
                const SizedBox(width: 5),
                Text(
                  reviews,
                  style: TextStyle(
                    color: const Color(0xFF1A4D2E).withOpacity(0.5),
                    fontSize: 12,
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
