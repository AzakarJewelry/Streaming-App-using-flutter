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
        backgroundColor: const Color(0xFF1A4D2E),
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: Color(0xFFF5EFE6)),
          onPressed: () => Navigator.pop(context),
        ),
      ),
      backgroundColor: const Color(0xFFF5EFE6),
      body: Container(
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            colors: [Color(0xFFF5EFE6), Color(0xFFB9F2FF)], // Gradient colors
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
                    'https://media-hosting.imagekit.io//b79407aaf50f4ad5/Screenshot_2025-02-04_142335-removebg-preview.png?Expires=1833258285&Key-Pair-Id=K2ZIVPTIP2VGHC&Signature=Cl~OJbyKFtcVu27ETGwEKLb0DxYaGYBXRxy9k9D7CLM61zLPD4Qy5ZfXMEWOk7Ktxc~ogKau3hllEYDzGJm7ca7B5mLJGggLB772vNSOCMj3ug2me5SzT3TaSzG3VxF9ehzxz3tFRkYQ6br5Guoy-2gfbjHB~3SXSL1YLtvZlFsyj0skPS841jdCt2l014z7hHEBTq0IStHyT-f~H3Sdqz5nUBPz6WWVdXm3dyqpAxZhhwME57QShkVxadcqm-cQf7EwsNAx88gsU5h5sGFBk0WfLDaePQGzD3mj8z-sWYfLs19fH95covT0MKmyOsPDtN5ElCGt3w9Mj0M1XcFBZw__',
                    height: 100,
                    width: 100,
                  ),
                  const SizedBox(height: 20),
                  Center(
                    child: Text(
                      'DramaMania',
                        style: GoogleFonts.pacifico(
                        fontSize: 32,
                        fontWeight: FontWeight.bold,
                        color: Color(0xFF1A4D2E),
                      ),
                      textAlign: TextAlign.center,
                    ),
                  ),
                  const SizedBox(height: 20),
                  const Text(
                    'Create an account',
                    style: TextStyle(fontSize: 16, color: Color(0xFF1A4D2E)),
                  ),
                  const SizedBox(height: 40),
                  TextField(
                    controller: _emailController,
                    decoration: InputDecoration(
                      labelText: 'Email',
                      border: const OutlineInputBorder(),
                      labelStyle: const TextStyle(color: Color(0xFF1A4D2E)),
                      focusedBorder: const OutlineInputBorder(
                        borderSide: BorderSide(color: Color(0xFF1A4D2E)),
                      ),
                    ),
                    style: const TextStyle(color: Color(0xFF1A4D2E)),
                  ),
                  const SizedBox(height: 20),
                  TextField(
                    controller: _nameController,
                    decoration: InputDecoration(
                      labelText: 'Name',
                      border: const OutlineInputBorder(),
                      labelStyle: const TextStyle(color: Color(0xFF1A4D2E)),
                      focusedBorder: const OutlineInputBorder(
                        borderSide: BorderSide(color: Color(0xFF1A4D2E)),
                      ),
                    ),
                    style: const TextStyle(color: Color(0xFF1A4D2E)),
                  ),
                  const SizedBox(height: 20),
                  TextField(
                    controller: _passwordController,
                    obscureText: !_passwordVisible, // Toggle visibility
                    decoration: InputDecoration(
                      labelText: 'Password',
                      border: const OutlineInputBorder(),
                      labelStyle: const TextStyle(color: Color(0xFF1A4D2E)),
                      focusedBorder: const OutlineInputBorder(
                        borderSide: BorderSide(color: Color(0xFF1A4D2E)),
                      ),
                      suffixIcon: IconButton(
                        icon: Icon(
                          _passwordVisible ? Icons.visibility : Icons.visibility_off,
                          color: Color(0xFF1A4D2E),
                        ),
                        onPressed: () {
                          setState(() {
                            _passwordVisible = !_passwordVisible;
                          });
                        },
                      ),
                    ),
                    style: const TextStyle(color: Color(0xFF1A4D2E)),
                  ),
                  const SizedBox(height: 20),
                  TextField(
                    controller: _confirmPasswordController,
                    obscureText: !_confirmPasswordVisible, // Toggle visibility
                    decoration: InputDecoration(
                      labelText: 'Confirm Password',
                      border: const OutlineInputBorder(),
                      labelStyle: const TextStyle(color: Color(0xFF1A4D2E)),
                      focusedBorder: const OutlineInputBorder(
                        borderSide: BorderSide(color: Color(0xFF1A4D2E)),
                      ),
                      suffixIcon: IconButton(
                        icon: Icon(
                          _confirmPasswordVisible ? Icons.visibility : Icons.visibility_off,
                          color: const Color(0xFF1A4D2E),
                        ),
                        onPressed: () {
                          setState(() {
                            _confirmPasswordVisible = !_confirmPasswordVisible;
                          });
                        },
                      ),
                    ),
                    style: const TextStyle(color: Color(0xFF1A4D2E)),
                  ),
                  const SizedBox(height: 30),
                  ElevatedButton(
                    onPressed: _isLoading ? null : _signUp,
                    style: ElevatedButton.styleFrom(
                      backgroundColor: const Color(0xFF1A4D2E),
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