import 'package:flutter/material.dart';

class SignUpScreen extends StatelessWidget {
  const SignUpScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Sign Up'),
        foregroundColor: const Color(0xFFF5EFE6), // Cream text
        backgroundColor: const Color(0xFF1A4D2E), // Green app bar
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: Color(0xFFF5EFE6)), // Cream back arrow
          onPressed: () => Navigator.pop(context),
        ),
      ),
      backgroundColor: const Color(0xFFF5EFE6), // Cream background
      body: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Text(
              'STREAMSCAPE',
              style: TextStyle(
                fontSize: 32,
                fontWeight: FontWeight.bold,
                color: Color(0xFF1A4D2E), // Green text
              ),
            ),
            const SizedBox(height: 20),
            const Text(
              'Create an account', // Minor wording change for consistency
              style: TextStyle(fontSize: 16, color: Color(0xFF1A4D2E)), // Green text
            ),
            const SizedBox(height: 40),
            TextField(
              decoration: InputDecoration(
                labelText: 'Email or Username',
                border: OutlineInputBorder(
                  borderSide: BorderSide(color: const Color(0xFF1A4D2E)), // Green border
                ),
                labelStyle: const TextStyle(color: Color(0xFF1A4D2E)), // Green label
                focusedBorder: OutlineInputBorder( // Green focused border
                  borderSide: BorderSide(color: const Color(0xFF1A4D2E)),
                ),
              ),
              style: const TextStyle(color: Color(0xFF1A4D2E)), // Green text
            ),
            const SizedBox(height: 20),
            TextField(
              decoration: InputDecoration(
                labelText: 'Name',
                border: OutlineInputBorder(
                  borderSide: BorderSide(color: const Color(0xFF1A4D2E)), // Green border
                ),
                labelStyle: const TextStyle(color: Color(0xFF1A4D2E)), // Green label
                focusedBorder: OutlineInputBorder( // Green focused border
                  borderSide: BorderSide(color: const Color(0xFF1A4D2E)),
                ),
              ),
              style: const TextStyle(color: Color(0xFF1A4D2E)), // Green text
            ),
            const SizedBox(height: 20),
            TextField(
              decoration: InputDecoration(
                labelText: 'Password',
                border: OutlineInputBorder(
                  borderSide: BorderSide(color: const Color(0xFF1A4D2E)), // Green border
                ),
                labelStyle: const TextStyle(color: Color(0xFF1A4D2E)), // Green label
                focusedBorder: OutlineInputBorder( // Green focused border
                  borderSide: BorderSide(color: const Color(0xFF1A4D2E)),
                ),
              ),
              obscureText: true,
              style: const TextStyle(color: Color(0xFF1A4D2E)), // Green text
            ),
            const SizedBox(height: 20),
            TextField(
              decoration: InputDecoration(
                labelText: 'Confirm Password',
                border: OutlineInputBorder(
                  borderSide: BorderSide(color: const Color(0xFF1A4D2E)), // Green border
                ),
                labelStyle: const TextStyle(color: Color(0xFF1A4D2E)), // Green label
                focusedBorder: OutlineInputBorder( // Green focused border
                  borderSide: BorderSide(color: const Color(0xFF1A4D2E)),
                ),
              ),
              obscureText: true,
              style: const TextStyle(color: Color(0xFF1A4D2E)), // Green text
            ),
            const SizedBox(height: 30),
            ElevatedButton(
              onPressed: () {
                // Implement sign-up logic here
              },
              style: ElevatedButton.styleFrom(
                backgroundColor: const Color(0xFF1A4D2E), // Green button
                foregroundColor: const Color(0xFFF5EFE6), // Cream text
                minimumSize: const Size(double.infinity, 50),
              ),
              child: const Text('Sign Up'),
            ),
          ],
        ),
      ),
    );
  }
}