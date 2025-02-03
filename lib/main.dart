// ignore_for_file: use_build_context_synchronously

import 'package:flutter/material.dart';
import 'login.dart'; // Import your existing login screen
import 'signup.dart'; // Import your existing signup screen
<<<<<<< HEAD
// Import the Forgot Password screen
=======
>>>>>>> 6637a90c7d9bbaabc12d0e02861f9391c486c9b7

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'STREAMSCAPE',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: const Color(0xFFF5EFE6)),
        useMaterial3: true,
        scaffoldBackgroundColor: const Color(0xFFF5EFE6),
      ),
      home: const SplashScreen(
        splashName: 'STREAMSCAPE',
        splashDuration: 3,
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
    Future.delayed(Duration(seconds: splashDuration), () {
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (context) => const MyHomePage()),
      );
    });

    return Scaffold(
      backgroundColor: const Color(0xFFF5EFE6),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Image.network(
              'https://media-hosting.imagekit.io//538d55e725f4462b/Screenshot%202025-02-03%20105055.png?Expires=1833175824&Key-Pair-Id=K2ZIVPTIP2VGHC&Signature=X6neTindNEADa~ccjLiOQqKYdN5SwTWVgnHk1kt0AxaULUKSZXeq4WabXzgRf85HIDP4ILr8v9YSsQBw9O3zVXWGbLsnN5NBRN7rmTUcVViRMX498nzzOQUcUk6wZOLydaR62aIkKqlsqR23qixV-5M3DElhn~3ehUYuxc0-T3F-dfKunKlAmCwvgV34hPMCcH4tqLpP-Bmr-XoCVzTm1xeM9G2cIa6DsRS09qVZzzAdEirDmXD1P0wuanqSCylqm3CCrR9wxSPgSAwcKGZpBuoYg5SnJ0biv72VuHkRgiH2dL7S-gBC5aXrqQXMjfmt5PszxlotrWeT6KHpHD0jmA__', // Replace with your logo URL
              width: 200,
              height: 200,
              fit: BoxFit.contain,
              loadingBuilder: (context, child, loadingProgress) {
                if (loadingProgress == null) return child;
                return const CircularProgressIndicator();
              },
              errorBuilder: (context, error, stackTrace) {
                return const Icon(Icons.image_not_supported, size: 100, color: Colors.grey);
              },
            ),
            const SizedBox(height: 16),
            Text(
              splashName,
              style: const TextStyle(
                fontSize: 45,
                fontWeight: FontWeight.bold,
                color: Color(0xFF1A4D2E),
              ),
            ),
            const SizedBox(height: 16),
            const CircularProgressIndicator(
              valueColor: AlwaysStoppedAnimation<Color>(Color(0xFF1A4D2E)),
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
      backgroundColor: const Color(0xFFF5EFE6),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: <Widget>[
            Padding(
              padding: const EdgeInsets.only(top: 150.0),
              child: Column(
                children: [
                  Image.network(
                    'https://media-hosting.imagekit.io//538d55e725f4462b/Screenshot%202025-02-03%20105055.png?Expires=1833175824&Key-Pair-Id=K2ZIVPTIP2VGHC&Signature=X6neTindNEADa~ccjLiOQqKYdN5SwTWVgnHk1kt0AxaULUKSZXeq4WabXzgRf85HIDP4ILr8v9YSsQBw9O3zVXWGbLsnN5NBRN7rmTUcVViRMX498nzzOQUcUk6wZOLydaR62aIkKqlsqR23qixV-5M3DElhn~3ehUYuxc0-T3F-dfKunKlAmCwvgV34hPMCcH4tqLpP-Bmr-XoCVzTm1xeM9G2cIa6DsRS09qVZzzAdEirDmXD1P0wuanqSCylqm3CCrR9wxSPgSAwcKGZpBuoYg5SnJ0biv72VuHkRgiH2dL7S-gBC5aXrqQXMjfmt5PszxlotrWeT6KHpHD0jmA__', // Replace with your logo URL
                    width: 150,
                    height: 150,
                    fit: BoxFit.contain,
                    loadingBuilder: (context, child, loadingProgress) {
                      if (loadingProgress == null) return child;
                      return const CircularProgressIndicator();
                    },
                    errorBuilder: (context, error, stackTrace) {
                      return const Icon(Icons.image_not_supported, size: 100, color: Colors.grey);
                    },
                  ),
                  const SizedBox(height: 16),
                  const Text(
                    'STREAMSCAPE',
                    style: TextStyle(
                      fontSize: 45,
                      fontWeight: FontWeight.bold,
                      color: Color(0xFF1A4D2E),
                    ),
                  ),
                  const SizedBox(height: 8),
                  const Text(
                    'streaming platform and downloads',
                    style: TextStyle(
                      fontSize: 14,
                      color: Color(0xFF1A4D2E),
                    ),
                  ),
                ],
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(bottom: 80.0),
              child: Column(
                children: [
                  SizedBox(
                    width: 300,
                    height: 50,
                    child: ElevatedButton(
                      onPressed: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(builder: (context) => const LoginScreen()),
                        );
                      },
                      style: ElevatedButton.styleFrom(
                        backgroundColor: const Color(0xFF1A4D2E),
                        foregroundColor: const Color(0xFFF5EFE6),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(30),
                        ),
                      ),
                      child: const Text('Login', style: TextStyle(fontSize: 18)),
                    ),
                  ),
                  const SizedBox(height: 20),
                  SizedBox(
                    width: 300,
                    height: 50,
                    child: ElevatedButton(
                      onPressed: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(builder: (context) => const SignUpScreen()),
                        );
                      },
                      style: ElevatedButton.styleFrom(
                        backgroundColor: const Color(0xFF1A4D2E),
                        foregroundColor: const Color(0xFFF5EFE6),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(30),
                        ),
                      ),
                      child: const Text('Sign Up', style: TextStyle(fontSize: 18)),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
