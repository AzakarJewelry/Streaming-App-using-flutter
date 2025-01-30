import 'package:flutter/material.dart';

class DashboardScreen extends StatelessWidget {
  const DashboardScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF5EFE6), // Cream background
      body: SingleChildScrollView( // For scrollability
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
      height: 200,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(15),
        image: const DecorationImage(
          image: NetworkImage(
              'https://via.placeholder.com/350x150'), // Placeholder image
          fit: BoxFit.cover,
        ),
      ),
      child: Align(
        alignment: Alignment.bottomLeft,
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Text(
            'Doctor Strange\nMultiverse of Madness', // Replace with movie title
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
      child: ListView.builder(
        scrollDirection: Axis.horizontal,
        itemCount: 5, // Replace with actual number of genres
        itemBuilder: (context, index) {
          return _GenreChip(title: 'Genre $index'); // Replace with actual genres
        },
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
          child: ListView.builder(
            scrollDirection: Axis.horizontal,
            itemCount: 3, // Replace with actual number of movies
            itemBuilder: (context, index) {
              return const _MovieCard(
                title: 'Movie Title', // Replace with actual movie title
                rating: '★★★★★', // Replace with actual rating
                reviews: '(100k)', // Replace with actual reviews
              );
            },
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

  const _GenreChip({required this.title});

  @override
  Widget build(BuildContext context) {
    return Container(
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
    );
  }
}

class _MovieCard extends StatelessWidget {
  final String title;
  final String rating;
  final String reviews;

  const _MovieCard({
    required this.title,
    required this.rating,
    required this.reviews,
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
              image: const DecorationImage(
                image: NetworkImage('https://via.placeholder.com/150'),
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