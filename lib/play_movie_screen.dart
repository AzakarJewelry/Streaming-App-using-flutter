import 'package:flutter/material.dart';
import 'package:video_player/video_player.dart';
import 'package:chewie/chewie.dart';
import 'package:flutter/services.dart';
import 'package:google_mobile_ads/google_mobile_ads.dart';
import 'dart:io';

class PlayMovie extends StatefulWidget {
  final String videoUrl;

  const PlayMovie({super.key, required this.videoUrl});

  @override
  State<PlayMovie> createState() => _PlayMovieState();
}

class _PlayMovieState extends State<PlayMovie> {
  late VideoPlayerController _videoPlayerController;
  ChewieController? _chewieController;
  bool _isFullscreen = false;
  bool _isDisposed = false;
  InterstitialAd? _interstitialAd; // Interstitial ad instance
  bool _isAdPlaying = false; // Track if the ad is playing

  @override
  void initState() {
    super.initState();
    _initializeAds(); // Initialize ads
    _initializeVideoPlayer(); // Initialize video player
  }

  // Initialize Ads
  void _initializeAds() {
    MobileAds.instance.initialize();
    _loadInterstitialAd(); // Load interstitial ad
  }

  // Load Interstitial Ad
  void _loadInterstitialAd() {
    InterstitialAd.load(
      adUnitId: 'ca-app-pub-3940256099942544/1033173712', // Replace with your ad unit ID
      request: AdRequest(),
      adLoadCallback: InterstitialAdLoadCallback(
        onAdLoaded: (ad) {
          setState(() {
            _interstitialAd = ad;
          });
          _interstitialAd?.setImmersiveMode(true); // Set immersive mode for the ad
          _interstitialAd?.fullScreenContentCallback = FullScreenContentCallback(
            onAdDismissedFullScreenContent: (ad) {
              print('Ad dismissed.');
              ad.dispose(); // Dispose ad once it's dismissed
              _playVideo(); // Start video after ad is dismissed
            },
            onAdFailedToShowFullScreenContent: (ad, error) {
              print('Ad failed to show: $error');
              ad.dispose(); // Dispose ad if it fails to show
              _playVideo(); // Start video if ad fails to show
            },
          );
        },
        onAdFailedToLoad: (error) {
          print('Ad failed to load: $error');
        },
      ),
    );
  }

  // Initialize Video Player
  void _initializeVideoPlayer() {
    _videoPlayerController = VideoPlayerController.network(widget.videoUrl)
      ..initialize().then((_) {
        _videoPlayerController.setVolume(1.0);
        if (mounted) {
          setState(() {
            _chewieController = ChewieController(
              videoPlayerController: _videoPlayerController,
              autoPlay: false, // Start video only after the ad is shown
              looping: false,
              allowFullScreen: false,
            );
          });
          _showAdBeforeVideo(); // Show ad after the video is initialized
        }
      });
  }

  // Show the ad before starting the video
  void _showAdBeforeVideo() {
    if (_interstitialAd != null) {
      setState(() {
        _isAdPlaying = true; // Track ad playback status
      });
      _interstitialAd?.show(); // Show interstitial ad
      _interstitialAd = null; // Reset after showing
    } else {
      _playVideo(); // If no ad is loaded, play the video immediately
    }
  }

  // Start playing the video
  void _playVideo() {
    setState(() {
      _chewieController?.play();
      _isAdPlaying = false; // Video is now playing; ad is done
    });
  }

  // Enter fullscreen mode
  void _enterFullscreen() {
    setState(() => _isFullscreen = true);
    SystemChrome.setEnabledSystemUIMode(SystemUiMode.immersiveSticky);
    SystemChrome.setPreferredOrientations([
      DeviceOrientation.landscapeLeft,
      DeviceOrientation.landscapeRight,
    ]);
  }

  // Exit fullscreen mode
  void _exitFullscreen() {
    setState(() => _isFullscreen = false);
    SystemChrome.setEnabledSystemUIMode(SystemUiMode.edgeToEdge);
    SystemChrome.setPreferredOrientations([
      DeviceOrientation.portraitUp,
    ]);
  }

  // Toggle fullscreen mode
  void _toggleFullscreen() {
    if (_isFullscreen) {
      _exitFullscreen();
    } else {
      _enterFullscreen();
    }
  }

  @override
  void dispose() {
    _isDisposed = true;
    _videoPlayerController.dispose();
    _chewieController?.dispose();
    _interstitialAd?.dispose(); // Dispose interstitial ad
    super.dispose();
  }

  // Build the video player widget
  Widget _buildVideoPlayer() {
    if (_isDisposed || !_videoPlayerController.value.isInitialized) {
      return const Center(child: CircularProgressIndicator());
    }
    return Stack(
      children: [
        AspectRatio(
          aspectRatio: _videoPlayerController.value.aspectRatio,
          child: Chewie(controller: _chewieController!),
        ),
        Positioned(
          bottom: 25.0,
          right: 25.0,
          child: IconButton(
            icon: Icon(
              _isFullscreen ? Icons.fullscreen_exit : Icons.fullscreen,
              color: Colors.white,
            ),
            onPressed: _toggleFullscreen,
          ),
        ),
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    if (_isAdPlaying) {
      return Scaffold(
        backgroundColor: Colors.black,
        body: Center(
          child: CircularProgressIndicator(), // Display while the ad is showing
        ),
      );
    }

    return Scaffold(
      backgroundColor: Colors.black, // Dark background
      appBar: AppBar(
        foregroundColor: Colors.white,
        backgroundColor: Colors.transparent,
        elevation: 0.0,
      ),
      body: SafeArea(
        child: Center(
          child: _buildVideoPlayer(), // Video player appears here after the ad
        ),
      ),
    );
  }
}
