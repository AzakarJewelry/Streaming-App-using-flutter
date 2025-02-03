import 'package:flutter/material.dart';
import 'package:video_player/video_player.dart';
import 'package:chewie/chewie.dart';
import 'favorite_manager.dart'; // Import the favorite manager


class MovieDetailsScreen extends StatefulWidget {
  final String title;
  final String genre;
  final String duration;
  final String rating;
  final String description;
  final String imageUrl;

  const MovieDetailsScreen({
    super.key,
    required this.title,
    required this.genre,
    required this.duration,
    required this.rating,
    required this.description,
    required this.imageUrl,
  });

  @override
  State<MovieDetailsScreen> createState() => _MovieDetailsScreenState();
}

class _MovieDetailsScreenState extends State<MovieDetailsScreen> {
  late VideoPlayerController _videoPlayerController;
  late ChewieController _chewieController;
  bool _isFullscreen = false;

  @override
  void initState() {
    super.initState();
    _initializeVideoPlayer();
  }

  void _initializeVideoPlayer() {
    _videoPlayerController = VideoPlayerController.network(
      'https://www.youtube.com/watch?v=Z1BCujX3pw8&t=3s', // Replace with your video URL
    );

    _chewieController = ChewieController(
      videoPlayerController: _videoPlayerController,
      autoPlay: false,
      looping: false,
      allowFullScreen: true,
      fullScreenByDefault: false,
      materialProgressColors: ChewieProgressColors(
        playedColor: Colors.red,
        handleColor: Colors.red,
        backgroundColor: Colors.grey,
        bufferedColor: Colors.grey[300]!,
      ),
      placeholder: Container(
        color: Colors.black,
      ),
      autoInitialize: true,
    );
  }

  @override
  void dispose() {
    _videoPlayerController.dispose();
    _chewieController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    bool isFavorite = favoriteManager.isFavorite(widget.title);

    return Scaffold(
      backgroundColor: const Color(0xFFF5EFE6),
      appBar: AppBar(
        backgroundColor: const Color(0xFF1A4D2E),
        foregroundColor: const Color(0xFFF5EFE6),
        title: Text(widget.title),
      ),
      body: SingleChildScrollView(
        child: Center(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Container(
                width: double.infinity,
                height: 300,
                child: Chewie(
                  controller: _chewieController,
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(16.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          widget.title,
                          style: const TextStyle(
                            color: Color(0xFF1A4D2E),
                            fontSize: 24,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        IconButton(
                          icon: Icon(
                            isFavorite ? Icons.favorite : Icons.favorite_border,
                            color: isFavorite ? Colors.red : Colors.grey,
                            size: 30,
                          ),
                          onPressed: () {
                            setState(() {
                              favoriteManager.toggleFavorite({
                                'title': widget.title,
                                'genre': widget.genre,
                                'duration': widget.duration,
                                'rating': widget.rating,
                                'description': widget.description,
                                'imageUrl': widget.imageUrl,
                              });
                            });
                          },
                        ),
                      ],
                    ),
                    const SizedBox(height: 8),
                    Text(
                      widget.genre,
                      style: TextStyle(
                        color: const Color(0xFF1A4D2E).withOpacity(0.8),
                        fontSize: 16,
                      ),
                      textAlign: TextAlign.center,
                    ),
                    const SizedBox(height: 8),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Text(
                          widget.duration,
                          style: TextStyle(
                            color: const Color(0xFF1A4D2E).withOpacity(0.8),
                            fontSize: 16,
                          ),
                        ),
                        const SizedBox(height: 4),
                        Text(
                          widget.rating,
                          style: const TextStyle(
                            color: Color(0xFFF3C63F),
                            fontSize: 16,
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 16.0),
                child: Text(
                  widget.description,
                  style: const TextStyle(
                    color: Color(0xFF1A4D2E),
                    fontSize: 16,
                  ),
                  textAlign: TextAlign.center,
                ),
              ),
              const SizedBox(height: 16),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  IconButton(
                    icon: Icon(Icons.skip_previous, color: Colors.white),
                    onPressed: () {
                      // Add logic for previous video
                    },
                  ),
                  IconButton(
                    icon: Icon(
                      _chewieController.isPlaying ? Icons.pause : Icons.play_arrow,
                      color: Colors.white,
                    ),
                    onPressed: () {
                      setState(() {
                        if (_chewieController.isPlaying) {
                          _chewieController.pause();
                        } else {
                          _chewieController.play();
                        }
                      });
                    },
                  ),
                  IconButton(
                    icon: Icon(Icons.skip_next, color: Colors.white),
                    onPressed: () {
                      // Add logic for next video
                    },
                  ),
                  IconButton(
                    icon: Icon(Icons.fullscreen, color: Colors.white),
                    onPressed: () {
                      setState(() {
                        _isFullscreen = !_isFullscreen;
                        _chewieController.enterFullScreen();
                      });
                    },
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}