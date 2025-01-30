import 'package:flutter/material.dart';
import 'dashboard_screen.dart'; // Import the DashboardScreen

class LoginScreen extends StatelessWidget {
  const LoginScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Login'),
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
                labelText: 'Password',
                border: OutlineInputBorder(
                  borderSide: BorderSide(color: const Color(0xFF1A4D2E)), // Green border
                ),
                labelStyle: const TextStyle(color: Color(0xFF1A4D2E)), // Green label
                suffixIcon: IconButton(
                  icon: const Icon(Icons.visibility, color: Color(0xFF1A4D2E)), // Green icon
                  onPressed: () {},
                ),
                focusedBorder: OutlineInputBorder( // Green focused border
                  borderSide: BorderSide(color: const Color(0xFF1A4D2E)),
                ),
              ),
              obscureText: true,
              style: const TextStyle(color: Color(0xFF1A4D2E)), // Green text
            ),
            const SizedBox(height: 10),
            Align(
              alignment: Alignment.centerRight,
              child: TextButton(
                onPressed: () {},
                child: const Text(
                  'Forgot Password?',
                  style: TextStyle(color: Color(0xFF1A4D2E)), // Green text
                ),
              ),
            ),
            const SizedBox(height: 30),
            ElevatedButton(
              onPressed: () {
                // Navigate to the DashboardScreen
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => const DashboardScreen()),
                );
              },
              style: ElevatedButton.styleFrom(
                backgroundColor: const Color(0xFF1A4D2E), // Green button
                foregroundColor: const Color(0xFFF5EFE6), // Cream text
                minimumSize: const Size(double.infinity, 50),
              ),
              child: const Text('Log In'),
            ),
          ],
        ),
      ),
    );
  }
}