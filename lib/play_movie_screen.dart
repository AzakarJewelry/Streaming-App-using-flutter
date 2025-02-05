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
  SubtitleController? _subtitleController; // Nullable
  bool _isLoadingSubtitles = true; // Track subtitle loading

  @override
  void initState() {
    super.initState();

    // Initialize the video player
    _videoPlayerController = VideoPlayerController.network(widget.videoUrl)
      ..initialize().then((_) {
        setState(() {}); // Update UI when video is initialized
      });

    _chewieController = ChewieController(
      videoPlayerController: _videoPlayerController,
      autoPlay: true,
      looping: false,
    );

    _loadSubtitles();
  }

  Future<void> _loadSubtitles() async {
    try {
      String subtitleData = await rootBundle.loadString('Assets/movie.srt');
      setState(() {
        _subtitleController = SubtitleController(
          subtitlesContent: subtitleData,
          subtitleType: SubtitleType.srt,
        );
        _isLoadingSubtitles = false;
      });
    } catch (e) {
      debugPrint("Error loading subtitles: $e");
      setState(() {
        _isLoadingSubtitles = false;
      });
    }
  }

  @override
  void dispose() {
    _videoPlayerController.dispose();
    _chewieController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
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
            ? _isLoadingSubtitles
                ? const CircularProgressIndicator() // Show loading indicator while subtitles load
                : SubtitleWrapper(
                    videoPlayerController: _videoPlayerController,
                    subtitleController: _subtitleController!,
                    subtitleStyle: const SubtitleStyle(
                      textColor: Colors.white,
                      fontSize: 16,
                      hasBorder: true,
                    ),
                    videoChild: Chewie(controller: _chewieController),
                  )
            : const CircularProgressIndicator(), // Show loading until video is initialized
      ),
    );
  }
}
