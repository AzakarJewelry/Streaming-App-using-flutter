// ignore_for_file: use_build_context_synchronously

import 'package:flutter/material.dart';
import 'login.dart'; // Import your existing login screen
import 'signup.dart'; // Import your existing signup screen

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
              'https://media-hosting.imagekit.io//f8ddd5819f034d30/Screenshot_2025-02-03_105055-removebg-preview.png?Expires=1833179598&Key-Pair-Id=K2ZIVPTIP2VGHC&Signature=shHrrJrAMQaG3ZPdTGOTWebdnoaC8HUSeaqq7r9T-NsryIqW1amP-K2VHAoQ-~mgiH0s44QjofFP25TMS0zua1YgPZCMeoO7hEHbfHrQf-Omj6WQGNMi5b1bdoEMj6HOFYp8dtZF7WEBkqNQ1eHau8bVQ6yn5WfTzgSpLd1uJGZipsliuK7lZZKRyId6a8e8CV9i716NBJe6D6WUjYrvRKkDoGcxy6K9eABIcxA3TpUyYsW7aH8wcxTiVGHv8eEUuByVt0gP~wrS83r-udoz07sV~Yr-yPFylLfKN9gQQg1IOFKzN7X7~xjVdQjx~tWuI01xOUZnL10ZYdHmkCEtWw__', // Replace with your logo URL
              width: 100,
              height: 100,
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
                    'https://media-hosting.imagekit.io//f8ddd5819f034d30/Screenshot_2025-02-03_105055-removebg-preview.png?Expires=1833179598&Key-Pair-Id=K2ZIVPTIP2VGHC&Signature=shHrrJrAMQaG3ZPdTGOTWebdnoaC8HUSeaqq7r9T-NsryIqW1amP-K2VHAoQ-~mgiH0s44QjofFP25TMS0zua1YgPZCMeoO7hEHbfHrQf-Omj6WQGNMi5b1bdoEMj6HOFYp8dtZF7WEBkqNQ1eHau8bVQ6yn5WfTzgSpLd1uJGZipsliuK7lZZKRyId6a8e8CV9i716NBJe6D6WUjYrvRKkDoGcxy6K9eABIcxA3TpUyYsW7aH8wcxTiVGHv8eEUuByVt0gP~wrS83r-udoz07sV~Yr-yPFylLfKN9gQQg1IOFKzN7X7~xjVdQjx~tWuI01xOUZnL10ZYdHmkCEtWw__', // Replace with your logo URL
                    width: 100,
                    height: 100,
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
