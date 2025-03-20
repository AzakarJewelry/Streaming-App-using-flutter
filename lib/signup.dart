import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'login.dart';
import 'package:google_fonts/google_fonts.dart';

class SignUpScreen extends StatefulWidget {
  const SignUpScreen({super.key});

  @override
  State<SignUpScreen> createState() => _SignUpScreenState();
}

class _SignUpScreenState extends State<SignUpScreen> {
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  final TextEditingController _confirmPasswordController = TextEditingController();
  bool _isLoading = false;

  // Variables to handle password visibility
  bool _passwordVisible = false;
  bool _confirmPasswordVisible = false;

  @override
  void dispose() {
    _emailController.dispose();
    _nameController.dispose();
    _passwordController.dispose();
    _confirmPasswordController.dispose();
    super.dispose();
  }

  Future<void> _signUp() async {
    if (_passwordController.text != _confirmPasswordController.text) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text("Passwords do not match")),
      );
      return;
    }

    setState(() => _isLoading = true);
    try {
      final credential = await FirebaseAuth.instance.createUserWithEmailAndPassword(
        email: _emailController.text.trim(),
        password: _passwordController.text.trim(),
      );

      // Update user display name
      await credential.user!.updateDisplayName(_nameController.text.trim());

      // Save user details to Firestore
      await FirebaseFirestore.instance.collection('users').doc(credential.user!.uid).set({
        'username': _nameController.text.trim(),
        'email': _emailController.text.trim(),
      });

      if (!mounted) return;
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (context) => const LoginScreen()),
      );
    } on FirebaseAuthException catch (e) {
      String message = 'Sign up failed';
      if (e.code == 'weak-password') {
        message = 'Password is too weak';
      } else if (e.code == 'email-already-in-use') {
        message = 'Email already in use';
      } else if (e.code == 'invalid-email') {
        message = 'Invalid email format';
      }
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text(message)));
    } finally {
      if (mounted) setState(() => _isLoading = false);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Sign Up'),
        foregroundColor: const Color(0xFFF5EFE6),
        backgroundColor: const Color(0xFF6152ff),
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: Color(0xFFF5EFE6)),
          onPressed: () => Navigator.pop(context),
        ),
      ),
      backgroundColor: const Color(0xFFF5EFE6),
      body: Container(
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            colors: [
                    const Color(0xFF06041f),
                    const Color(0xFF06041f),
                    const Color(0xFF06041f),
                    const Color(0xFF06041f),
                    const Color(0xFF06041f),
                    const Color(0xFF06041f),
            ],
            
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
          ),
        ),
        child:Center(
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(20.0),
          child: Center(
            child: ConstrainedBox(
              constraints: const BoxConstraints(maxWidth: 400),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  Image.network(
                    'https://res.cloudinary.com/daj3wmm8g/image/upload/v1742359300/Layer_x5F_1_ynndpp.png',
                    height: 100,
                    width: 100,
                  ),
                  const SizedBox(height: 20),
                  Center(
                    child: Text(
                      'DramaMania',
                        style: GoogleFonts.publicSans(
                        fontSize: 32,
                        color: Color(0xFF6152ff),
                      ),
                      textAlign: TextAlign.center,
                    ),
                  ),
                  const SizedBox(height: 20),
                  const Text(
                    'Create an account',
                    style: TextStyle(fontSize: 16, color: Color(0xFF6152ff)),
                  ),
                  const SizedBox(height: 40),
                 TextField(
  controller: _emailController,
  decoration: InputDecoration(
    labelText: 'Email',
    prefixIcon: const Icon(Icons.email, color: Color(0xFF6152ff)),
    labelStyle: const TextStyle(color: Colors.white),
    enabledBorder: const UnderlineInputBorder(
      borderSide: BorderSide(color: Color(0xFF6152ff)),
    ),
    focusedBorder: const UnderlineInputBorder(
      borderSide: BorderSide(color: Color(0xFF6152ff), width: 2),
    ),
  ),
  style: const TextStyle(color: Colors.white),
),
const SizedBox(height: 20),

TextField(
  controller: _nameController,
  decoration: InputDecoration(
    labelText: 'Name',
    prefixIcon: const Icon(Icons.person, color: Color(0xFF6152ff)),
    labelStyle: const TextStyle(color: Colors.white),
    enabledBorder: const UnderlineInputBorder(
      borderSide: BorderSide(color: Color(0xFF6152ff)),
    ),
    focusedBorder: const UnderlineInputBorder(
      borderSide: BorderSide(color: Color(0xFF6152ff), width: 2),
    ),
  ),
  style: const TextStyle(color: Colors.white),
),
const SizedBox(height: 20),

TextField(
  controller: _passwordController,
  obscureText: !_passwordVisible,
  decoration: InputDecoration(
    labelText: 'Password',
    prefixIcon: const Icon(Icons.lock, color: Color(0xFF6152ff)),
    suffixIcon: IconButton(
      icon: Icon(
        _passwordVisible ? Icons.visibility : Icons.visibility_off,
        color: const Color(0xFF6152ff),
      ),
      onPressed: () {
        setState(() {
          _passwordVisible = !_passwordVisible;
        });
      },
    ),
    labelStyle: const TextStyle(color: Colors.white),
    enabledBorder: const UnderlineInputBorder(
      borderSide: BorderSide(color: Color(0xFF6152ff)),
    ),
    focusedBorder: const UnderlineInputBorder(
      borderSide: BorderSide(color: Color(0xFF6152ff), width: 2),
    ),
  ),
  style: const TextStyle(color: Colors.white),
),
const SizedBox(height: 20),

TextField(
  controller: _confirmPasswordController,
  obscureText: !_confirmPasswordVisible,
  decoration: InputDecoration(
    labelText: 'Confirm Password',
    prefixIcon: const Icon(Icons.lock_outline, color: Color(0xFF6152ff)),
    suffixIcon: IconButton(
      icon: Icon(
        _confirmPasswordVisible ? Icons.visibility : Icons.visibility_off,
        color: const Color(0xFF6152ff),
      ),
      onPressed: () {
        setState(() {
          _confirmPasswordVisible = !_confirmPasswordVisible;
        });
      },
    ),
    labelStyle: const TextStyle(color: Colors.white),
    enabledBorder: const UnderlineInputBorder(
      borderSide: BorderSide(color: Color(0xFF6152ff)),
    ),
    focusedBorder: const UnderlineInputBorder(
      borderSide: BorderSide(color: Color(0xFF6152ff), width: 2),
    ),
  ),
  style: const TextStyle(color: Colors.white),
),
                  const SizedBox(height: 30),
                  ElevatedButton(
                    onPressed: _isLoading ? null : _signUp,
                    style: ElevatedButton.styleFrom(
                      backgroundColor: const Color(0xFF6152ff),
                      foregroundColor: const Color(0xFFF5EFE6),
                      minimumSize: const Size(double.infinity, 50),
                    ),
                    child: _isLoading
                        ? const CircularProgressIndicator(color: Color(0xFFF5EFE6))
                        : const Text('Sign Up'),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
      )
    );
  }
}