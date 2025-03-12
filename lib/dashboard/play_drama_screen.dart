import 'package:flutter/material.dart';
import 'package:video_player/video_player.dart';
import 'package:screen_protector/screen_protector.dart';


class PlayDramaScreen extends StatefulWidget {
  final List<String> videoList;
  final String title;

  const PlayDramaScreen({
    Key? key,
    required this.videoList,
    required this.title
  }) : super(key: key);

  @override
  _PlayDramaScreenState createState() => _PlayDramaScreenState();
}

class _PlayDramaScreenState extends State<PlayDramaScreen> {
  late VideoPlayerController _controller;
  int _currentPartIndex = 0;
  bool _isPlaying = false;
  bool _hasVideos = true;

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
      });
    }
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
      appBar: AppBar(
        title: Text(widget.title),
        backgroundColor: Colors.white,
        elevation: 1,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: Colors.black),
          onPressed: () => Navigator.pop(context),
        ),
      ),
      backgroundColor: Colors.black,
      body: _hasVideos
          ? Column(
              children: [
                // Video Player Section
                Stack(
                  children: [
                    _controller.value.isInitialized
                        ? AspectRatio(
                            aspectRatio: _controller.value.aspectRatio,
                            child: VideoPlayer(_controller),
                          )
                        : Container(
                            height: 200,
                            color: Colors.black,
                            child: const Center(child: CircularProgressIndicator()),
                          ),
                    Positioned(
                      bottom: 10,
                      right: 10,
                      child: IconButton(
                        icon: Icon(
                          _isPlaying ? Icons.pause : Icons.play_arrow,
                          color: Colors.white,
                          size: 50,
                        ),
                        onPressed: _togglePlayPause,
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 10),

                // Title Section
                Text(
  widget.title, // Show dynamic movie title
  style: const TextStyle(
    fontSize: 18,
    fontWeight: FontWeight.bold,
    color: Colors.white,
  ),
),
                const SizedBox(height: 10),

                // Episode Buttons Section
                SingleChildScrollView(
                  scrollDirection: Axis.horizontal,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: List.generate(widget.videoList.length, (index) {
                      return Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 5),
                        child: ElevatedButton(
                          style: ElevatedButton.styleFrom(
                            backgroundColor: _currentPartIndex == index
                                ? Colors.purple
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