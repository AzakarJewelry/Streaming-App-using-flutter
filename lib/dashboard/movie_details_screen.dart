import 'dart:async';
import 'package:flutter/material.dart';
import 'play_movie_screen.dart'; // Ensure this path is correct
import '../favorites/favorite_manager.dart'; // Import the favorite manager
import 'package:google_mobile_ads/google_mobile_ads.dart';

class MovieDetailsScreen extends StatefulWidget {
  final String title;
  final String imageUrl;
  final String genre;
  final String duration;
  final String videoUrl;
  final String description;

  const MovieDetailsScreen({
    super.key,
    required this.title,
    required this.imageUrl,
    required this.genre,
    required this.duration,
    required this.videoUrl,
    required this.description,
  });

  @override
  State<MovieDetailsScreen> createState() => _MovieDetailsScreenState();
}

class _MovieDetailsScreenState extends State<MovieDetailsScreen> {
  InterstitialAd? _interstitialAd;
  bool _isAdLoading = false;
  bool _adShown = false;
  final bool _adLoadFailed = false;
  bool _isDisposed = false;

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      if (!_isDisposed) {
        _loadInterstitialAd();
      }
    });
  }

  Future<void> _loadInterstitialAd() async {
    if (_isAdLoading || _interstitialAd != null || _isDisposed) return;

    _isAdLoading = true;

    try {
      await InterstitialAd.load(
        adUnitId: 'ca-app-pub-3940256099942544/1033173712',
        request: AdRequest(),
        adLoadCallback: InterstitialAdLoadCallback(
          onAdLoaded: (ad) {
            if (_isDisposed || !mounted) {
              ad.dispose();
              return;
            }
            setState(() {
              _interstitialAd = ad;
              _isAdLoading = false;
            });
            ad.fullScreenContentCallback = FullScreenContentCallback(
              onAdDismissedFullScreenContent: (ad) {
                _safeDisposeAd();
                _navigateToPlayMovie();
              },
              onAdFailedToShowFullScreenContent: (ad, error) {
                _safeDisposeAd();
                _navigateToPlayMovie();
              },
            );
          },
          onAdFailedToLoad: (error) {
            if (_isDisposed || !mounted) return;
            setState(() {
              _isAdLoading = false;
            });
            debugPrint('Ad failed to load: $error');
            _navigateToPlayMovie();
          },
        ),
      );
    } catch (error) {
      if (_isDisposed || !mounted) return;
      setState(() {
        _isAdLoading = false;
      });
      debugPrint('Error loading ad: $error');
      _navigateToPlayMovie();
    }
  }

  void _safeDisposeAd() {
    if (_isDisposed) return;
    _interstitialAd?.dispose();
    _interstitialAd = null;
    _adShown = true;
  }

  void _showInterstitialAd() {
    if (_isDisposed || !mounted) return;
    if (_interstitialAd != null && !_adShown) {
      try {
        _interstitialAd?.show();
      } catch (error) {
        debugPrint('Error showing ad: $error');
        _navigateToPlayMovie();
      }
    } else {
      _navigateToPlayMovie();
    }
  }

  void _navigateToPlayMovie() {
    if (_isDisposed || !mounted) return;
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => PlayMovie(videoUrl: widget.videoUrl),
      ),
    );
  }

  void _startCountdown() {
    if (_isDisposed || !mounted) return;
    setState(() {
      _adShown = false;
    });
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
  void dispose() {
    _isDisposed = true;
    _interstitialAd?.dispose();
    _interstitialAd = null;
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final bool isDarkMode = Theme.of(context).brightness == Brightness.dark;
    final bool isFavorite = favoriteManager.isFavorite(widget.title);
    final Color textColor = isDarkMode ? Colors.white : Colors.black;
    final Color secondaryTextColor =
        isDarkMode ? Colors.white70 : Colors.black54;
    final Color appBarColor =
        isDarkMode ? Colors.grey[900]! : Colors.grey[200]!;
    final Color iconColor = isDarkMode ? Colors.white : Colors.black;

    return Scaffold(
      backgroundColor: isDarkMode ? const Color(0xFF06041F) : Colors.white,
      body: CustomScrollView(
        slivers: [
          SliverAppBar(
            expandedHeight: 400,
            floating: false,
            pinned: true,
            backgroundColor: appBarColor,
            leading: IconButton(
              icon: Icon(Icons.arrow_back, color: iconColor),
              onPressed: () => Navigator.pop(context),
            ),
            flexibleSpace: FlexibleSpaceBar(
              background: Image.network(
                widget.imageUrl,
                fit: BoxFit.cover,
                loadingBuilder: (context, child, loadingProgress) {
                  if (loadingProgress == null) return child;
                  return Center(
                    child: CircularProgressIndicator(
                      value: loadingProgress.expectedTotalBytes != null
                          ? loadingProgress.cumulativeBytesLoaded /
                              loadingProgress.expectedTotalBytes!
                          : null,
                    ),
                  );
                },
                errorBuilder: (context, error, stackTrace) =>
                    Center(child: Icon(Icons.error, color: iconColor)),
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
                          style: TextStyle(
                            color: textColor,
                            fontSize: 24,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                      IconButton(
                        icon: Icon(
                          isFavorite
                              ? Icons.favorite
                              : Icons.favorite_border,
                          color: isFavorite ? Colors.red : iconColor,
                          size: 30,
                        ),
                        onPressed: () async {
                          try {
                            await favoriteManager.toggleFavorite({
                              'title': widget.title,
                              'genre': widget.genre,
                              'duration': widget.duration,
                              'description': widget.description,
                              'imageUrl': widget.imageUrl,
                              'videoUrl': widget.videoUrl,
                            });
                            if (mounted) setState(() {});
                          } catch (error) {
                            debugPrint('Error toggling favorite: $error');
                            if (mounted) {
                              ScaffoldMessenger.of(context).showSnackBar(
                                SnackBar(
                                  content: Text('Failed to update favorites'),
                                  backgroundColor: Colors.red,
                                ),
                              );
                            }
                          }
                        },
                      ),
                    ],
                  ),
                  const SizedBox(height: 8),
                  Text(
                    widget.genre,
                    style: TextStyle(
                      color: secondaryTextColor,
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
                          color: secondaryTextColor,
                          fontSize: 16,
                        ),
                      ),
                      const SizedBox(height: 4),
                    ],
                  ),
                  const SizedBox(height: 16),
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
      floatingActionButton: FloatingActionButton.extended(
        onPressed: _startCountdown,
        backgroundColor: const Color(0xFF6237A0),
        icon: const Icon(Icons.play_arrow, color: Colors.white),
        label: const Text('Play Movie',
            style: TextStyle(color: Colors.white)),
      ),
    );
  }
}

class CountdownDialog extends StatefulWidget {
  final int initialCountdown;
  final VoidCallback onCountdownComplete;

  const CountdownDialog({
    super.key,
    required this.initialCountdown,
    required this.onCountdownComplete,
  });

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
    _timer = Timer.periodic(const Duration(seconds: 1), (timer) {
      if (countdown > 1) {
        setState(() {
          countdown--;
        });
      } else {
        timer.cancel();
        Navigator.of(context).pop();
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
    final bool isDarkMode = Theme.of(context).brightness == Brightness.dark;

    return AlertDialog(
      backgroundColor: isDarkMode ? Colors.grey[900] : Colors.white,
      content: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          const CircularProgressIndicator(),
          const SizedBox(height: 20),
          Text(
            "Playing movie in $countdown seconds...",
            style: TextStyle(
                color: isDarkMode ? Colors.white : Colors.black),
          ),
        ],
      ),
    );
  }
}
