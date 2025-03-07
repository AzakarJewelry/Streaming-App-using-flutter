import 'dart:async';
import 'dart:math';
import 'package:flutter/material.dart';
import 'package:video_player/video_player.dart';
import 'play_drama_screen.dart';

class WatchVideoScreen extends StatefulWidget {
  const WatchVideoScreen({Key? key}) : super(key: key);

  @override
  _WatchVideoScreenState createState() => _WatchVideoScreenState();
}

class _WatchVideoScreenState extends State<WatchVideoScreen> {
  final PageController _pageController = PageController(initialPage: 0);
  late List<Map<String, dynamic>> _feedItems;

  @override
  void initState() {
    super.initState();
    _initializeFeedItems();
  }

  void _initializeFeedItems() {
    _feedItems = [
      {
        'videoUrl': 'https://res.cloudinary.com/dcwjifq5f/video/upload/v1740972448/drama1-ep1_pcaofa.mp4',
        'episodes': [
          'https://res.cloudinary.com/dcwjifq5f/video/upload/v1741309655/CDrama01_gmmcxw.mp4',
          'https://res.cloudinary.com/dcwjifq5f/video/upload/v1741309652/CDrama02_ictkkw.mp4',
          'https://res.cloudinary.com/dcwjifq5f/video/upload/v1741309655/CDrama03_vvpqa7.mp4',
          'https://res.cloudinary.com/dcwjifq5f/video/upload/v1741309650/CDrama04_mlwg86.mp4',
        ],
      },
      {
        'videoUrl': 'https://res.cloudinary.com/dlmeqb9qn/video/upload/v1740639042/When_Your_Wife_Watches_a_Horror_Movie_yulong_Yangmiemie_yuyang___Short_Drama_Zone_ezo9fv.mp4',
        'episodes': [
          'https://res.cloudinary.com/dcwjifq5f/video/upload/v1741309652/CDrama02_ictkkw.mp4',
          'https://res.cloudinary.com/dcwjifq5f/video/upload/v1741309652/CDrama02_ictkkw.mp4',
          'https://res.cloudinary.com/dcwjifq5f/video/upload/v1741309655/CDrama03_vvpqa7.mp4',
          'https://res.cloudinary.com/dcwjifq5f/video/upload/v1741309650/CDrama04_mlwg86.mp4',
        ],
      },
      {
        'videoUrl': 'https://res.cloudinary.com/dywykbqpw/video/upload/v1740716529/sqvtdgtsintpgp1xldvo.mp4',
        'episodes': [
          'https://res.cloudinary.com/dcwjifq5f/video/upload/v1741309655/CDrama03_vvpqa7.mp4',
          'https://res.cloudinary.com/dcwjifq5f/video/upload/v1741309655/CDrama01_gmmcxw.mp4',
          'https://res.cloudinary.com/dcwjifq5f/video/upload/v1741309652/CDrama02_ictkkw.mp4',
          'https://res.cloudinary.com/dcwjifq5f/video/upload/v1741309650/CDrama04_mlwg86.mp4',
        ],
      },
      {
        'videoUrl': 'https://res.cloudinary.com/dcwjifq5f/video/upload/v1740974293/drama2-ep1_pssm2l.mp4',
        'episodes': [
          'https://res.cloudinary.com/dcwjifq5f/video/upload/v1741309650/CDrama04_mlwg86.mp4',
          'https://res.cloudinary.com/dcwjifq5f/video/upload/v1741309655/CDrama01_gmmcxw.mp4',
          'https://res.cloudinary.com/dcwjifq5f/video/upload/v1741309652/CDrama02_ictkkw.mp4',
          'https://res.cloudinary.com/dcwjifq5f/video/upload/v1741309655/CDrama03_vvpqa7.mp4',
        ],
      },
    ];
    _shuffleFeedItems();
  }

  void _shuffleFeedItems() {
    final random = Random();
    _feedItems.shuffle(random);
  }

  @override
  void dispose() {
    _pageController.dispose();
    super.dispose();
  }

  void _goToNextFeedItem() {
    if (_pageController.hasClients &&
        _pageController.page!.toInt() < _feedItems.length - 1) {
      _pageController.nextPage(
        duration: const Duration(milliseconds: 300),
        curve: Curves.easeIn,
      );
    }
  }

  void _goToPreviousFeedItem() {
    if (_pageController.hasClients && _pageController.page!.toInt() > 0) {
      _pageController.previousPage(
        duration: const Duration(milliseconds: 300),
        curve: Curves.easeIn,
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      body: PageView.builder(
        controller: _pageController,
        scrollDirection: Axis.vertical,
        itemCount: _feedItems.length,
        itemBuilder: (context, index) {
          return MultiPartVideoPlayer(
            videoUrl: _feedItems[index]['videoUrl'],
            episodes: _feedItems[index]['episodes'],
            onNextFeed: _goToNextFeedItem,
            onPreviousFeed: _goToPreviousFeedItem,
          );
        },
      ),
    );
  }
}

class MultiPartVideoPlayer extends StatefulWidget {
  final String videoUrl;
  final List<String> episodes;
  final VoidCallback onNextFeed;
  final VoidCallback onPreviousFeed;

  const MultiPartVideoPlayer({
    Key? key,
    required this.videoUrl,
    required this.episodes,
    required this.onNextFeed,
    required this.onPreviousFeed,
  }) : super(key: key);

  @override
  _MultiPartVideoPlayerState createState() => _MultiPartVideoPlayerState();
}

class _MultiPartVideoPlayerState extends State<MultiPartVideoPlayer> {
  late VideoPlayerController _controller;
  bool _controlsVisible = true;
  Timer? _hideControlsTimer;

  @override
  void initState() {
    super.initState();
    _initializeVideoPlayer(widget.videoUrl);
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

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: _toggleControlsVisibility,
      child: Stack(
        children: [
          _controller.value.isInitialized
              ? Center(
                  child: AspectRatio(
                    aspectRatio: _controller.value.aspectRatio,
                    child: VideoPlayer(_controller),
                  ),
                )
              : const Center(child: CircularProgressIndicator()),
          Positioned(
            bottom: 70,
            left: 20,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: const [
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
                const Icon(Icons.favorite, color: Colors.white, size: 30),
                const SizedBox(height: 10),
                const Icon(Icons.watch_later, color: Colors.white, size: 30),
                const SizedBox(height: 10),
                IconButton(
                  icon: const Icon(Icons.movie, color: Colors.white, size: 30),
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => PlayDramaScreen(
                          videoList: widget.episodes,
                        ),
                      ),
                    );
                  },
                ),
              ],
            ),
          ),
          if (_controlsVisible)
            Positioned.fill(
              child: Container(
                color: Colors.black.withOpacity(0.3),
                child: Center(
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      IconButton(
                        icon: const Icon(
                          Icons.skip_previous,
                          color: Colors.white,
                          size: 50,
                        ),
                        onPressed: widget.onPreviousFeed,
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
                        icon: const Icon(
                          Icons.skip_next,
                          color: Colors.white,
                          size: 50,
                        ),
                        onPressed: widget.onNextFeed,
                      ),
                    ],
                  ),
                ),
              ),
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
        ],
      ),
    );
  }
}