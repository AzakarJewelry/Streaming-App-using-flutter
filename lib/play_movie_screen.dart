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
  SubtitleController? _subtitleController; // Nullable for null safety
  bool _isLoadingSubtitles = true; // Track subtitle loading
  bool _subtitlesError = false; // Track if subtitles failed to load

  @override
  void initState() {
    super.initState();

    // Test asset loading during initialization
    testAssetLoading();

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
      // Debug: Log before attempting to load the file
      debugPrint("Attempting to load subtitles from assets/movie.srt");

      // Load subtitles
      String subtitleData = await rootBundle.loadString('assets/movie.srt');

      // Debug: Log success
      debugPrint("Subtitles loaded successfully: $subtitleData");

      setState(() {
        _subtitleController = SubtitleController(
          subtitlesContent: subtitleData,
          subtitleType: SubtitleType.srt,
        );
        _isLoadingSubtitles = false;
      });
    } catch (e) {
      // Debug: Log any errors
      debugPrint("Error loading subtitles: $e");

      setState(() {
        _isLoadingSubtitles = false;
        _subtitlesError = true;
      });
    }
  }

  // Test function for verifying asset loading
  void testAssetLoading() async {
    try {
      debugPrint("Testing asset loading...");
      String data = await rootBundle.loadString('assets/movie.srt');
      debugPrint("Asset loaded successfully: $data");
    } catch (e) {
      debugPrint("Failed to load asset: $e");
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
                ? const CircularProgressIndicator() // Show loading indicator
                : SubtitleWrapper(
  videoPlayerController: _videoPlayerController,
  subtitleController: _subtitleController ??
      SubtitleController(
        subtitlesContent: "", // Fallback
        subtitleType: SubtitleType.srt,
      ),
  subtitleStyle: const SubtitleStyle(
    textColor: Colors.white,
    fontSize: 16,
    hasBorder: true,
  ),
  videoChild: Chewie(controller: _chewieController),
)
            : const CircularProgressIndicator(), // Show loading until video is initialized
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
