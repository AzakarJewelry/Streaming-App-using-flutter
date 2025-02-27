import 'dart:async';
import 'package:flutter/material.dart';
import 'package:video_player/video_player.dart';

class WatchVideoScreen extends StatefulWidget {
  const WatchVideoScreen({super.key});

  @override
  _WatchVideoScreenState createState() => _WatchVideoScreenState();
}

class _WatchVideoScreenState extends State<WatchVideoScreen> {
  late VideoPlayerController _controller;
  bool _controlsVisible = true;
  Timer? _hideControlsTimer;
  int _currentVideoIndex = 0;

  final List<String> _videoUrls = [
    'https://res.cloudinary.com/dcwjifq5f/video/upload/v1740630317/Get_a_pic_it_ll_last_you_long_ExtraLChallenge_nbenn3.mp4',
    'https://res.cloudinary.com/dlmeqb9qn/video/upload/v1740639042/When_Your_Wife_Watches_a_Horror_Movie_yulong_Yangmiemie_yuyang___Short_Drama_Zone_ezo9fv.mp4'
  ];

  @override
  void initState() {
    super.initState();
    _initializeVideoPlayer(_videoUrls[_currentVideoIndex]);
  }

  void _initializeVideoPlayer(String url) {
    _controller = VideoPlayerController.network(url)
      ..initialize().then((_) {
        setState(() {});
        _controller.play();
        _startHideControlsTimer();
      });
  }

  @override
  void dispose() {
    _controller.dispose();
    _hideControlsTimer?.cancel();
    super.dispose();
  }

  void _togglePlayPause() {
    setState(() {
      if (_controller.value.isPlaying) {
        _controller.pause();
      } else {
        _controller.play();
        _startHideControlsTimer();
      }
    });
  }

  void _toggleControlsVisibility() {
    setState(() {
      _controlsVisible = !_controlsVisible;
    });

    if (_controlsVisible) {
      _startHideControlsTimer();
    } else {
      _hideControlsTimer?.cancel();
    }
  }

  void _startHideControlsTimer() {
    _hideControlsTimer?.cancel();
    _hideControlsTimer = Timer(const Duration(seconds: 3), () {
      if (_controller.value.isPlaying) {
        setState(() {
          _controlsVisible = false;
        });
      }
    });
  }

  void _playNextVideo() {
    if (_currentVideoIndex < _videoUrls.length - 1) {
      _currentVideoIndex++;
      _controller.dispose();
      _initializeVideoPlayer(_videoUrls[_currentVideoIndex]);
    }
  }

  void _playPreviousVideo() {
    if (_currentVideoIndex > 0) {
      _currentVideoIndex--;
      _controller.dispose();
      _initializeVideoPlayer(_videoUrls[_currentVideoIndex]);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black, // Set background color to black
      body: GestureDetector(
        onTap: _toggleControlsVisibility,
        child: Stack(
          children: [
            // Video Player
            _controller.value.isInitialized
                ? Center(
                    child: AspectRatio(
                      aspectRatio: _controller.value.aspectRatio,
                      child: VideoPlayer(_controller),
                    ),
                  )
                : const Center(child: CircularProgressIndicator()),

            // Text and Icons Overlay
            Positioned(
              bottom: 70,
              left: 20,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    '@username',
                    style: TextStyle(color: Colors.white, fontSize: 18),
                  ),
                  SizedBox(height: 10),
                  Text(
                    'Video description goes here...',
                    style: TextStyle(color: Colors.white, fontSize: 14),
                  ),
                ],
              ),
            ),
            Positioned(
              bottom: 60,
              right: 20,
              child: Column(
                children: [
                  Icon(Icons.favorite, color: Colors.white, size: 30),
                  SizedBox(height: 10),
                  Icon(Icons.comment, color: Colors.white, size: 30),
                  SizedBox(height: 10),
                  Icon(Icons.share, color: Colors.white, size: 30),
                ],
              ),
            ),

            // Video Controls (Visible on Tap)
            if (_controlsVisible)
              Positioned.fill(
                child: Container(
                  color: Colors.black.withOpacity(0.3), // Dims background when controls are visible
                  child: Center(
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        IconButton(
                          icon: Icon(Icons.skip_previous, color: Colors.white, size: 50),
                          onPressed: _playPreviousVideo,
                        ),
                        IconButton(
                          icon: Icon(
                            _controller.value.isPlaying ? Icons.pause : Icons.play_arrow,
                            color: Colors.white,
                            size: 60,
                          ),
                          onPressed: _togglePlayPause,
                        ),
                        IconButton(
                          icon: Icon(Icons.skip_next, color: Colors.white, size: 50),
                          onPressed: _playNextVideo,
                        ),
                      ],
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
