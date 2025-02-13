import 'package:flutter/material.dart';
import 'package:video_player/video_player.dart';
import 'package:chewie/chewie.dart';
import 'package:subtitle_wrapper_package/subtitle_wrapper_package.dart';
import 'package:flutter/services.dart';

class PlayMovie extends StatefulWidget {
  final String videoUrl;

  const PlayMovie({Key? key, required this.videoUrl}) : super(key: key);

  @override
  State<PlayMovie> createState() => _PlayMovieState();
}

class _PlayMovieState extends State<PlayMovie> {
  late VideoPlayerController _videoPlayerController;
  ChewieController? _chewieController; // Nullable for delayed creation.
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
        // Create ChewieController only after the video is fully initialized.
        _chewieController = ChewieController(
          videoPlayerController: _videoPlayerController,
          autoPlay: true,
          looping: false,
          allowFullScreen: false,
        );
        setState(() {}); // Refresh the UI.
      });
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
    _chewieController?.dispose();
    super.dispose();
  }

  Widget _buildVideoPlayer() {
    final subtitleWrapper = SubtitleWrapper(
      videoPlayerController: _videoPlayerController,
      subtitleController: _subtitleController ??
          SubtitleController(
              subtitlesContent: "", subtitleType: SubtitleType.srt),
      subtitleStyle: const SubtitleStyle(
        textColor: Colors.white,
        fontSize: 16,
        hasBorder: true,
      ),
      videoChild: _chewieController != null
          ? Chewie(controller: _chewieController!)
          : const Center(child: CircularProgressIndicator()),
    );

    return _isLoadingSubtitles
        ? const Center(child: CircularProgressIndicator())
        : Stack(
            children: [
              AspectRatio(
                aspectRatio: _videoPlayerController.value.isInitialized
                    ? _videoPlayerController.value.aspectRatio
                    : 16 / 9,
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
    final bool isDesktop = MediaQuery.of(context).size.width >= 600;

    if (_isFullscreen) {
      return Scaffold(
        backgroundColor: Colors.black,
        body: SafeArea(
          child: Stack(
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
        ),
      );
    }

    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        foregroundColor: Colors.black,
        backgroundColor: Colors.transparent,
        elevation: 0.0,
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          child: Center(
            child: ConstrainedBox(
              constraints: BoxConstraints(
                maxWidth: isDesktop ? 800 : double.infinity,
              ),
              child: Column(
                children: [
                  Container(
                    width: double.infinity,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(15),
                      boxShadow: [
                        BoxShadow(
                          color: Colors.black.withOpacity(0.2),
                          blurRadius: 5,
                          spreadRadius: 2,
                          offset: const Offset(0, 3),
                        ),
                      ],
                    ),
                    child: ClipRRect(
                      borderRadius: BorderRadius.circular(15),
                      child: AspectRatio(
                        aspectRatio: _videoPlayerController.value.isInitialized
                            ? _videoPlayerController.value.aspectRatio
                            : 16 / 9,
                        child: _buildVideoPlayer(),
                      ),
                    ),
                  ),
                  if (_subtitlesError)
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Text(
                        "Error loading subtitles.",
                        style: TextStyle(
                          color: Colors.red,
                          fontSize: isDesktop ? 18 : 14,
                        ),
                        textAlign: TextAlign.center,
                      ),
                    ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
