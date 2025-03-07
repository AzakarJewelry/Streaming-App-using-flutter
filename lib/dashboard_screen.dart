// dashboard_screen.dart
// ignore_for_file: library_private_types_in_public_api, deprecated_member_use
import 'package:azakarstream/SearchScreen.dart';
import 'package:azakarstream/watch_video_screen.dart';
import 'package:flutter/material.dart';
import 'movie_details_screen.dart';
import 'view_all_movies_screen.dart'; // Import the new screen
import 'genre_screen.dart'; // Import the GenreScreen
import 'favorites_screen.dart'; // Import the FavoriteScreen
import 'profile_screen.dart'; // Import the ProfileScreen
import 'package:google_mobile_ads/google_mobile_ads.dart';
import 'play_drama_screen.dart'; // Import the PlayDramaScreen
import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/services.dart';

import 'dart:io';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  MobileAds.instance.initialize();
  runApp(const DashboardScreen());
}

class DashboardScreen extends StatefulWidget {
  const DashboardScreen({super.key});

  @override
  _DashboardScreenState createState() => _DashboardScreenState();
}

class _DashboardScreenState extends State<DashboardScreen> {
  String? _selectedGenre; // Track the selected genre
  int _selectedNavIndex = 0; // Track the selected navigation index

  AdRequest? adRequest;
  BannerAd? bannerAd;

  // Variable to track the last back button press time
  DateTime? lastPressed;

@override
  void initState() {
    super.initState();

    SystemChannels.lifecycle.setMessageHandler((msg) async {
      if (msg == AppLifecycleState.paused.toString()) {
        _navigateToDashboard();
      }
      return null;
    });

    bannerAd = BannerAd(
      size: AdSize.fluid,
      adUnitId: "ca-app-pub-3940256099942544/6300978111", // Test AdMob ID
      request: const AdRequest(),
      listener: BannerAdListener(
        onAdLoaded: (ad) => setState(() {}),
        onAdFailedToLoad: (ad, error) => ad.dispose(),
      ),
    )..load();
  }

  void _navigateToDashboard() {
    Navigator.pushAndRemoveUntil(
      context,
      MaterialPageRoute(builder: (context) => const DashboardScreen()),
      (Route<dynamic> route) => false,
    );
  }

  @override
  void dispose() {
    bannerAd?.dispose();
    super.dispose();
  }

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
    'videoUrl':
        'https://res.cloudinary.com/dywykbqpw/video/upload/zrf1mbajhv8m24n9gxi7.mp4',
    'description': 'Join Monkey D. Luffy and his crew on an epic adventure in search of the ultimate treasure, One Piece.'
  },
  {
    'title': 'One Punch Man',
    'rating': '★★★★☆',
    'reviews': '(55k)',
    'imageUrl':
        'https://upload.wikimedia.org/wikipedia/en/c/c3/OnePunchMan_manga_cover.png',
    'genre': 'Adventure',
    'duration': '2h 4m',
    'videoUrl':
        'https://res.cloudinary.com/dywykbqpw/video/upload/One_Punch_Man_Season_1_-_Episode_05_English_Sub_gvmv1g.mp4',
    'description': 'Follow Saitama, a hero who can defeat any enemy with a single punch, as he searches for a true challenge.'
  },
  {
    'title': 'Sakamoto Days',
    'rating': '★★★★★',
    'reviews': '(35k)',
    'imageUrl':
        'https://res.cloudinary.com/dkhe2vgto/image/upload/v1739157398/Sakamoto_qmwwmw.jpg',
    'genre': 'Action',
    'duration': '2h 4m',
    'videoUrl':
        'https://res.cloudinary.com/dkhe2vgto/video/upload/AH2_SAKAMOTO_DAYS_-_01_1080p_v0.mkv_1_qccg8z.mp4',
    'description': 'An ex-assassin turned family man is pulled back into action in this thrilling and humorous series.'
  },
  {
    'title': 'I Have a Crush at Work',
    'rating': '★★★★★',
    'reviews': '(105k)',
    'imageUrl':
        'https://res.cloudinary.com/dkhe2vgto/image/upload/9f76212f36053b1cb40bf7468b463e82_dyctyj.jpg',
    'genre': 'Romance',
    'duration': '2h 4m',
    'videoUrl':
        'https://res.cloudinary.com/dkhe2vgto/video/upload/AH2_I_Have_a_Crush_at_Work_-_01_1080p_v0.mkv_fslfz2.mp4',
    'description': 'A heartwarming tale of office romance where unexpected love blossoms amidst everyday work challenges.'
  },
  {
    'title': 'Spider-Man: No Way Home',
    'rating': '★★★★★',
    'reviews': '(200k)',
    'imageUrl':
        'https://m.media-amazon.com/images/M/MV5BZWMyYzFjYTYtNTRjYi00OGExLWE2YzgtOGRmYjAxZTU3NzBiXkEyXkFqcGdeQXVyMzQ0MzA0NTM@._V1_FMjpg_UX1000_.jpg',
    'genre': 'Action',
    'duration': '2h 4m',
    'videoUrl':
        'https://res.cloudinary.com/dkhe2vgto/video/upload/y2mate.com_-_Defeating_Doc_Ock_SpiderMan_2_Voyage_With_Captions_1080_eufgx6.mp4',
    'description': 'Experience the multiverse adventure as Spider-Man faces enemies from different dimensions in an epic battle.'
  },
  {
    'title': 'Horimiya: The Missing Pieces',
    'rating': '★★★★★',
    'reviews': '(10k)',
    'imageUrl':
        'https://res.cloudinary.com/dkhe2vgto/image/upload/horimiya_mekupa.jpg',
    'genre': 'Fantasy',
    'duration': '2h 4m',
    'videoUrl':
        'https://res.cloudinary.com/dkhe2vgto/video/upload/SubsPlease_Horimiya_-_Piece_-_01_1080p_F8A2CB28_.mkv_wan7d0.mp4',
    'description': 'A slice-of-life story that reveals hidden sides of its characters through charming and unexpected moments.'
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
    'description': 'A dark, brooding detective battles corruption in Gotham City as he dons the cape to fight for justice.'
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
    'description': 'Wakanda’s king rises to the challenge, defending his nation with cutting-edge technology and unmatched courage.'
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
    'description': 'Dive into a visually stunning journey exploring the deep connection between humanity and nature on Pandora.'
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
    'description': 'High-flying action and heart-pounding aerial battles define this sequel as Maverick soars once again.'
  },
  {
    'title': 'Titanic',
    'rating': '★★★★★',
    'reviews': '(180k)',
    'imageUrl':
        'https://res.cloudinary.com/dkhe2vgto/image/upload/titanic_xowrkm.jpg',
    'genre': 'Romance',
    'duration': '2h 14m',
    'videoUrl': 'https://example.com/titanic.mp4',
    'description': 'A timeless romance unfolds amidst a tragic maritime disaster, capturing hearts across generations.'
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
    'description': 'A jewel thief with dwarfism hides his loot by pretending to be a very large baby in a hilarious caper.'
  },
];


 Widget _buildFeaturedMovie(BuildContext context) {
    final List<Map<String, dynamic>> featuredMovies = [
      {
        'title': 'I am Nobody',
        'imageUrl': 'https://res.cloudinary.com/dkhe2vgto/image/upload/v1741224873/48ea378a44de34027f8db1c4062a0f66_m1yzay.jpg',
        'genre': 'Sci-Fi',
        'duration': '2h 30m',
        'rating': '★★★★☆',
        'videoUrl': 'https://example.com/dandadan.mp4',
        'description': 'Dandadan is an action-packed sci-fi adventure about a mysterious power.',
        'episodes': [
          'https://res.cloudinary.com/dcwjifq5f/video/upload/v1741309655/CDrama01_gmmcxw.mp4',
          'https://res.cloudinary.com/dcwjifq5f/video/upload/v1741309652/CDrama02_ictkkw.mp4',
          'https://res.cloudinary.com/dcwjifq5f/video/upload/v1741309655/CDrama03_vvpqa7.mp4',
          'https://res.cloudinary.com/dcwjifq5f/video/upload/v1741309650/CDrama04_mlwg86.mp4',
        ],
      },
      {
        'title': 'Chinese 2',
        'imageUrl': 'https://res.cloudinary.com/dkhe2vgto/image/upload/v1741224888/8f9058d880e7e14b11ff2cbf89a7a57a_c96oys.jpg',
        'genre': 'Action',
        'duration': '2h 10m',
        'rating': '★★★★★',
        'videoUrl': 'https://example.com/dr_strange.mp4',
        'description': 'Doctor Strange embarks on a journey through the multiverse.',
        'episodes': [
          'https://example.com/dr_strange_ep1.mp4',
          'https://example.com/dr_strange_ep2.mp4',
          'https://example.com/dr_strange_ep3.mp4',
        ],
      },
      {
        'title': 'Chinese 3',
        'imageUrl': 'https://res.cloudinary.com/dkhe2vgto/image/upload/v1741224904/7be13247ab96ed300d600184de481862_gwdqbs.jpg',
        'genre': 'Comedy',
        'duration': '2h 15m',
        'rating': '★★★★★',
        'videoUrl': 'https://example.com/deadpool_wolverine.mp4',
        'description': 'Deadpool and Wolverine team up for an unexpected adventure.',
        'episodes': [
          'https://example.com/deadpool_wolverine_ep1.mp4',
          'https://example.com/deadpool_wolverine_ep2.mp4',
          'https://example.com/deadpool_wolverine_ep3.mp4',
        ],
      },
      {
        'title': 'Chinese 4',
        'imageUrl': 'https://res.cloudinary.com/dkhe2vgto/image/upload/v1741225128/c416cb9f200ea3a34974f28de47c62e1_r2syn5.jpg',
        'genre': 'Action',
        'duration': '2h 4m',
        'rating': '★★★★★',
        'videoUrl': 'https://res.cloudinary.com/dkhe2vgto/video/upload/AH2_SAKAMOTO_DAYS_-_01_1080p_v0.mkv_1_qccg8z.mp4',
        'description': 'Sakamoto, a former hitman, tries to live a peaceful life but trouble follows him.',
        'episodes': [
          'https://example.com/sakamoto_ep1.mp4',
          'https://example.com/sakamoto_ep2.mp4',
          'https://example.com/sakamoto_ep3.mp4',
        ],
      },
      {
        'title': 'Kill My Sins',
        'imageUrl': 'https://res.cloudinary.com/dkhe2vgto/image/upload/v1741225215/c2125f3b610c3903d9401f07ddadaae8_e6xpr0.jpg',
        'genre': 'Drama',
        'duration': '3h 0m',
        'rating': '★★★★★',
        'videoUrl': 'https://example.com/oppenheimer.mp4',
        'description': 'A historical drama about the making of the atomic bomb and its consequences.',
        'episodes': [
          'https://example.com/oppenheimer_ep1.mp4',
          'https://example.com/oppenheimer_ep2.mp4',
          'https://example.com/oppenheimer_ep3.mp4',
        ],
      },
    ];


    return CarouselSlider(
    options: CarouselOptions(
      height: MediaQuery.of(context).size.height * 0.4,
      autoPlay: true,
      autoPlayInterval: const Duration(seconds: 3),
      viewportFraction: 1.0,
    ),
    items: featuredMovies.map((movie) {
      return GestureDetector(
        onTap: () {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => PlayDramaScreen(videoList: movie['episodes']!),
            ),
          );
        },
        child: Container(
          width: MediaQuery.of(context).size.width,
          margin: const EdgeInsets.symmetric(horizontal: 5),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(15),
            image: DecorationImage(
              image: NetworkImage(movie['imageUrl']!),
              fit: BoxFit.cover,
            ),
          ),
          child: Align(
            alignment: Alignment.bottomLeft,
            child: Padding(
              padding: const EdgeInsets.all(16.0),
              child: Text(
                movie['title']!,
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
        ),
      );
    }).toList(),
  );
}

Widget _buildTopBar() {
  final bool isDark = Theme.of(context).brightness == Brightness.dark;
  return SafeArea(
    child: Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 4.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          // App title
          Text(
            'DramaMania',
            style: TextStyle(
              color: isDark ? Colors.white : const Color(0xFF4d0066),
              fontSize: 20,
            ),
          ),
          // A small search hint container
          GestureDetector(
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => SearchScreen(
                    allMovies: [...newReleases, ...mostPopular],
                  ),
                ),
              );
            },
            child: Container(
              width: 120,
              height: 36,
              padding: const EdgeInsets.symmetric(horizontal: 8.0),
              decoration: BoxDecoration(
                color: isDark ? Colors.grey[800] : Colors.grey[300],
                borderRadius: BorderRadius.circular(18.0),
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Icon(
                    Icons.search,
                    size: 18,
                    color: isDark ? Colors.white : const Color(0xFF4d0066),
                  ),
                  const SizedBox(width: 4),
                  Text(
                    'Search',
                    style: TextStyle(
                      fontSize: 14,
                      color: isDark ? Colors.white70 : Colors.black54,
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    ),
  );
}

  Widget _buildGenres() {
    final bool isDark = Theme.of(context).brightness == Brightness.dark;
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Genres',
          style: TextStyle(
            color: isDark ? Colors.white : const Color(0xFF4d0066),
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
              _GenreChip(
                title: 'Anime',
                genre: 'Anime',
                isSelected: _selectedGenre == 'Anime',
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
                title: 'Horror',
                genre: 'Horror',
                isSelected: _selectedGenre == 'Horror',
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
                title: 'Thriller',
                genre: 'Thriller',
                isSelected: _selectedGenre == 'Thriller',
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
                title: 'Sci-Fi',
                genre: 'Sci-Fi',
                isSelected: _selectedGenre == 'Sci-Fi',
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
                title: 'Mystery',
                genre: 'Mystery',
                isSelected: _selectedGenre == 'Mystery',
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
                title: 'Adventure',
                genre: 'Adventure',
                isSelected: _selectedGenre == 'Adventure',
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
                title: 'Documentary',
                genre: 'Documentary',
                isSelected: _selectedGenre == 'Documentary',
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
  final bool isDark = Theme.of(context).brightness == Brightness.dark;
  return Column(
    crossAxisAlignment: CrossAxisAlignment.start,
    children: [
      Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            'New Releases',
            style: TextStyle(
              color: isDark ? Colors.white : const Color(0xFF4d0066),
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
                      ViewAllMoviesScreen(movies: newReleases),
                ),
              );
            },
            child: Text(
              'View All',
              style: TextStyle(
                color: isDark ? Colors.white : const Color(0xFF4d0066),
              ),
            ),
          ),
        ],
      ),
      const SizedBox(height: 15),
      SizedBox(
        height: 260, // Adjusted height for fixed picture size
        child: ListView(
          scrollDirection: Axis.horizontal,
          children: newReleases
              .map(
                (movie) => _MovieCard(
                  title: movie['title']!,
                  imageUrl: movie['imageUrl']!,
                  genre: movie['genre']!,
                  duration: movie['duration']!,
                  videoUrl: movie['videoUrl']!,
                  description: movie['description']!,
                ),
              )
              .toList(),
        ),
      ),
    ],
  );
}

Widget _buildMoreMovies() {
  final bool isDark = Theme.of(context).brightness == Brightness.dark;
  return Column(
    crossAxisAlignment: CrossAxisAlignment.start,
    children: [
      Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            'Most Popular',
            style: TextStyle(
              color: isDark ? Colors.white : const Color(0xFF4d0066),
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
                      ViewAllMoviesScreen(movies: mostPopular),
                ),
              );
            },
            child: Text(
              'View All',
              style: TextStyle(
                color: isDark ? Colors.white : const Color(0xFF4d0066),
              ),
            ),
          ),
        ],
      ),
      const SizedBox(height: 15),
      SizedBox(
        height: 260, // Adjusted height for fixed picture size
        child: ListView(
          scrollDirection: Axis.horizontal,
          children: mostPopular
              .map(
                (movie) => _MovieCard(
                  title: movie['title']!,
                  imageUrl: movie['imageUrl']!,
                  genre: movie['genre']!,
                  duration: movie['duration']!,
                  videoUrl: movie['videoUrl']!,
                  description: movie['description']!,
                ),
              )
              .toList(),
        ),
      ),
    ],
  );
}



  Widget _buildBottomNavigationBar() {
    final bool isDark = Theme.of(context).brightness == Brightness.dark;
    return BottomNavigationBar(
      backgroundColor: const Color(0xFF4d0066),
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
        else if (index == 3) {
          Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => const WatchVideoScreen()),
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
        BottomNavigationBarItem(
          icon: Icon(Icons.play_circle_fill),
          label: 'Watch Drama',
        ),
        
      ],
      type: BottomNavigationBarType.fixed,
    );
  }
@override
Widget build(BuildContext context) {
  final bool isDarkMode = Theme.of(context).brightness == Brightness.dark;
  // BACK BUTTON
  return WillPopScope(
    onWillPop: () async {
      DateTime now = DateTime.now();
      if (lastPressed == null || now.difference(lastPressed!) > const Duration(seconds: 2)) {
        lastPressed = now;
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            content: Text('Press back again to exit'),
            duration: Duration(seconds: 2),
          ),
        );
        return false;
      }
      if (Platform.isAndroid) {
        SystemNavigator.pop();
      } else if (Platform.isIOS) {
        exit(0);
      }
      return true;
    },
    child: Scaffold(
      backgroundColor: Theme.of(context).scaffoldBackgroundColor,
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
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                _buildTopBar(),
                const SizedBox(height: 20),
                _buildFeaturedMovie(context),
                const SizedBox(height: 25),
                _buildGenres(),
                const SizedBox(height: 25),
                _buildNewReleases(),
                _buildMoreMovies(),
              ],
            ),
          ),
        ),
      ),
      bottomNavigationBar: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          if (bannerAd != null)
            SizedBox(
              height: 50,
              child: AdWidget(ad: bannerAd!),
            ),
          BottomNavigationBar(
            backgroundColor: const Color(0xFF4d0066),
            selectedItemColor: Colors.white,
            unselectedItemColor: Colors.white70,
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
              } else if (index == 3) {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => const WatchVideoScreen()),
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
              BottomNavigationBarItem(
                icon: Icon(Icons.play_circle_fill),
                label: 'Watch Drama',
              ),
            ],
            type: BottomNavigationBarType.fixed,
          ),
        ],
      ),
    ),
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

  // Function to determine the background color based on the genre
  Color getGenreColor(String genre) {
    switch (genre) {
      case 'Romance':
        return Colors.pink;
      case 'Action':
        return Colors.red;
      case 'Fantasy':
        return Colors.purple;
      case 'Drama':
        return Colors.blue;
      case 'Comedy':
        return Colors.orange;
      case 'Adventure':
        return Colors.green;
      case 'Horror':
        return Colors.brown;
      case 'Thriller':
        return Colors.deepPurple;
      case 'Sci-Fi':
        return Colors.cyan;
      case 'Mystery':
        return Colors.indigo;
      case 'Documentary':
        return Colors.teal;
      default:
        return Colors.grey;
    }
  }

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () => onSelected(genre),
      hoverColor: getGenreColor(genre).withOpacity(0.5), // Highlight color on hover
      borderRadius: BorderRadius.circular(20), // Match the chip's border radius
      child: Container(
        margin: const EdgeInsets.only(right: 10),
        padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 8),
        decoration: BoxDecoration(
          color: isSelected ? getGenreColor(genre) : Colors.white, // Background color
          borderRadius: BorderRadius.circular(20),
          border: Border.all(
            color: getGenreColor(genre), // Border color matches the background
            width: 1,
          ),
        ),
        child: Text(
          title,
          style: TextStyle(
            color: isSelected ? Colors.white : getGenreColor(genre), // Text color
            fontSize: 16,
          ),
        ),
      ),
    );
  }
}

class _MovieCard extends StatelessWidget {
  final String title;
  final String imageUrl;
  final String genre;
  final String duration;
  final String videoUrl;
  final String description; // New parameter

  const _MovieCard({
    Key? key,
    required this.title,
    required this.imageUrl,
    required this.genre,
    required this.duration,
    required this.videoUrl,
    required this.description,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final bool isDarkMode = Theme.of(context).brightness == Brightness.dark;

    return GestureDetector(
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => MovieDetailsScreen(
              title: title,
              genre: genre,
              duration: duration,
              rating: "", // Optionally update rating if needed
              description: description, // Use the provided description
              imageUrl: imageUrl,
              videoUrl: videoUrl,
            ),
          ),
        );
      },
      child: Container(
        width: 160,
        margin: const EdgeInsets.only(right: 15),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(15),
          color: isDarkMode ? Colors.black : Colors.white,
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.1),
              blurRadius: 8,
              offset: const Offset(0, 4),
            ),
          ],
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Image area
            Stack(
              children: [
                ClipRRect(
                  borderRadius: const BorderRadius.vertical(top: Radius.circular(15)),
                  child: Image.network(
                    imageUrl,
                    height: 210,
                    width: double.infinity,
                    fit: BoxFit.cover,
                  ),
                ),
                Container(
                  height: 210,
                  decoration: BoxDecoration(
                    borderRadius: const BorderRadius.vertical(top: Radius.circular(15)),
                    gradient: LinearGradient(
                      begin: Alignment.bottomCenter,
                      end: Alignment.topCenter,
                      colors: [
                        Colors.black.withOpacity(0.6),
                        Colors.transparent,
                      ],
                    ),
                  ),
                ),
              ],
            ),
            // Title area
            Padding(
              padding: const EdgeInsets.fromLTRB(10, 10, 10, 0),
              child: Container(
                width: double.infinity,
                alignment: title.length < 15 ? Alignment.center : Alignment.centerLeft,
                child: Text(
                  title,
                  maxLines: 2,
                  overflow: TextOverflow.ellipsis,
                  style: TextStyle(
                    color: isDarkMode ? Colors.white : const Color(0xFF4d0066),
                    fontWeight: FontWeight.bold,
                    fontSize: 14,
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}