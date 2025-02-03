import 'package:flutter/material.dart';

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
  const PlayMovie({super.key});

  @override
  State<PlayMovie> createState() => _PlayMovie();
}

class _PlayMovie extends State<PlayMovie> {
  Color mainColor = const Color(0xFF1A4D2E);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: mainColor,
      appBar: AppBar(
        backgroundColor: mainColor,
        elevation: 0.0,
        title: const Text("Video Player"),
      ),
      body: const Center(
        child: Text(
          "This is the PlayMovie screen",
          style: TextStyle(color: Colors.white, fontSize: 18),
        ),
      ),
    );
  }
}
