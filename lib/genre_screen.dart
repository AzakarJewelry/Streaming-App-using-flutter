import 'package:flutter/material.dart';

class GenreScreen extends StatelessWidget {
  final String genre;

  const GenreScreen({super.key, required this.genre});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF5EFE6), // Cream background
      appBar: AppBar(
        title: Text(
          genre,
          style: const TextStyle(
            color: Color(0xFF1A4D2E), // Dark green text
          ),
        ),
        backgroundColor: const Color(0xFFF5EFE6), // Cream background
        elevation: 0, // Remove shadow
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: Color(0xFF1A4D2E)), // Dark green icon
          onPressed: () => Navigator.pop(context),
        ),
      ),
      body: Center(
   
          
      ),
    );
  }
}