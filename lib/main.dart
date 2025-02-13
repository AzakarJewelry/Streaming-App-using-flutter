// ignore_for_file: use_build_context_synchronously
import 'package:firebase_core/firebase_core.dart';
import 'firebase_options.dart';
import 'package:flutter/material.dart';
import 'login.dart';
import 'signup.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  runApp(const MyApp());
}

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  // Static accessor to retrieve the state of MyApp from anywhere in the widget tree.
  static _MyAppState? of(BuildContext context) {
    return context.findAncestorStateOfType<_MyAppState>();
  }

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
      title: 'STREAMSCAPE',
      // Light theme configuration
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: const Color(0xFFF5EFE6)),
        useMaterial3: true,
        // Using default scaffold background for light mode.
      ),
      // Dark theme configuration
      darkTheme: ThemeData(
        brightness: Brightness.dark,
        scaffoldBackgroundColor: Colors.black,
        appBarTheme: AppBarTheme(
          backgroundColor: Colors.grey[900],
        ),
        // Additional dark theme customization if needed.
      ),
      // Switch between themes based on isDarkMode.
      themeMode: isDarkMode ? ThemeMode.dark : ThemeMode.light,
      home: SplashScreen(
        splashName: 'STREAMSCAPE',
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
    // Use the theme's scaffoldBackgroundColor instead of a hardcoded color.
    return Scaffold(
      backgroundColor: Theme.of(context).scaffoldBackgroundColor,
      body: Center(
        child: ScaleTransition(
          scale: _scale,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Image.network(
                'https://media-hosting.imagekit.io//b79407aaf50f4ad5/Screenshot_2025-02-04_142335-removebg-preview.png?Expires=1833258285&Key-Pair-Id=K2ZIVPTIP2VGHC&Signature=Cl~OJbyKFtcVu27ETGwEKLb0DxYaGYBXRxy9k9D7CLM61zLPD4Qy5ZfXMEWOk7Ktxc~ogKau3hllEYDzGJm7ca7B5mLJGggLB772vNSOCMj3ug2me5SzT3TaSzG3VxF9ehzxz3tFRkYQ6br5Guoy-2gfbjHB~3SXSL1YLtvZlFsyj0skPS841jdCt2l014z7hHEBTq0IStHyT-f~H3Sdqz5nUBPz6WWVdXm3dyqpAxZhhwME57QShkVxadcqm-cQf7EwsNAx88gsU5h5sGFBk0WfLDaePQGzD3mj8z-sWYfLs19fH95covT0MKmyOsPDtN5ElCGt3w9Mj0M1XcFBZw__',
                width: 150,
                height: 150,
                fit: BoxFit.contain,
                loadingBuilder: (context, child, loadingProgress) {
                  if (loadingProgress == null) return child;
                  return const CircularProgressIndicator();
                },
                errorBuilder: (context, error, stackTrace) {
                  return const Icon(Icons.image_not_supported,
                      size: 100, color: Colors.grey);
                },
              ),
              const SizedBox(height: 16),
              Text(
                widget.splashName,
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
      ),
    );
  }
}

class MyHomePage extends StatelessWidget {
  const MyHomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // Removed explicit backgroundColor to let the global theme apply.
      body:Container(
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            colors: [Color(0xFFF5EFE6), Color(0xFFB9F2FF)], // Gradient colors
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
          ),
        ),
      
      child:  Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: <Widget>[
            Padding(
              padding: const EdgeInsets.only(top: 150.0),
              child: Column(
                children: [
                  Image.network(
                    'https://media-hosting.imagekit.io//b79407aaf50f4ad5/Screenshot_2025-02-04_142335-removebg-preview.png?Expires=1833258285&Key-Pair-Id=K2ZIVPTIP2VGHC&Signature=Cl~OJbyKFtcVu27ETGwEKLb0DxYaGYBXRxy9k9D7CLM61zLPD4Qy5ZfXMEWOk7Ktxc~ogKau3hllEYDzGJm7ca7B5mLJGggLB772vNSOCMj3ug2me5SzT3TaSzG3VxF9ehzxz3tFRkYQ6br5Guoy-2gfbjHB~3SXSL1YLtvZlFsyj0skPS841jdCt2l014z7hHEBTq0IStHyT-f~H3Sdqz5nUBPz6WWVdXm3dyqpAxZhhwME57QShkVxadcqm-cQf7EwsNAx88gsU5h5sGFBk0WfLDaePQGzD3mj8z-sWYfLs19fH95covT0MKmyOsPDtN5ElCGt3w9Mj0M1XcFBZw__',
                    width: 150,
                    height: 150,
                    fit: BoxFit.contain,
                    loadingBuilder: (context, child, loadingProgress) {
                      if (loadingProgress == null) return child;
                      return const CircularProgressIndicator();
                    },
                    errorBuilder: (context, error, stackTrace) {
                      return const Icon(Icons.image_not_supported,
                          size: 100, color: Colors.grey);
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
    )
    );
  }
}