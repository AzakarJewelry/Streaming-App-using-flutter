import 'dart:async';
import 'package:flutter/material.dart';
import 'package:video_player/video_player.dart';

class PlayDramaScreen extends StatefulWidget {
  final List<String> videoParts;
  final VoidCallback onNextFeed;
  final VoidCallback onPreviousFeed;

  const PlayDramaScreen({
    Key? key,
    required this.videoParts,
    required this.onNextFeed,
    required this.onPreviousFeed,
  }) : super(key: key);

  @override
  _PlayDramaScreenState createState() => _PlayDramaScreenState();
}

class _PlayDramaScreenState extends State<PlayDramaScreen> {
  late VideoPlayerController _controller;
  bool _controlsVisible = true;
  Timer? _hideControlsTimer;
  int _currentPartIndex = 0;
  bool _isPlaying = false;

  final List<String> _episodeUrls = [
    'https://res.cloudinary.com/dywykbqpw/video/upload/zrf1mbajhv8m24n9gxi7.mp4',
    'https://res.cloudinary.com/dywykbqpw/video/upload/One_Punch_Man_Season_1_-_Episode_05_English_Sub_gvmv1g.mp4',
    'https://res.cloudinary.com/dywykbqpw/video/upload/zrf1mbajhv8m24n9gxi7.mp4',
    'https://res.cloudinary.com/dywykbqpw/video/upload/One_Punch_Man_Season_1_-_Episode_05_English_Sub_gvmv1g.mp4',
  ];

  @override
  void initState() {
    super.initState();
    _initializeVideoPlayer(_episodeUrls[_currentPartIndex]);
  }

  void _initializeVideoPlayer(String url) {
    _controller = VideoPlayerController.network(url)
      ..initialize().then((_) {
        setState(() {});
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
        _isPlaying = false;
      } else {
        _controller.play();
        _isPlaying = true;
        _startHideControlsTimer();
      }
    });
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

  void _playEpisode(int episodeIndex) {
    if (episodeIndex < _episodeUrls.length) {
      setState(() {
        _currentPartIndex = episodeIndex;
        _controller.dispose();
        _initializeVideoPlayer(_episodeUrls[_currentPartIndex]);
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[200],
      body: Column(
        children: [
          Stack(
            children: [
              _controller.value.isInitialized
                  ? AspectRatio(
                      aspectRatio: _controller.value.aspectRatio,
                      child: VideoPlayer(_controller),
                    )
                  : Container(
                      height: 250,
                      color: Colors.black,
                      child: const Center(child: CircularProgressIndicator()),
                    ),
              Positioned(
                top: MediaQuery.of(context).padding.top + 10,
                left: 10,
                child: IconButton(
                  icon: const Icon(Icons.arrow_back, color: Colors.white, size: 30),
                  onPressed: () {
                    Navigator.pop(context);
                  },
                ),
              ),
              Positioned(
                bottom: 10,
                right: 10,
                child: IconButton(
                  icon: Icon(_isPlaying ? Icons.pause : Icons.play_arrow, color: Colors.white, size: 50),
                  onPressed: _togglePlayPause,
                ),
              ),
            ],
          ),
          const SizedBox(height: 10),
          const Text(
            'Back in Time',
            style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: const Text(
              'With Spider-Man’s identity now revealed, Peter asks Doctor Strange for help. When a spell goes wrong, dangerous foes from other worlds start to appear, forcing Peter to discover what it truly means to be Spider-Man.',
              textAlign: TextAlign.center,
            ),
          ),
          const SizedBox(height: 10),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: List.generate(_episodeUrls.length, (index) {
              return Padding(
                padding: const EdgeInsets.symmetric(horizontal: 5),
                child: ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    backgroundColor: _currentPartIndex == index ? Colors.purple : Colors.white,
                    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
                  ),
                  onPressed: () => _playEpisode(index),
                  child: Text(
                    '${index + 1}',
                    style: TextStyle(
                      color: _currentPartIndex == index ? Colors.white : Colors.black,
                      fontSize: 16,
                    ),
                  ),
                ),
              );
            }),
          ),
        ],
      ),
    );
  }
}
