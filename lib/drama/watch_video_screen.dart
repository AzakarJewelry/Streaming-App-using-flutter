  import 'dart:async';
  import 'dart:math';
  import 'package:flutter/material.dart';
  import 'package:video_player/video_player.dart';
  import '../dashboard/play_drama_screen.dart';
  import 'package:screen_protector/screen_protector.dart';

  class WatchVideoScreen extends StatefulWidget {
    const WatchVideoScreen({super.key});

    @override
    // ignore: library_private_types_in_public_api
    _WatchVideoScreenState createState() => _WatchVideoScreenState();
  }

  class _WatchVideoScreenState extends State<WatchVideoScreen> {
    final PageController _pageController = PageController(initialPage: 0);
    late List<Map<String, dynamic>> _feedItems;
    

    @override
    void initState() {
      super.initState();
      avoidScreenShot();
      _initializeFeedItems();
    }
    Future<void> avoidScreenShot() async {
  await ScreenProtector.protectDataLeakageOn();
}

    void _initializeFeedItems() {
      _feedItems = [
        {
          'title': 'Spoiled Brat',
          'videoUrl': 'https://res.cloudinary.com/daj3wmm8g/video/upload/v1742456050/CD08_y0ucj6.mp4',
          'genre': 'Sci-Fi, Drama',
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
          'videoUrl': 'https://res.cloudinary.com/dlmeqb9qn/video/upload/v1740639042/When_Your_Wife_Watches_a_Horror_Movie_yulong_Yangmiemie_yuyang___Short_Drama_Zone_ezo9fv.mp4',
          'genre': 'Action, Drama',
          'episodes': [
            'https://res.cloudinary.com/dcwjifq5f/video/upload/v1741309652/CDrama02_ictkkw.mp4',
            'https://res.cloudinary.com/dcwjifq5f/video/upload/v1741309652/CDrama02_ictkkw.mp4',
            'https://res.cloudinary.com/dcwjifq5f/video/upload/v1741309655/CDrama03_vvpqa7.mp4',
            'https://res.cloudinary.com/dcwjifq5f/video/upload/v1741309650/CDrama04_mlwg86.mp4',
          ],
        },
        {
          'title': 'Another Day',
          'videoUrl': 'https://res.cloudinary.com/dywykbqpw/video/upload/v1740716529/sqvtdgtsintpgp1xldvo.mp4',
          'genre': 'Comedy, Drama',
          'episodes': [
            'https://res.cloudinary.com/dcwjifq5f/video/upload/v1741309655/CDrama03_vvpqa7.mp4',
            'https://res.cloudinary.com/dcwjifq5f/video/upload/v1741309655/CDrama01_gmmcxw.mp4',
            'https://res.cloudinary.com/dcwjifq5f/video/upload/v1741309652/CDrama02_ictkkw.mp4',
            'https://res.cloudinary.com/dcwjifq5f/video/upload/v1741309650/CDrama04_mlwg86.mp4',
          ],
        },
        {
          'title': 'Nevermind',
          'videoUrl': 'https://res.cloudinary.com/dcwjifq5f/video/upload/v1740974293/drama2-ep1_pssm2l.mp4',
          'genre': 'Action, Drama',
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
        appBar: AppBar(
      backgroundColor: Colors.transparent,
      elevation: 0,
      leading: IconButton(
        icon: Icon(Icons.arrow_back, color: Colors.white),
        onPressed: () {
          Navigator.pop(context);
        },
      ),
    ),
        body: PageView.builder(
          controller: _pageController,
          scrollDirection: Axis.vertical,
          itemCount: _feedItems.length,
          itemBuilder: (context, index) {
            return MultiPartVideoPlayer(
              videoUrl: _feedItems[index]['videoUrl'],
              episodes: _feedItems[index]['episodes'],
              title: _feedItems[index]['title'],
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
    final String title;
    final VoidCallback onNextFeed;
    final VoidCallback onPreviousFeed;

    const MultiPartVideoPlayer({
      super.key,
      required this.videoUrl,
      required this.episodes,
      required this.title,
      required this.onNextFeed,
      required this.onPreviousFeed,
    });

    @override
    _MultiPartVideoPlayerState createState() => _MultiPartVideoPlayerState();
  }

  class _MultiPartVideoPlayerState extends State<MultiPartVideoPlayer> {
  VideoPlayerController? _controller;

    bool _controlsVisible = true;
    Timer? _hideControlsTimer;
    


    @override
    void initState() {
      super.initState();
      _initializeVideoPlayer(widget.videoUrl);
    }

void _initializeVideoPlayer(String url) {
  // Dispose the previous controller before assigning a new one
  _controller?.dispose();
  _controller = null;

  _controller = VideoPlayerController.network(url)
    ..initialize().then((_) {
      setState(() {}); // Update UI when video is ready
      _controller?.play();
      _startHideControlsTimer();
    }).catchError((error) {
      debugPrint("Video Initialization Error: $error");
    });
}

@override
void didUpdateWidget(covariant MultiPartVideoPlayer oldWidget) {
  super.didUpdateWidget(oldWidget);
  
  if (oldWidget.videoUrl != widget.videoUrl) {
    _initializeVideoPlayer(widget.videoUrl);
  }
}

@override
void dispose() {
  _hideControlsTimer?.cancel();
  _controller?.dispose();
  _controller = null; // Set to null after disposal
  super.dispose();
}


  void _togglePlayPause() {
  if (_controller == null || !_controller!.value.isInitialized) return;

  setState(() {
    if (_controller!.value.isPlaying) {
      _controller!.pause();
    } else {
      _controller!.play();
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
        if (_controller != null && _controller!.value.isPlaying) {
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
          _controller != null && _controller!.value.isInitialized
              ? Center(
                  child: AspectRatio(
                    aspectRatio: _controller?.value.aspectRatio ?? 16 / 9,
                    child: VideoPlayer(_controller!),
                  ),
                )
              : const Center(child: CircularProgressIndicator()),
          Positioned(
            bottom: 70,
            left: 20,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  widget.title, // Display Drama Title instead of Username
                  style: const TextStyle(color: Colors.white, fontSize: 18),
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
                IconButton(
                  icon: const Icon(Icons.movie, color: Colors.white, size: 30),
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => PlayDramaScreen(
                          videoList: widget.episodes,
                          title: widget.title, // Pass the correct title
                        ),
                      ),
                    );
                  },
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}