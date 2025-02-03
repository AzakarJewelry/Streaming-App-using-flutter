import 'package:flutter/material.dart';
import 'package:video_player/video_player.dart';



void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
     home: PlayMovie(),

     
    );
  }
}

class PlayMovie extends StatefulWidget {
  const PlayMovie ({super.key});

  @override
  State<PlayMovie > createState() => _PlayMovie ();
}

class _PlayMovie  extends State<PlayMovie > {
    Color mainColor = const Color(0xFF1A4D2E);
  String dataScource = "https://www.youtube.com/watch?v=Z1BCujX3pw8&t=3s";
  VideoPlayerController? _controller;
  @override
    void initState() {
      super.initState();
      _controller = VideoPlayerController.network(dataScource)
      ..initialize().then((_) {
        setState(() {
          
        });
      });
    }


  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: mainColor,
      appBar: AppBar(backgroundColor: mainColor,
      elevation: 0.0,
      title: Text("Video Player"),
    
      ),
        body: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          _controller!.value.isInitialized
          ?AspectRatio(aspectRatio: _controller!.value.aspectRatio, child: VideoPlayer(_controller!),)
          :Container(),
          VideoProgressIndicator(_controller!, allowScrubbing: true,padding: EdgeInsets.all(0.0),),

        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            IconButton (
              onPressed: () {} ,
              icon: Icon(Icons.skip_previous),
              color: Colors.white,),
            IconButton (
              onPressed: () {
                _controller!.value.isPlaying
                 ? _controller!.pause() 
                 : _controller!.play();
              } ,
              icon: Icon(Icons.play_arrow),
              color: Colors.white,),
            IconButton (
              onPressed: () {} ,
              icon: Icon(Icons.skip_next),
              color: Colors.white,),
        ],
        ),
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: Text(
            "Captain Marvel",
            style: TextStyle(
              color: Colors.white,
              fontSize: 28.0,
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
         Padding(
          padding: const EdgeInsets.all(8.0),
          child: Text(
            "this is captain marvel movie",
            style: TextStyle(
              color: Colors.white,
              fontSize: 18.0,
              fontWeight: FontWeight.normal,
            ),
          ),
        ),
        ],
        ),
    );
  }
}