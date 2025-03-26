import 'dart:io';
import 'dart:ui'; // Needed for ImageFilter.blur
import 'package:azakarstream/dashboard/SearchScreen.dart';

import '../../favorites/favorites_screen.dart'; // Import the FavoriteScreen
import 'package:azakarstream/drama/watch_video_screen.dart';
import 'package:flutter/material.dart';
import 'movie_details_screen.dart';
import 'view_all_movies_screen.dart'; // Import the new screen
import 'genre_screen.dart'; // Import the GenreScreen
import '../../profile/profile_screen.dart'; // Import the ProfileScreen
import 'play_drama_screen.dart'; // Import the PlayDramaScreen
import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/services.dart';
import 'package:screen_protector/screen_protector.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'dart:async';




class DashboardScreen extends StatefulWidget {
  const DashboardScreen({super.key});

  @override
  _DashboardScreenState createState() => _DashboardScreenState();
}

class _DashboardScreenState extends State<DashboardScreen> {
  String? _selectedGenre; // Track the selected genre
  int _selectedNavIndex = 0; // Track the selected navigation index

  Timer? _timer;
  StreamSubscription? _streamSubscription;
  String _data = "Loading...";

  // Variable to track the last back button press time
  DateTime? lastPressed;

  @override
  void initState() {
    super.initState();
    avoidScreenShot(); // Call the function after initState
    fetchData();
    startTimer();

    SystemChannels.lifecycle.setMessageHandler((msg) async {
      if (msg == AppLifecycleState.paused.toString()) {
        _navigateToDashboard();
      }
      return null;
    });

  }

  Future<void> avoidScreenShot() async {
    await ScreenProtector.protectDataLeakageOn();
  }

  void _navigateToDashboard() {
    Navigator.pushAndRemoveUntil(
      context,
      MaterialPageRoute(builder: (context) => const DashboardScreen()),
      (Route<dynamic> route) => false,
    );
  }
  
  // Simulated Async Data Fetching
  Future<void> fetchData() async {
    var data = await Future.delayed(Duration(seconds: 2), () => "Dashboard Data Loaded");
    
    if (!mounted) return; // Prevents calling setState after dispose
    setState(() {
      _data = data;
    });
  }
 // Example of Using a Timer
  void startTimer() {
    _timer = Timer.periodic(Duration(seconds: 5), (timer) {
      if (!mounted) {
        timer.cancel();
        return;
      }
      setState(() {
        _data = "Updated at ${DateTime.now()}";
      });
    });
  }
  @override
  void dispose() {
 _timer?.cancel(); // Cancel timer to prevent errors
    _streamSubscription?.cancel(); // Cancel any active stream
    super.dispose();
  }
final List<Map<String, dynamic>> featuredMovies = [
      {
        'title': 'Spoiled Brat',
        'type': 'featured',
        'imageUrl': 'https://res.cloudinary.com/daj3wmm8g/image/upload/v1742455958/poster_tatl47.jpg',
        'genre': 'Sci-Fi, Drama',
        'videoUrl': 'https://example.com/dandadan.mp4',
        'description': 'Dandadan is an action-packed sci-fi adventure about a mysterious power.',
        'episodes': [
          'https://res.cloudinary.com/daj3wmm8g/video/upload/v1742456059/CD01_vckl0v.mp4',
          'https://res.cloudinary.com/daj3wmm8g/video/upload/v1742456053/CD02_ddcc3y.mp4',
          'https://res.cloudinary.com/daj3wmm8g/video/upload/v1742456072/CD03_hde0im.mp4',
          'https://res.cloudinary.com/daj3wmm8g/video/upload/v1742456073/CD04_pebplh.mp4',
          'https://res.cloudinary.com/daj3wmm8g/video/upload/v1742456057/CD05_q5mfuj.mp4',
          'https://res.cloudinary.com/daj3wmm8g/video/upload/v1742456054/CD06_qushaz.mp4',
          'https://res.cloudinary.com/daj3wmm8g/video/upload/v1742456068/CD07_twfazj.mp4',
          'https://res.cloudinary.com/daj3wmm8g/video/upload/v1742456050/CD08_y0ucj6.mp4',
          'https://res.cloudinary.com/daj3wmm8g/video/upload/v1742456066/CD09_lslfgw.mp4',
          'https://res.cloudinary.com/daj3wmm8g/video/upload/v1742456063/CD10_n4tj2o.mp4',
          'https://res.cloudinary.com/daj3wmm8g/video/upload/v1742456050/CD11_rirqgw.mp4',
          'https://res.cloudinary.com/daj3wmm8g/video/upload/v1742456045/CD12_gzfcrr.mp4',


        ],
      },
      {
        'title': 'I Am Not a Robot',
        'type': 'featured',
        'imageUrl': 'https://res.cloudinary.com/dkhe2vgto/image/upload/v1741224888/8f9058d880e7e14b11ff2cbf89a7a57a_c96oys.jpg',
        'genre': 'Action, Drama',
        'videoUrl': 'https://example.com/dr_strange.mp4',
        'description': 'Doctor Strange embarks on a journey through the multiverse.',
        'episodes': [
          'https://res.cloudinary.com/dcwjifq5f/video/upload/v1741309652/CDrama02_ictkkw.mp4',
          'https://res.cloudinary.com/dcwjifq5f/video/upload/v1741309652/CDrama02_ictkkw.mp4',
          'https://res.cloudinary.com/dcwjifq5f/video/upload/v1741309655/CDrama03_vvpqa7.mp4',
          'https://res.cloudinary.com/dcwjifq5f/video/upload/v1741309650/CDrama04_mlwg86.mp4',
        ],
      },
      {
        'title': 'Another Day',
        'type': 'featured',
        'imageUrl': 'https://res.cloudinary.com/dkhe2vgto/image/upload/v1741224904/7be13247ab96ed300d600184de481862_gwdqbs.jpg',
        'genre': 'Comedy, Drama',
        'videoUrl': 'https://example.com/deadpool_wolverine.mp4',
        'description': 'Deadpool and Wolverine team up for an unexpected adventure.',
        'episodes': [
          'https://res.cloudinary.com/dcwjifq5f/video/upload/v1741309655/CDrama03_vvpqa7.mp4',
          'https://res.cloudinary.com/dcwjifq5f/video/upload/v1741309655/CDrama01_gmmcxw.mp4',
          'https://res.cloudinary.com/dcwjifq5f/video/upload/v1741309652/CDrama02_ictkkw.mp4',
          'https://res.cloudinary.com/dcwjifq5f/video/upload/v1741309650/CDrama04_mlwg86.mp4',
        ],
      },
      {
        'title': 'Nevermind',
        'type': 'featured',
        'imageUrl': 'https://res.cloudinary.com/dkhe2vgto/image/upload/v1741225128/c416cb9f200ea3a34974f28de47c62e1_r2syn5.jpg',
        'genre': 'Action, Drama',
        'videoUrl': 'https://res.cloudinary.com/dkhe2vgto/video/upload/AH2_SAKAMOTO_DAYS_-_01_1080p_v0.mkv_1_qccg8z.mp4',
        'description': 'Sakamoto, a former hitman, tries to live a peaceful life but trouble follows him.',
        'episodes': [
          'https://res.cloudinary.com/dcwjifq5f/video/upload/v1741309650/CDrama04_mlwg86.mp4',
          'https://res.cloudinary.com/dcwjifq5f/video/upload/v1741309655/CDrama01_gmmcxw.mp4',
          'https://res.cloudinary.com/dcwjifq5f/video/upload/v1741309652/CDrama02_ictkkw.mp4',
          'https://res.cloudinary.com/dcwjifq5f/video/upload/v1741309655/CDrama03_vvpqa7.mp4',
        ],
      },
      {
        'title': 'Kill My Sins',
        'type': 'featured',
        'imageUrl': 'https://res.cloudinary.com/dkhe2vgto/image/upload/v1741225215/c2125f3b610c3903d9401f07ddadaae8_e6xpr0.jpg',
        'genre': 'Drama, Horror',
        'videoUrl': 'https://example.com/oppenheimer.mp4',
        'description': 'A historical drama about the making of the atomic bomb and its consequences.',
        'episodes': [
          'https://res.cloudinary.com/dcwjifq5f/video/upload/v1741309650/CDrama04_mlwg86.mp4',
          'https://res.cloudinary.com/dcwjifq5f/video/upload/v1741309655/CDrama01_gmmcxw.mp4',
          'https://res.cloudinary.com/dcwjifq5f/video/upload/v1741309652/CDrama02_ictkkw.mp4',
          'https://res.cloudinary.com/dcwjifq5f/video/upload/v1741309655/CDrama03_vvpqa7.mp4',
        ],
      },
    ];

  // Updated movie lists with videoUrl field.
  final List<Map<String, dynamic>> newReleases = [
  {
    'title': 'One Piece',
    'rating': '',
    'reviews': '',
    'type': 'movie',
    'imageUrl':
        'https://m.media-amazon.com/images/M/MV5BMTNjNGU4NTUtYmVjMy00YjRiLTkxMWUtNzZkMDNiYjZhNmViXkEyXkFqcGc@._V1_.jpg',
    'genre': 'Action, Fantasy, Anime, Adventure',
    'duration': '2h 4m',
    'videoUrl':
        'https://res.cloudinary.com/dywykbqpw/video/upload/zrf1mbajhv8m24n9gxi7.mp4',
    'description': 'Join Monkey D. Luffy and his crew on an epic adventure in search of the ultimate treasure, One Piece.'
  },
  {
    'title': 'One Punch Man',
    'rating': '',
    'reviews': '',
    'type': 'movie',
    'imageUrl':
        'https://upload.wikimedia.org/wikipedia/en/c/c3/OnePunchMan_manga_cover.png',
    'genre': 'Adventure, Action, Sci-Fi',
    'duration': '2h 4m',
    'videoUrl':
        'https://res.cloudinary.com/dywykbqpw/video/upload/One_Punch_Man_Season_1_-_Episode_05_English_Sub_gvmv1g.mp4',
    'description': 'Follow Saitama, a hero who can defeat any enemy with a single punch, as he searches for a true challenge.'
  },
  {
    'title': 'Sakamoto Days',
    'rating': '',
    'reviews': '',
    'type': 'movie',
    'imageUrl':
        'https://res.cloudinary.com/dkhe2vgto/image/upload/v1739157398/Sakamoto_qmwwmw.jpg',
    'genre': 'Action, Thriller',
    'duration': '2h 4m',
    'videoUrl':
        'https://res.cloudinary.com/dkhe2vgto/video/upload/AH2_SAKAMOTO_DAYS_-_01_1080p_v0.mkv_1_qccg8z.mp4',
    'description': 'An ex-assassin turned family man is pulled back into action in this thrilling and humorous series.'
  },
  {
    'title': 'I Have a Crush at Work',
    'rating': '',
    'reviews': '',
    'type': 'movie',
    'imageUrl':
        'https://res.cloudinary.com/dkhe2vgto/image/upload/9f76212f36053b1cb40bf7468b463e82_dyctyj.jpg',
    'genre': 'Romance, Mystery',
    'duration': '2h 4m',
    'videoUrl':
        'https://res.cloudinary.com/dkhe2vgto/video/upload/AH2_I_Have_a_Crush_at_Work_-_01_1080p_v0.mkv_fslfz2.mp4',
    'description': 'A heartwarming tale of office romance where unexpected love blossoms amidst everyday work challenges.'
  },
  {
    'title': 'Spider-Man: No Way Home',
    'rating': '',
    'reviews': '',
    'type': 'movie',
    'imageUrl':
        'https://m.media-amazon.com/images/M/MV5BZWMyYzFjYTYtNTRjYi00OGExLWE2YzgtOGRmYjAxZTU3NzBiXkEyXkFqcGdeQXVyMzQ0MzA0NTM@._V1_FMjpg_UX1000_.jpg',
    'genre': 'Action, Sci-Fi, Horror',
    'duration': '2h 4m',
    'videoUrl':
        'https://res.cloudinary.com/dkhe2vgto/video/upload/y2mate.com_-_Defeating_Doc_Ock_SpiderMan_2_Voyage_With_Captions_1080_eufgx6.mp4',
    'description': 'Experience the multiverse adventure as Spider-Man faces enemies from different dimensions in an epic battle.'
  },
  {
    'title': 'Horimiya: The Missing Pieces',
    'rating': '',
    'reviews': '',
    'type': 'movie',
    'imageUrl':
        'https://res.cloudinary.com/dkhe2vgto/image/upload/horimiya_mekupa.jpg',
    'genre': 'Fantasy, Drama',
    'duration': '2h 4m',
    'videoUrl':
        'https://res.cloudinary.com/dkhe2vgto/video/upload/SubsPlease_Horimiya_-_Piece_-_01_1080p_F8A2CB28_.mkv_wan7d0.mp4',
    'description': 'A slice-of-life story that reveals hidden sides of its characters through charming and unexpected moments.'
  },
];

final List<Map<String, dynamic>> mostPopular = [
  {
    'title': 'The Batman',
    'rating': '',
    'reviews': '',
    'type': 'movie',
    'imageUrl':
        'https://m.media-amazon.com/images/M/MV5BMDdmMTBiNTYtMDIzNi00NGVlLWIzMDYtZTk3MTQ3NGQxZGEwXkEyXkFqcGdeQXVyMzMwOTU5MDk@._V1_.jpg',
    'genre': 'Action, Mystery',
    'duration': '2h 56m',
    'videoUrl': 'https://example.com/the_batman.mp4',
    'description': 'A dark, brooding detective battles corruption in Gotham City as he dons the cape to fight for justice.'
  },
  {
    'title': 'Black Panther',
    'rating': '',
    'reviews': '',
    'type': 'movie',
    'imageUrl':
        'https://m.media-amazon.com/images/M/MV5BNTM4NjIxNmEtYWE5NS00NDczLTkyNWQtYThhNmQyZGQzMjM0XkEyXkFqcGdeQXVyODk4OTc3MTY@._V1_FMjpg_UX1000_.jpg',
    'genre': 'Action, Fantasy',
    'duration': '2h 14m',
    'videoUrl': 'https://example.com/black_panther.mp4',
    'description': 'Wakanda’s king rises to the challenge, defending his nation with cutting-edge technology and unmatched courage.'
  },
  {
    'title': 'Avatar: The Way of Water',
    'rating': '',
    'type': 'movie',
    'reviews': '',
    'imageUrl':
        'https://m.media-amazon.com/images/M/MV5BYjhiNjBlODctY2ZiOC00YjVlLWFlNzAtNTVhNzM1YjI1NzMxXkEyXkFqcGdeQXVyMjQxNTE1MDA@._V1_FMjpg_UX1000_.jpg',
    'genre': 'Drama, Comedy',
    'duration': '2h 14m',
    'videoUrl': 'https://example.com/avatar_the_way_of_water.mp4',
    'description': 'Dive into a visually stunning journey exploring the deep connection between humanity and nature on Pandora.'
  },
  {
    'title': 'Top Gun: Maverick',
    'rating': '',
    'reviews': '',
    'type': 'movie',
    'imageUrl':
        'https://m.media-amazon.com/images/M/MV5BZWYzOGEwNTgtNWU3NS00ZTQ0LWJkODUtMmVhMjIwMjA1ZmQwXkEyXkFqcGdeQXVyMjkwOTAyMDU@._V1_FMjpg_UX1000_.jpg',
    'genre': 'Action, Documentary',
    'duration': '2h 14m',
    'videoUrl': 'https://example.com/top_gun_maverick.mp4',
    'description': 'High-flying action and heart-pounding aerial battles define this sequel as Maverick soars once again.'
  },
  {
    'title': 'Titanic',
    'rating': '',
    'reviews': '',
    'type': 'movie',
    'imageUrl':
        'https://res.cloudinary.com/dkhe2vgto/image/upload/titanic_xowrkm.jpg',
    'genre': 'Romance, Mystery',
    'duration': '2h 14m',
    'videoUrl': 'https://example.com/titanic.mp4',
    'description': 'A timeless romance unfolds amidst a tragic maritime disaster, capturing hearts across generations.'
  },
  {
    'title': 'The Little Man',
    'rating': '',
    'reviews': '',
    'type': 'movie',
    'imageUrl':
        'https://th.bing.com/th/id/OIP.VcW6HtnsQerz4KJBq6IxAwHaKb?w=588&h=828&rs=1&pid=ImgDetMain',
    'genre': 'Comedy, Action',
    'duration': '2h 56m',
    'videoUrl': 'https://example.com/the_little_man.mp4',
    'description': 'A jewel thief with dwarfism hides his loot by pretending to be a very large baby in a hilarious caper.'
  },
];

Widget _buildFeaturedMovie(BuildContext context) {
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
              builder: (context) => PlayDramaScreen(
                videoList: movie['episodes']!,
                title: movie['title']!,
              ),
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
                    ),
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
              color: isDark ? Colors.white : const Color(0xFF6152FF),
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
                    allMovies: [...featuredMovies, ...newReleases, ...mostPopular],
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
                    color: isDark ? Colors.white : const Color(0xFF6152FF),
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
            color: isDark ? Colors.white : const Color(0xFF6152FF),
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
                        allMovies: [...featuredMovies, ...newReleases, ...mostPopular],
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
                        allMovies: [...featuredMovies, ...newReleases, ...mostPopular],
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
                        allMovies: [...featuredMovies, ...newReleases, ...mostPopular],
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
                        allMovies: [...featuredMovies, ...newReleases, ...mostPopular],
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
                        allMovies: [...featuredMovies, ...newReleases, ...mostPopular],
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
                        allMovies: [...featuredMovies, ...newReleases, ...mostPopular],
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
                        allMovies: [...featuredMovies, ...newReleases, ...mostPopular],
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
                        allMovies: [...featuredMovies, ...newReleases, ...mostPopular],
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
                        allMovies: [...featuredMovies, ...newReleases, ...mostPopular],
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
                        allMovies: [...featuredMovies, ...newReleases, ...mostPopular],
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
                        allMovies: [...featuredMovies, ...newReleases, ...mostPopular],
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
                        allMovies: [...featuredMovies, ...newReleases, ...mostPopular],
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
              color: isDark ? Colors.white : const Color(0xFF6152FF),
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
                color: isDark ? Colors.white : const Color(0xFF6152FF),
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
              color: isDark ? Colors.white : const Color(0xFF6152FF),
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
                color: isDark ? Colors.white : const Color(0xFF6152FF),
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
@override
Widget build(BuildContext context) {
  final bool isDarkMode = Theme.of(context).brightness == Brightness.dark;

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
      body: Stack(
        children: [
          Container(
            decoration: BoxDecoration(
              gradient: LinearGradient(
                colors: isDarkMode
                    ? [
                    Color(0xFF06041f),
                    Color(0xFF06041f),
                    Color(0xFF06041f),
                    Color(0xFF06041f),
                    Color(0xFF06041f),
                    Color(0xFF06041f),
                      ]
                    : [
                        Color(0xFFffffff),
                        Color(0xFFffffff),
                        Color(0xFFffffff),
                        Color(0xFFffffff),
                        Color(0xFFffffff),
                        Color(0xFFffffff),
                        Color(0xFFffffff),
                    
                      ],
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
              ),
            ),
          child: SingleChildScrollView(
              physics: const BouncingScrollPhysics(), // Add bounce effect
              padding: const EdgeInsets.only(
                bottom: 80, // Add padding to prevent content from being hidden behind nav bar
                left: 16.0,
                right: 16.0,
                top: 16.0,
              ),
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
                  const SizedBox(height: 60), // Extra space at bottom for better scrolling
                ],
              ),
            ),
          ),
          Positioned(
            left: 20,
            right: 20,
            bottom: 0,
            child: Padding(
              padding: const EdgeInsets.only(bottom: 12.0),
              child: ClipRRect(
                borderRadius: BorderRadius.circular(20),
                child: BackdropFilter(
                  filter: ImageFilter.blur(sigmaX: 10, sigmaY: 10), // Stronger blur
                  child: Container(
                    margin: const EdgeInsets.symmetric(horizontal: 5),
                    padding: const EdgeInsets.symmetric(vertical: 5 ),
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
    ),
  );
}
  Widget _buildNavItem(String iconPath, String label, int index) {
    final isSelected = _selectedNavIndex == index;
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

  void _onItemTapped(int index) {
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

  // Fixed color for all genres
  Color getGenreColor() {
    return const Color(0xFF6152FF); // New color
  }

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () => onSelected(genre),
      hoverColor: getGenreColor().withOpacity(0.5),
      borderRadius: BorderRadius.circular(20),
      child: Container(
        margin: const EdgeInsets.only(right: 10),
        padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 8),
        decoration: BoxDecoration(
          color: isSelected ? getGenreColor() : Colors.white,
          borderRadius: BorderRadius.circular(20),
          border: Border.all(
            color: getGenreColor(),
            width: 1,
          ),
        ),
        child: Text(
          title,
          style: TextStyle(
            color: isSelected ? Colors.white : getGenreColor(), // White text when selected
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