import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:google_fonts/google_fonts.dart';
import 'forgotpassword.dart';
import 'signup.dart';
import 'dashboard/dashboard_screen.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  bool _isLoading = false;
  bool _rememberMe = false;
  bool _isPasswordVisible = false;

  @override
  void initState() {
    super.initState();
    _loadRememberedCredentials();
  }

  @override
  void dispose() {
    _emailController.dispose();
    _passwordController.dispose();
    super.dispose();
  }

  Future<void> _loadRememberedCredentials() async {
    try {
      final prefs = await SharedPreferences.getInstance();
      final savedEmail = prefs.getString('email') ?? '';
      final savedPassword = prefs.getString('password') ?? '';
      final rememberMe = prefs.getBool('rememberMe') ?? false;

      if (rememberMe) {
        setState(() {
          _emailController.text = savedEmail;
          _passwordController.text = savedPassword;
          _rememberMe = rememberMe;
        });
      }
    } catch (e) {
      debugPrint("Error loading saved credentials: $e");
    }
  }

  Future<void> _saveCredentials() async {
    try {
      final prefs = await SharedPreferences.getInstance();
      if (_rememberMe) {
        await prefs.setString('email', _emailController.text.trim());
        await prefs.setString('password', _passwordController.text.trim());
        await prefs.setBool('rememberMe', true);
      } else {
        await prefs.remove('email');
        await prefs.remove('password');
        await prefs.setBool('rememberMe', false);
      }
    } catch (e) {
      debugPrint("Error saving credentials: $e");
    }
  }

  Future<void> _login() async {
    setState(() => _isLoading = true);
    try {
      await FirebaseAuth.instance.signInWithEmailAndPassword(
        email: _emailController.text.trim(),
        password: _passwordController.text.trim(),
      );

      await _saveCredentials();

      if (!mounted) return;
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (context) => const DashboardScreen()),
      );
    } on FirebaseAuthException catch (e) {
      String message = 'Login failed';
      if (e.code == 'user-not-found' || e.code == 'wrong-password') {
        message = 'Invalid email or password';
      }
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text(message)));
    } finally {
      if (mounted) setState(() => _isLoading = false);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFF06041F),
      body: Center(
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(20.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const SizedBox(height: 20),
              Image.network(
              'https://res.cloudinary.com/daj3wmm8g/image/upload/v1742359300/Layer_x5F_1_ynndpp.png',
              width: 100,
              height: 100,
              fit: BoxFit.contain,
              ),
              const SizedBox(height: 20),
              Text(
              'DramaMania',
              style: GoogleFonts.publicSans(fontSize: 32, color: Colors.white),
              ),
              const SizedBox(height: 30),

              // Email Input
              TextField(
              controller: _emailController,
              decoration: InputDecoration(
                labelText: 'Email Address',
                labelStyle: const TextStyle(color: Colors.white),
                prefixIcon: const Icon(Icons.email, color: Color(0xFF6152FF)),
                enabledBorder: const UnderlineInputBorder(
                borderSide: BorderSide(color: Color(0xFF6152FF)),
                ),
                focusedBorder: const UnderlineInputBorder(
                borderSide: BorderSide(color: Color(0xFF6152FF)),
                ),
              ),
              style: const TextStyle(color: Colors.white),
              ),
              const SizedBox(height: 20),

              // Password Input
              TextField(
              controller: _passwordController,
              obscureText: !_isPasswordVisible,
              style: const TextStyle(color: Colors.white),
              decoration: InputDecoration(
                labelText: 'Password',
                labelStyle: const TextStyle(color: Colors.white),
                prefixIcon: const Icon(Icons.lock, color: Color(0xFF6152FF)),
                suffixIcon: IconButton(
                icon: Icon(
                  _isPasswordVisible ? Icons.visibility : Icons.visibility_off,
                  color: const Color(0xFF6152FF),
                ),
                onPressed: () {
                  setState(() {
                  _isPasswordVisible = !_isPasswordVisible;
                  });
                },
                ),
                enabledBorder: const UnderlineInputBorder(
                borderSide: BorderSide(color: Color(0xFF6152FF)),
                ),
                focusedBorder: const UnderlineInputBorder(
                borderSide: BorderSide(color: Color(0xFF6152FF)),
                ),
              ),
              ),

              const SizedBox(height: 20),

              // Remember Me & Forgot Password Row
              Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Row(
                children: [
                  Checkbox(
                  value: _rememberMe,
                  onChanged: (value) {
                    setState(() {
                    _rememberMe = value ?? false;
                    });
                  },
                  activeColor: const Color(0xFF6152FF),
                  ),
                  const Text(
                  "Remember Me",
                  style: TextStyle(color: Colors.white),
                  ),
                ],
                ),
                TextButton(
                onPressed: () {
                  Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => const ForgotPasswordScreen()),
                  );
                },
                child: const Text(
                  "Forgot Password?",
                  style: TextStyle(color: Color(0xFFFFFFFF)),
                ),
                ),
              ],
              ),

              const SizedBox(height: 20),

              // Wide Log In Button
              SizedBox(
              width: 300,
              height: 50,
              child: ElevatedButton(
                onPressed: _isLoading ? null : _login,
                style: ElevatedButton.styleFrom(
                backgroundColor: const Color(0xFF6152FF),
                foregroundColor: Colors.white,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(30),
                ),
                ),
                child: _isLoading 
                  ? const CircularProgressIndicator(color: Colors.white) 
                  : const Text('Log In', style: TextStyle(fontSize: 18)),
              ),
              ),

              const SizedBox(height: 20),

             // Sign Up Link
              Text(
              "Don't have an account?",
              style: TextStyle(color: Colors.white),
              ),
              TextButton(
              onPressed: () => Navigator.push(context, MaterialPageRoute(builder: (context) => const SignUpScreen())),
              child: const Text(
              "Sign up",
              style: TextStyle(color: Color(0xFF6152FF)),
              ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
