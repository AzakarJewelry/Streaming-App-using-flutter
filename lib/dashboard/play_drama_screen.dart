import 'package:flutter/material.dart';
import 'package:video_player/video_player.dart';
import 'package:screen_protector/screen_protector.dart';

class PlayDramaScreen extends StatefulWidget {
  final List<String> videoList;
  final String title;

  const PlayDramaScreen({
    super.key,
    required this.videoList,
    required this.title,
  });

  @override
  _PlayDramaScreenState createState() => _PlayDramaScreenState();
}

class _PlayDramaScreenState extends State<PlayDramaScreen> {
  late VideoPlayerController _controller;
  int _currentPartIndex = 0;
  bool _isPlaying = false;
  bool _hasVideos = true;
  bool _isButtonVisible = true; // Button visibility

  @override
  void initState() {
    super.initState();
    avoidScreenShot();
    if (widget.videoList.isNotEmpty) {
      _initializeVideoPlayer(widget.videoList[_currentPartIndex]);
    } else {
      _hasVideos = false;
      print("Error: videoList is empty");
    }
  }

  Future<void> avoidScreenShot() async {
    await ScreenProtector.protectDataLeakageOn();
  }

  void _initializeVideoPlayer(String url) {
    _controller = VideoPlayerController.network(url)
      ..initialize().then((_) {
        setState(() {});
        _controller.play();
        _isPlaying = true;
        _hideControlsAfterDelay();
      });
  }

  @override
  void dispose() {
    if (_hasVideos) {
      _controller.dispose();
    }
    super.dispose();
  }

  void _togglePlayPause() {
    if (_hasVideos) {
      setState(() {
        if (_controller.value.isPlaying) {
          _controller.pause();
          _isPlaying = false;
        } else {
          _controller.play();
          _isPlaying = true;
        }
        _isButtonVisible = true; // Show button when tapped
        _hideControlsAfterDelay(); // Start hiding timer
      });
    }
  }

  void _hideControlsAfterDelay() {
    Future.delayed(const Duration(seconds: 3), () {
      if (_controller.value.isPlaying) {
        setState(() {
          _isButtonVisible = false;
        });
      }
    });
  }

  void _playEpisode(int episodeIndex) {
    if (_hasVideos) {
      setState(() {
        _currentPartIndex = episodeIndex;
        _controller.dispose();
        _initializeVideoPlayer(widget.videoList[_currentPartIndex]);
      });
    }
  }
@override
Widget build(BuildContext context) {
  return Scaffold(
    backgroundColor: Colors.black,
    body: _hasVideos
        ? Stack(
            children: [
              // Video Player Section with Gesture Detection
              GestureDetector(
                onTap: () {
                  setState(() {
                    _isButtonVisible = !_isButtonVisible;
                  });
                  if (_isButtonVisible) _hideControlsAfterDelay();
                },
                child: Center(
                  child: _controller.value.isInitialized
                      ? AspectRatio(
                          aspectRatio: _controller.value.aspectRatio,
                          child: VideoPlayer(_controller),
                        )
                      : Container(
                          color: Colors.black,
                          child: const Center(child: CircularProgressIndicator()),
                        ),
                ),
              ),

              // Back Button & Title (Upper Left, Hidden Until Tap)
              if (_isButtonVisible)
                Positioned(
                  top: 40, // Adjusted for safe area
                  left: 10,
                  child: Row(
                    children: [
                      IconButton(
                        icon: const Icon(Icons.arrow_back, color: Colors.white),
                        onPressed: () => Navigator.pop(context),
                      ),
                      const SizedBox(width: 10),
                      Text(
                        widget.title,
                        style: const TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                          color: Colors.white,
                        ),
                      ),
                    ],
                  ),
                ),

              // Play/Pause Button (Centered)
              if (_isButtonVisible)
                Center(
                  child: IconButton(
                    icon: Icon(
                      _isPlaying ? Icons.pause : Icons.play_arrow,
                      color: Colors.white.withOpacity(0.7),
                      size: 70,
                    ),
                    onPressed: _togglePlayPause,
                  ),
                ),

              // Episode Buttons (Hidden Until Tapped)
              if (_isButtonVisible)
                Positioned(
                  bottom: 20,
                  left: 0,
                  right: 0,
                  child: SingleChildScrollView(
                    scrollDirection: Axis.horizontal,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: List.generate(widget.videoList.length, (index) {
                        return Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 5),
                          child: ElevatedButton(
                            style: ElevatedButton.styleFrom(
                              backgroundColor: _currentPartIndex == index
                                  ? const Color(0xFF9610ff)
                                  : Colors.white,
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(8),
                              ),
                            ),
                            onPressed: () => _playEpisode(index),
                            child: Text(
                              '${index + 1}',
                              style: TextStyle(
                                color: _currentPartIndex == index
                                    ? Colors.white
                                    : Colors.black,
                                fontSize: 16,
                              ),
                            ),
                          ),
                        );
                      }),
                    ),
                  ),
                ),
            ],
          )
        : const Center(
            child: Text(
              "No videos available",
              style: TextStyle(
                fontSize: 20,
                color: Colors.white,
              ),
            ),
          ),
  );
}


}