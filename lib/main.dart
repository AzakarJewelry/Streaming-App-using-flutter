import 'package:flutter/material.dart';
import 'login.dart'; // Import the login screen
import 'signup.dart'; // Import the signup screen

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Streamscape',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.white),
        useMaterial3: true,
      ),
      home: const SplashScreen(
        splashName: 'Streamscape', // Adjust splash name here
        splashDuration: 3, // Adjust splash duration here (in seconds)
      ),
    );
  }
}

class SplashScreen extends StatelessWidget {
  final String splashName;
  final int splashDuration;

  const SplashScreen({
    super.key,
    required this.splashName,
    required this.splashDuration,
  });

  @override
  Widget build(BuildContext context) {
    // Navigate to the main home screen after the splash duration
    Future.delayed(Duration(seconds: splashDuration), () {
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (context) => const MyHomePage()),
      );
    });

    return Scaffold(
      backgroundColor: const Color(0xFF171A1F), // Dark background color
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              splashName,
              style: const TextStyle(
                fontSize: 45,
                fontWeight: FontWeight.bold,
                color: Color(0xFFFFD700), // Gold color
              ),
            ),
            const SizedBox(height: 16),
            const CircularProgressIndicator(
              valueColor: AlwaysStoppedAnimation<Color>(Color(0xFFFFD700)), // Gold color
            ),
          ],
        ),
      ),
    );
  }
}

class MyHomePage extends StatelessWidget {
  const MyHomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFF171A1F), // Dark background color
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            const Text(
              'STREAMSCAPE',
              style: TextStyle(
                fontSize: 45,
                fontWeight: FontWeight.bold,
                color: Color(0xFFFFD700), // Gold color
              ),
            ),
            const SizedBox(height: 8),
            const Text(
              'streaming platform and downloads',
              style: TextStyle(
                fontSize: 14,
                color: Color(0xFFFFD700), // Gold color
              ),
            ),
            const SizedBox(height: 80), // Spacing before buttons
            SizedBox(
              width: 250,
              height: 50,
              child: ElevatedButton(
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => const LoginScreen()),
                  );
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: const Color(0xFFFFD700), // Gold button color
                  foregroundColor: Colors.black, // Black text color
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(30), // Rounded button
                  ),
                ),
                child: const Text('Login', style: TextStyle(fontSize: 18)),
              ),
            ),
            const SizedBox(height: 16), // Spacing between buttons
            SizedBox(
              width: 250,
              height: 50,
              child: ElevatedButton(
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => const SignUpScreen()),
                  );
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: const Color(0xFFFFD700), // Gold button color
                  foregroundColor: Colors.black, // Black text color
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(30), // Rounded button
                  ),
                ),
                child: const Text('Sign Up', style: TextStyle(fontSize: 18)),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
