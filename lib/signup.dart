import 'package:flutter/material.dart';

class SignUpScreen extends StatelessWidget {
  const SignUpScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Sign Up'),
        foregroundColor: const Color(0xFFF5EFE6),
        backgroundColor: const Color(0xFF1A4D2E),
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: Color(0xFFF5EFE6)),
          onPressed: () => Navigator.pop(context),
        ),
      ),
      backgroundColor: const Color(0xFFF5EFE6),
      body: Center( // Center the entire content
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(20.0),
          child: Center( // Center the form within the scroll view
            child: ConstrainedBox( // Add ConstrainedBox for max width
              constraints: const BoxConstraints(maxWidth: 400), // Adjust max width as needed
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  const Text(
                    'STREAMSCAPE',
                    style: TextStyle(
                      fontSize: 32,
                      fontWeight: FontWeight.bold,
                      color: Color(0xFF1A4D2E),
                    ),
                  ),
                  const SizedBox(height: 20),
                  const Text(
                    'Create an account',
                    style: TextStyle(fontSize: 16, color: Color(0xFF1A4D2E)),
                  ),
                  const SizedBox(height: 40),
                  TextField(
                    decoration: InputDecoration(
                      labelText: 'Email or Username',
                      border: OutlineInputBorder(
                        borderSide: BorderSide(color: const Color(0xFF1A4D2E)),
                      ),
                      labelStyle: const TextStyle(color: Color(0xFF1A4D2E)),
                      focusedBorder: OutlineInputBorder(
                        borderSide: BorderSide(color: const Color(0xFF1A4D2E)),
                      ),
                    ),
                    style: const TextStyle(color: Color(0xFF1A4D2E)),
                  ),
                  const SizedBox(height: 20),
                  TextField(
                    decoration: InputDecoration(
                      labelText: 'Name',
                      border: OutlineInputBorder(
                        borderSide: BorderSide(color: const Color(0xFF1A4D2E)),
                      ),
                      labelStyle: const TextStyle(color: Color(0xFF1A4D2E)),
                      focusedBorder: OutlineInputBorder(
                        borderSide: BorderSide(color: const Color(0xFF1A4D2E)),
                      ),
                    ),
                    style: const TextStyle(color: Color(0xFF1A4D2E)),
                  ),
                  const SizedBox(height: 20),
                  TextField(
                    decoration: InputDecoration(
                      labelText: 'Password',
                      border: OutlineInputBorder(
                        borderSide: BorderSide(color: const Color(0xFF1A4D2E)),
                      ),
                      labelStyle: const TextStyle(color: Color(0xFF1A4D2E)),
                      focusedBorder: OutlineInputBorder(
                        borderSide: BorderSide(color: const Color(0xFF1A4D2E)),
                      ),
                    ),
                    obscureText: true,
                    style: const TextStyle(color: Color(0xFF1A4D2E)),
                  ),
                  const SizedBox(height: 20),
                  TextField(
                    decoration: InputDecoration(
                      labelText: 'Confirm Password',
                      border: OutlineInputBorder(
                        borderSide: BorderSide(color: const Color(0xFF1A4D2E)),
                      ),
                      labelStyle: const TextStyle(color: Color(0xFF1A4D2E)),
                      focusedBorder: OutlineInputBorder(
                        borderSide: BorderSide(color: const Color(0xFF1A4D2E)),
                      ),
                    ),
                    obscureText: true,
                    style: const TextStyle(color: Color(0xFF1A4D2E)),
                  ),
                  const SizedBox(height: 30),
                  ElevatedButton(
                    onPressed: () {
                      // Implement sign-up logic here
                    },
                    style: ElevatedButton.styleFrom(
                      backgroundColor: const Color(0xFF1A4D2E),
                      foregroundColor: const Color(0xFFF5EFE6),
                      minimumSize: const Size(double.infinity, 50),
                    ),
                    child: const Text('Sign Up'),
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