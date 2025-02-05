import 'package:flutter/material.dart';
import 'package:video_player/video_player.dart';
import 'package:chewie/chewie.dart';
import 'package:subtitle_wrapper_package/subtitle_wrapper_package.dart';
import 'package:flutter/services.dart';

class PlayMovie extends StatefulWidget {
  final String videoUrl;

  const PlayMovie({super.key, required this.videoUrl});

  @override
  State<PlayMovie> createState() => _PlayMovieState();
}

class _PlayMovieState extends State<PlayMovie> {
  late VideoPlayerController _videoPlayerController;
  late ChewieController _chewieController;
  SubtitleController? _subtitleController;
  bool _isLoadingSubtitles = true;
  bool _subtitlesError = false;
  bool _isFullscreen = false;

  @override
  void initState() {
    super.initState();
    _initializeVideoPlayer();
    _loadSubtitles();
  }

  void _initializeVideoPlayer() {
    _videoPlayerController = VideoPlayerController.network(widget.videoUrl)
      ..initialize().then((_) {
        setState(() {});
      });

    _chewieController = ChewieController(
      videoPlayerController: _videoPlayerController,
      autoPlay: true,
      looping: false,
      allowFullScreen: false,
    );
  }

  Future<void> _loadSubtitles() async {
    try {
      String subtitleData = await rootBundle.loadString('assets/tears.srt');
      setState(() {
        _subtitleController = SubtitleController(
          subtitlesContent: subtitleData,
          subtitleType: SubtitleType.srt,
        );
        _isLoadingSubtitles = false;
      });
    } catch (e) {
      setState(() {
        _isLoadingSubtitles = false;
        _subtitlesError = true;
      });
    }
  }

  void _enterFullscreen() {
    setState(() => _isFullscreen = true);
    SystemChrome.setEnabledSystemUIMode(SystemUiMode.immersiveSticky);
  }

  void _exitFullscreen() {
    setState(() => _isFullscreen = false);
    SystemChrome.setEnabledSystemUIMode(SystemUiMode.edgeToEdge);
  }

  void _toggleFullscreen() {
    if (_isFullscreen) {
      _exitFullscreen();
    } else {
      _enterFullscreen();
    }
  }

  @override
  void dispose() {
    _videoPlayerController.dispose();
    _chewieController.dispose();
    super.dispose();
  }

  Widget _buildVideoPlayer() {
    final subtitleWrapper = SubtitleWrapper(
      videoPlayerController: _videoPlayerController,
      subtitleController: _subtitleController ??
          SubtitleController(
            subtitlesContent: "",
            subtitleType: SubtitleType.srt,
          ),
      subtitleStyle: const SubtitleStyle(
        textColor: Colors.white,
        fontSize: 16,
        hasBorder: true,
      ),
      videoChild: Chewie(controller: _chewieController),
    );

    return _isLoadingSubtitles
        ? const CircularProgressIndicator()
        : Stack(
            children: [
              AspectRatio(
                aspectRatio: _videoPlayerController.value.aspectRatio,
                child: subtitleWrapper,
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
    if (_isFullscreen) {
      return Scaffold(
        backgroundColor: Colors.black,
        body: Stack(
          children: [
            Center(child: _buildVideoPlayer()),
            Positioned(
              top: 30,
              left: 16,
              child: IconButton(
                icon: const Icon(Icons.close, color: Colors.white),
                onPressed: _exitFullscreen,
              ),
            ),
          ],
        ),
      );
    }

    return Scaffold(
      backgroundColor: const Color(0xFF1A4D2E),
      appBar: AppBar(
        foregroundColor: const Color(0xFFF5EFE6),
        backgroundColor: const Color(0xFF1A4D2E),
        elevation: 0.0,
        title: const Text("Video Player"),
      ),
      body: Center(
        child: _videoPlayerController.value.isInitialized
            ? _buildVideoPlayer()
            : const CircularProgressIndicator(),
      ),
      bottomNavigationBar: _subtitlesError
          ? const Padding(
              padding: EdgeInsets.all(8.0),
              child: Text(
                "Error loading subtitles.",
                style: TextStyle(color: Colors.red),
                textAlign: TextAlign.center,
              ),
            )
          : null,
    );
  }
}
