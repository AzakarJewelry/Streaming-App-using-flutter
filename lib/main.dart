import 'package:firebase_core/firebase_core.dart';
import 'firebase_options.dart';
import 'package:flutter/material.dart';
import 'login.dart';
import 'package:google_fonts/google_fonts.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  runApp(const MyApp());
}

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  static _MyAppState? of(BuildContext context) =>
      context.findAncestorStateOfType<_MyAppState>();

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  bool isDarkMode = false;

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
      theme: ThemeData(
        useMaterial3: true,
        scaffoldBackgroundColor: Colors.white,
        colorScheme: ColorScheme.fromSeed(seedColor: const Color(0xFF9610ff)),
      ),
      darkTheme: ThemeData(
        brightness: Brightness.dark,
        useMaterial3: true,
        scaffoldBackgroundColor: Colors.black,
        appBarTheme: AppBarTheme(
          backgroundColor: Colors.grey[900],
        ),
      ),
      themeMode: isDarkMode ? ThemeMode.dark : ThemeMode.light,
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
    return Scaffold(
      backgroundColor: Theme.of(context).scaffoldBackgroundColor,
      body: Container(
        decoration: const BoxDecoration(
          gradient: LinearGradient(
        colors: [
                    Color(0xFF1F1B24),
                    Color(0xFF1F1B24),
                    Color(0xFF1F1B24),
                    Color(0xFF1F1B24),
                    Color(0xFF1F1B24),
                    Color(0xFF1F1B24),
        ],
        begin: Alignment.topLeft,
        end: Alignment.bottomRight,
          ),
        ),
      child: Center(
        child: ScaleTransition(
          scale: _scale,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Image.network(
                'https://res.cloudinary.com/daj3wmm8g/image/upload/v1743736420/nyyycvigtashwyvqjbtj.png',
                width: 150,
                height: 150,
                fit: BoxFit.contain,
                errorBuilder: (context, error, stackTrace) {
                  return const Icon(
                    Icons.image_not_supported,
                    size: 100,
                    color: Color(0xFF6237A0),
                  );
                },
              ),
              const SizedBox(height: 16),
              Text(
                widget.splashName,
                style: GoogleFonts.publicSans(
                  fontSize: 45,
                  color: const Color(0xFF6237A0),
                ),
              ),
              const SizedBox(height: 16),
              const CircularProgressIndicator(
                valueColor: AlwaysStoppedAnimation<Color>(Color(0xFF6237A0)),
              ),
            ],
          ),
        ),
      ),
      )
    );
  }
}

class MyHomePage extends StatelessWidget {
  const MyHomePage({super.key});

  @override
  Widget build(BuildContext context) {
    final bool isLandscape =
        MediaQuery.of(context).orientation == Orientation.landscape;

    return Scaffold(
      body: Container(
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            colors:[
                    Color(0xFF1F1B24),
                    Color(0xFF1F1B24),
                    Color(0xFF1F1B24),
                    Color(0xFF1F1B24),
                    Color(0xFF1F1B24),
                    Color(0xFF1F1B24),
                    Color(0xFF1F1B24),
            ],
            
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
          ),
        ),
        child: Center(
          child: isLandscape ? _buildLandscapeLayout(context) : _buildPortraitLayout(context),
        ),
      ),
    );
  }

  Widget _buildPortraitLayout(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        const SizedBox(height: 150),
        _logoAndText(),
        const SizedBox(height: 30),
        _buttons(context),
        const SizedBox(height: 80),
      ],
    );
  }

  Widget _buildLandscapeLayout(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Expanded(child: _logoAndText()), // Logo & text on the left
        const SizedBox(width: 40),
        Expanded(child: _buttons(context)), // Buttons on the right
      ],
    );
  }

  Widget _logoAndText() {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Image.network(
          'https://res.cloudinary.com/daj3wmm8g/image/upload/v1743736420/nyyycvigtashwyvqjbtj.png',
          width: 150,
          height: 150,
          fit: BoxFit.contain,
        ),
        const SizedBox(height: 16),
        Text(
          'DramaMania',
          style: GoogleFonts.publicSans(
            fontSize: 45,
            color: const Color(0xFF6237A0),
          ),
        ),
        const SizedBox(height: 8),
        const Text(
          'A Streaming platform for Movies and Dramas',
          style: TextStyle(
            fontSize: 14,
            color: Color(0xFF6237A0),
          ),
        ),
      ],
    );
  }

  Widget _buttons(BuildContext context) {
  return Column(
    mainAxisSize: MainAxisSize.min,
    children: [
      _buildButton(context, 'Get Started', const LoginScreen()), // Navigates to LoginScreen
    ],
  );
}


  Widget _buildButton(BuildContext context, String text, Widget screen) {
    return SizedBox(
      width: 300,
      height: 50,
      child: ElevatedButton(
        onPressed: () {
          Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => screen),
          );
        },
        style: ElevatedButton.styleFrom(
          backgroundColor: const Color(0xFF6237A0),
          foregroundColor: const Color(0xFFF5EFE6),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(30),
          ),
        ),
        child: Text(text, style: const TextStyle(fontSize: 18)),
      ),
    );
  }
}