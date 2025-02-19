import 'package:firebase_core/firebase_core.dart';
import 'firebase_options.dart';
import 'package:flutter/material.dart';
import 'login.dart';
import 'signup.dart';
import 'package:google_fonts/google_fonts.dart'; // Added import

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  runApp(const MyApp());
}

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  // Static accessor if needed for toggling dark mode from anywhere.
  static _MyAppState? of(BuildContext context) =>
      context.findAncestorStateOfType<_MyAppState>();

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  bool isDarkMode = false;

  // Global toggle for dark mode.
  void toggleDarkMode(bool value) {
    setState(() {
      isDarkMode = value;
    });
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'DramaMania',
      // Light theme configuration
      theme: ThemeData(
        useMaterial3: true,
        scaffoldBackgroundColor: Colors.white,
        colorScheme: ColorScheme.fromSeed(seedColor: const Color(0xFFF5EFE6)),
      ),
      // Dark theme configuration
      darkTheme: ThemeData(
        brightness: Brightness.dark,
        useMaterial3: true,
        scaffoldBackgroundColor: Colors.black,
        appBarTheme: AppBarTheme(
          backgroundColor: Colors.grey[900],
        ),
      ),
      // Switch between themes based on isDarkMode.
      themeMode: isDarkMode ? ThemeMode.dark : ThemeMode.light,
      // Shared MaterialApp for all screens.
      home: SplashScreen(
        splashName: 'DramaMania',
        splashDuration: 3,
      ),
    );
  }
}

class SplashScreen extends StatefulWidget {
  final String splashName;
  final int splashDuration;

  const SplashScreen({
    super.key,
    required this.splashName,
    required this.splashDuration,
  });

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<double> _scale;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 1000),
    );
    _scale = CurvedAnimation(parent: _controller, curve: Curves.easeInOut);
    _controller.forward();

    Future.delayed(Duration(seconds: widget.splashDuration), () {
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (context) => const MyHomePage()),
      );
    });
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    // Uses the theme's scaffoldBackgroundColor.
    return Scaffold(
      backgroundColor: Theme.of(context).scaffoldBackgroundColor,
      body: Center(
        child: ScaleTransition(
          scale: _scale,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Image.network(
                'https://res.cloudinary.com/dkhe2vgto/image/upload/v1739954118/dramamania_wulnyr.png',
                width: 150,
                height: 150,
                fit: BoxFit.contain,
                loadingBuilder: (context, child, loadingProgress) {
                  if (loadingProgress == null) return child;
                  return const CircularProgressIndicator();
                },
                errorBuilder: (context, error, stackTrace) {
                  return const Icon(
                    Icons.image_not_supported,
                    size: 100,
                    color: Colors.grey,
                  );
                },
              ),
              const SizedBox(height: 16),
              Text(
                widget.splashName,
                style: GoogleFonts.publicSans(
                  fontSize: 45,
                  color: const Color(0xFF4d0066),
                ),
              ),
              const SizedBox(height: 16),
              const CircularProgressIndicator(
                valueColor: AlwaysStoppedAnimation<Color>(Color(0xFF4d0066)),
              ),
            ],
          ),
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
      // No explicit backgroundColor here; uses the global theme.
      body: Container(
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            colors: [Color(0xFFF5EFE6), Color(0xFFB9F2FF)],
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
          ),
        ),
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: <Widget>[
              Padding(
                padding: const EdgeInsets.only(top: 150.0),
                child: Column(
                  children: [
                    Image.network(
                      'https://res.cloudinary.com/dkhe2vgto/image/upload/v1739954118/dramamania_wulnyr.png',
                      width: 150,
                      height: 150,
                      fit: BoxFit.contain,
                      loadingBuilder: (context, child, loadingProgress) {
                        if (loadingProgress == null) return child;
                        return const CircularProgressIndicator();
                      },
                      errorBuilder: (context, error, stackTrace) {
                        return const Icon(
                          Icons.image_not_supported,
                          size: 100,
                          color: Colors.grey,
                        );
                      },
                    ),
                    const SizedBox(height: 16),
                    Text(
                      'DramaMania',
                      style: GoogleFonts.publicSans(
                        fontSize: 45,
                
                        color: const Color(0xFF4d0066),
                      ),
                    ),
                    const SizedBox(height: 8),
                    const Text(
                      'streaming platform and downloads',
                      style: TextStyle(
                        fontSize: 14,
                        color: Color(0xFF4d0066),
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
                            MaterialPageRoute(
                                builder: (context) => const LoginScreen()),
                          );
                        },
                        style: ElevatedButton.styleFrom(
                          backgroundColor: const Color(0xFF4d0066),
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
                            MaterialPageRoute(
                                builder: (context) => const SignUpScreen()),
                          );
                        },
                        style: ElevatedButton.styleFrom(
                          backgroundColor: const Color(0xFF4d0066),
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
      ),
    );
  }
}
