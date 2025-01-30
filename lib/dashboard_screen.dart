import 'package:flutter/material.dart';
import 'genre_screen.dart'; // Import the GenreScreen

class DashboardScreen extends StatelessWidget {
  const DashboardScreen({super.key});

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
        IconButton(
          icon: const Icon(Icons.search, color: Color(0xFF1A4D2E)),
          onPressed: () {
            // Implement search
          },
        ),
        Row(
          children: [
            Text(
              '10:45', // Replace with actual time
              style: TextStyle(
                color: const Color(0xFF1A4D2E).withOpacity(0.6),
                fontSize: 16,
              ),
            ),
            const SizedBox(width: 10),
            const Text(
              'StreamScape', // Replace with actual location
              style: TextStyle(
                color: Color(0xFF1A4D2E),
                fontSize: 16,
              ),
            ),
          ],
        ),
        IconButton(
          icon: const Icon(Icons.notifications, color: Color(0xFF1A4D2E)),
          onPressed: () {
            // Implement notifications
          },
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
          image: NetworkImage('https://cdn.mos.cms.futurecdn.net/NJXQ8h3mUd9mhsh2m8xpba-1200-80.jpg'), // Replace with actual image URL
          fit: BoxFit.cover,
        ),
      ),
      child: Align(
        alignment: Alignment.bottomLeft,
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Text(
            'DOCTOR STRANGE MULTIVERSE OF MADNESS', // Replace with movie title
            style: const TextStyle(
              color: Colors.white,
              fontSize: 20,
              fontWeight: FontWeight.bold,
              shadows: [
                Shadow(
                  blurRadius: 10,
                  color: Color(0xCC000000), // Equivalent to Colors.black.withOpacity(0.8)
                )
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildGenres() {
    return SizedBox(
      height: 40,
      child: ListView(
        scrollDirection: Axis.horizontal,
        children: const [
          _GenreChip(title: 'Fantasy', genre: 'Fantasy'),
          _GenreChip(title: 'Drama', genre: 'Drama'),
          _GenreChip(title: 'Action', genre: 'Action'),
          _GenreChip(title: 'Romance', genre: 'Romance'),
          _GenreChip(title: 'Comedy', genre: 'Comedy'),
        ],
      ),
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
              onPressed: () {},
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
          height: 200,
          child: ListView(
            scrollDirection: Axis.horizontal,
            children: const [
              _MovieCard(
                title: 'Captain Marvel',
                rating: '★★★★★',
                reviews: '(100k)',
                imageUrl: 'https://encrypted-tbn2.gstatic.com/images?q=tbn:ANd9GcTvwUrWZA7dCe_ggg96fG625dfkSMopojxVqCQAuFBff88WdpV5', // Replace with actual image URL
              ),
              _MovieCard(
                title: 'Jurassic World',
                rating: '★★★★☆',
                reviews: '(55k)',
                imageUrl: 'https://play-lh.googleusercontent.com/qWv3eGPqFKhTG4vCuoDLDsfMkkMxZRGn646EZo-3C2tC3sL4tAjnmoeA9EEdUFrChqgTHA', // Replace with actual image URL
              ),
              _MovieCard(
                title: 'Aqua',
                rating: '★★★☆☆',
                reviews: '(35k)',
                imageUrl: 'https://images.squarespace-cdn.com/content/v1/57b29c442994cab73855c706/1545901747909-0M8FCPH08T51S65T0S5Q/Aquaman.jpg?format=1000w', // Replace with actual image URL
              ),
            ],
          ),
        ),
      ],
    );
  }

  Widget _buildBottomNavigationBar() {
    return BottomNavigationBar(
      backgroundColor: const Color(0xFFF5EFE6),
      selectedItemColor: const Color(0xFF1A4D2E),
      unselectedItemColor: const Color(0xFF1A4D2E).withOpacity(0.5),
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

  const _GenreChip({required this.title, required this.genre});

  void _navigateToGenreScreen(BuildContext context) {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => GenreScreen(genre: genre),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => _navigateToGenreScreen(context),
      child: Container(
        margin: const EdgeInsets.only(right: 10),
        padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 8),
        decoration: BoxDecoration(
          color: const Color(0xFF1A4D2E),
          borderRadius: BorderRadius.circular(20),
        ),
        child: Text(
          title,
          style: const TextStyle(
            color: Color(0xFFF5EFE6),
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

  const _MovieCard({
    required this.title,
    required this.rating,
    required this.reviews,
    required this.imageUrl,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
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
                image: NetworkImage(imageUrl), // Use the provided image URL
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
    );
  }
}