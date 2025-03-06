import 'dart:async';
import 'package:flutter/material.dart';
import 'play_movie_screen.dart';
import 'favorite_manager.dart'; // Ensure this is implemented and properly connected to Firestore
import 'package:google_mobile_ads/google_mobile_ads.dart';

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
  InterstitialAd? _interstitialAd;

  @override
  void initState() {
    super.initState();
    _loadInterstitialAd(); // Load ad when the screen is initialized
  }

  // Load the Interstitial Ad
  void _loadInterstitialAd() {
    InterstitialAd.load(
      adUnitId: 'ca-app-pub-3940256099942544/1033173712', // Replace with your ad unit ID
      request: AdRequest(),
      adLoadCallback: InterstitialAdLoadCallback(
        onAdLoaded: (ad) {
          setState(() {
            _interstitialAd = ad;
          });
          // Set up dismissal callback when ad is loaded
          ad.fullScreenContentCallback = FullScreenContentCallback(
            onAdDismissedFullScreenContent: (ad) {
              ad.dispose();
              _interstitialAd = null;
              _navigateToPlayMovie(); // Navigate after ad is dismissed
            },
            onAdFailedToShowFullScreenContent: (ad, error) {
              ad.dispose();
              _interstitialAd = null;
              _navigateToPlayMovie(); // Navigate even if ad fails to show
            },
          );
        },
        onAdFailedToLoad: (error) {
          print('Ad failed to load: $error');
          _navigateToPlayMovie(); // Navigate directly if ad fails to load
        },
      ),
    );
  }

  // Show the interstitial ad
  void _showInterstitialAd() {
    if (_interstitialAd != null) {
      _interstitialAd?.show();
    } else {
      _navigateToPlayMovie(); // Fallback if ad isn't loaded
    }
  }

  // Navigate to the PlayMovie screen
  void _navigateToPlayMovie() {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => PlayMovie(videoUrl: widget.videoUrl),
      ),
    );
  }

  // Show a countdown dialog before showing the ad
  void _startCountdown() {
    showDialog(
      context: context,
      barrierDismissible: false,
      builder: (context) => CountdownDialog(
        initialCountdown: 3,
        onCountdownComplete: _showInterstitialAd,
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    // Check if the current movie is a favorite.
    final bool isFavorite = favoriteManager.isFavorite(widget.title);
    final bool isDarkMode = Theme.of(context).brightness == Brightness.dark;
    final Color textColor = isDarkMode ? Colors.white : Colors.black;

    return Scaffold(
      backgroundColor: Colors.black,
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
        child: CustomScrollView(
          slivers: [
            SliverAppBar(
              expandedHeight: 400,
              floating: false,
              pinned: true,
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
                            style: TextStyle(
                              color: textColor,
                              fontSize: 24,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),
                        IconButton(
                          icon: Icon(
                            isFavorite ? Icons.favorite : Icons.favorite_border,
                            color: isFavorite ? Colors.red : textColor,
                            size: 30,
                          ),
                          onPressed: () async {
                            try {
                              // Toggle favorite in Firestore and local list.
                              await favoriteManager.toggleFavorite({
                                'title': widget.title,
                                'genre': widget.genre,
                                'duration': widget.duration,
                                'rating': widget.rating,
                                'description': widget.description,
                                'imageUrl': widget.imageUrl,
                                'videoUrl': widget.videoUrl,
                              });
                            } catch (error) {
                              debugPrint('Error toggling favorite: $error');
                            }
                            // Refresh UI after toggle.
                            setState(() {});
                          },
                        ),
                      ],
                    ),
                    const SizedBox(height: 8),
                    // Genre
                    Text(
                      widget.genre,
                      style: TextStyle(
                        color: textColor.withOpacity(0.7),
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
                          style: TextStyle(
                            color: textColor.withOpacity(0.7),
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
                        style: TextStyle(
                          color: textColor,
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
      ),
      floatingActionButton: FloatingActionButton.extended(
        // Start countdown with loading dialog before showing the ad
        onPressed: _startCountdown,
        backgroundColor: const Color(0xFF4d0066),
        icon: const Icon(Icons.play_arrow, color: Colors.white),
        label: const Text('Play Movie', style: TextStyle(color: Colors.white)),
      ),
    );
  }

  @override
  void dispose() {
    _interstitialAd?.dispose(); // Dispose of the ad when the screen is disposed
    super.dispose();
  }
}

// A custom dialog that shows a countdown and a loading indicator
class CountdownDialog extends StatefulWidget {
  final int initialCountdown;
  final VoidCallback onCountdownComplete;

  const CountdownDialog({
    Key? key,
    required this.initialCountdown,
    required this.onCountdownComplete,
  }) : super(key: key);

  @override
  _CountdownDialogState createState() => _CountdownDialogState();
}

class _CountdownDialogState extends State<CountdownDialog> {
  late int countdown;
  Timer? _timer;

  @override
  void initState() {
    super.initState();
    countdown = widget.initialCountdown;
    _timer = Timer.periodic(Duration(seconds: 1), (timer) {
      if (countdown > 1) {
        setState(() {
          countdown--;
        });
      } else {
        timer.cancel();
        Navigator.of(context).pop(); // Dismiss the dialog
        widget.onCountdownComplete();
      }
    });
  }

  @override
  void dispose() {
    _timer?.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      content: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          const CircularProgressIndicator(),
          const SizedBox(height: 20),
          Text("Playing movie in $countdown seconds..."),
        ],
      ),
    );
  }
}