import 'package:flutter/material.dart';

class MovieDetailsScreen extends StatelessWidget {
  final String title;
  final String imageUrl;
  final String description;

  const MovieDetailsScreen({
    super.key,
    required this.title,
    required this.imageUrl,
    required this.description,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF5EFE6),

      appBar: AppBar(
        backgroundColor: const Color(0xFF1A4D2E),
        foregroundColor: const Color(0xFFF5EFE6),
        title: Text(title),
      ),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              width: MediaQuery.of(context).size.width,
              height: 400, // Or adjust as needed
              decoration: BoxDecoration(
                image: DecorationImage(
                  image: NetworkImage(imageUrl),
                  fit: BoxFit.contain, // Use BoxFit.contain
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(16.0),
              child: Text(
                description,
                style: const TextStyle(
                  color: Color(0xFF1A4D2E),
                  fontSize: 16,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}