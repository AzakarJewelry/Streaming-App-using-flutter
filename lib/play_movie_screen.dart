import 'package:flutter/material.dart';
import 'package:video_player/video_player.dart';
import 'package:chewie/chewie.dart';
import 'package:flutter/services.dart';

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

  @override
  void initState() {
    super.initState();
    _initializeVideoPlayer();
  }

  void _initializeVideoPlayer() {
    _videoPlayerController = VideoPlayerController.network(widget.videoUrl)
      ..initialize().then((_) {
        _videoPlayerController.setVolume(1.0);
        if (mounted) {
          setState(() {
            _chewieController = ChewieController(
              videoPlayerController: _videoPlayerController,
              autoPlay: true,
              looping: false,
              // We handle fullscreen ourselves, so set this to false:
              allowFullScreen: false,
            );
          });
        }
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
    // Ensures status bar icons are white in fullscreen or dark backgrounds
    return AnnotatedRegion<SystemUiOverlayStyle>(
      value: SystemUiOverlayStyle.light,
      child: Scaffold(
        backgroundColor: Colors.black,
        // Hide the app bar in fullscreen mode
        appBar: _isFullscreen
            ? null
            : AppBar(
                foregroundColor: Colors.white,
                backgroundColor: Colors.transparent,
                elevation: 0.0,
              ),
        // Remove SafeArea in fullscreen mode so video truly fills the screen
        body: _isFullscreen
            ? Center(child: _buildVideoPlayer())
            : SafeArea(
                child: Center(child: _buildVideoPlayer()),
              ),
      ),
    );
  }
}