import 'dart:async';
import 'dart:math';
import 'package:flutter/material.dart';
import 'package:video_player/video_player.dart';

class WatchVideoScreen extends StatefulWidget {
  const WatchVideoScreen({Key? key}) : super(key: key);

  @override
  _WatchVideoScreenState createState() => _WatchVideoScreenState();
}

class _WatchVideoScreenState extends State<WatchVideoScreen> {
  final PageController _pageController = PageController(initialPage: 0);
  late List<List<String>> _feedItems;

  @override
  void initState() {
    super.initState();
    _initializeFeedItems();
  }

  void _initializeFeedItems() {
    _feedItems = [
      [
        'https://res.cloudinary.com/dcwjifq5f/video/upload/v1740972448/drama1-ep1_pcaofa.mp4',
        'https://res.cloudinary.com/dcwjifq5f/video/upload/v1740972453/drama1-ep2_fudhaj.mp4',
        'https://res.cloudinary.com/dcwjifq5f/video/upload/v1740972450/drama1-ep3_yooyix.mp4',
        'https://res.cloudinary.com/dcwjifq5f/video/upload/v1740972450/drama1-ep4_h8f0zt.mp4',
        'https://res.cloudinary.com/dcwjifq5f/video/upload/v1740972453/drama1-ep5_bn2rfr.mp4',
      ],
      [
        'https://res.cloudinary.com/dlmeqb9qn/video/upload/v1740639042/When_Your_Wife_Watches_a_Horror_Movie_yulong_Yangmiemie_yuyang___Short_Drama_Zone_ezo9fv.mp4'
      ],
      [
        'https://res.cloudinary.com/dywykbqpw/video/upload/v1740716529/sqvtdgtsintpgp1xldvo.mp4', // Part 1
        'https://res.cloudinary.com/dywykbqpw/video/upload/v1740716531/kucz5aivzegthhjqftj7.mp4', // Part 2
        'https://res.cloudinary.com/dywykbqpw/video/upload/v1740716529/xga4eqjpocd5jp0x7fft.mp4', // Part 3
        'https://res.cloudinary.com/dywykbqpw/video/upload/v1740716529/fqd1cynmp6jymdokgosm.mp4', // Part 4
      ],
      [
        'https://res.cloudinary.com/dcwjifq5f/video/upload/v1740974293/drama2-ep1_pssm2l.mp4', // Part 1
        'https://res.cloudinary.com/dcwjifq5f/video/upload/v1740974287/drama2-ep2_wcltm3.mp4', // Part 2
        'https://res.cloudinary.com/dcwjifq5f/video/upload/v1740974295/drama2-ep3_s2sgsu.mp4', // Part 3
      ],

    ];
    _shuffleFeedItems();
  }

  void _shuffleFeedItems() {
    final random = Random();
    for (var item in _feedItems) {
      item.shuffle(random);
    }
    _feedItems.shuffle(random);
  }

  @override
  void dispose() {
    _pageController.dispose();
    super.dispose();
  }

  // Navigate vertically between feed items.
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
            videoParts: _feedItems[index],
            onNextFeed: _goToNextFeedItem,
            onPreviousFeed: _goToPreviousFeedItem,
          );
        },
      ),
    );
  }
}

class MultiPartVideoPlayer extends StatefulWidget {
  final List<String> videoParts;
  final VoidCallback onNextFeed;
  final VoidCallback onPreviousFeed;

  const MultiPartVideoPlayer({
    Key? key,
    required this.videoParts,
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
  int _currentPartIndex = 0;

  @override
  void initState() {
    super.initState();
    _initializeVideoPlayer(widget.videoParts[_currentPartIndex]);
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

  // When "next" is tapped:
  // • If more parts exist in this feed item, play the next part.
  // • Otherwise, move vertically to the next feed item.
  void _playNextPart() {
    if (_currentPartIndex < widget.videoParts.length - 1) {
      _currentPartIndex++;
      _controller.dispose();
      _initializeVideoPlayer(widget.videoParts[_currentPartIndex]);
    } else {
      widget.onNextFeed();
    }
  }

  // When "previous" is tapped:
  // • If not at the first part, go to the previous part.
  // • Otherwise, move vertically to the previous feed item.
  void _playPreviousPart() {
    if (_currentPartIndex > 0) {
      _currentPartIndex--;
      _controller.dispose();
      _initializeVideoPlayer(widget.videoParts[_currentPartIndex]);
    } else {
      widget.onPreviousFeed();
    }
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
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
          // Overlay for username and description
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
          // Overlay icons (like, comment, share)
          Positioned(
            bottom: 60,
            right: 20,
            child: Column(
              children: const [
                Icon(Icons.favorite, color: Colors.white, size: 30),
                SizedBox(height: 10),
                Icon(Icons.comment, color: Colors.white, size: 30),
                SizedBox(height: 10),
                Icon(Icons.movie, color: Colors.white, size: 30),
              ],
            ),
          ),
          // Video controls overlay (visible on tap)
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
                        onPressed: _playPreviousPart,
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
                        onPressed: _playNextPart,
                      ),
                    ],
                  ),
                ),
              ),
            ),
          // Back Button placed last so it's always on top.
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