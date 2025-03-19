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
        foregroundColor: Colors.white,
        backgroundColor: const Color(0xFF6152ff),
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: Colors.white),
          onPressed: () => Navigator.pop(context),
        ),
      ),
      backgroundColor: const Color(0xFF0A001F), // Deep purple background
      body: Center(
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(20.0),
          child: ConstrainedBox(
            constraints: const BoxConstraints(maxWidth: 400),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                Image.network(
                  'https://res.cloudinary.com/dkhe2vgto/image/upload/v1739954118/dramamania_wulnyr.png',
                  height: 100,
                  width: 100,
                ),
                const SizedBox(height: 20),
                Center(
                  child: Text(
                    'DramaMania',
                    style: GoogleFonts.publicSans(
                      fontSize: 32,
                      color: Colors.white,
                      fontWeight: FontWeight.bold,
                    ),
                    textAlign: TextAlign.center,
                  ),
                ),
                const SizedBox(height: 30),
                buildTextField(_emailController, 'Email Address', Icons.email, false),
                const SizedBox(height: 20),
                buildTextField(_nameController, 'Name', Icons.person, false),
                const SizedBox(height: 20),
                buildTextField(_passwordController, 'Password', Icons.lock, true, isPassword: true),
                const SizedBox(height: 20),
                buildTextField(_confirmPasswordController, 'Confirm Password', Icons.lock, true, isConfirmPassword: true),
                const SizedBox(height: 30),
                ElevatedButton(
                  onPressed: _isLoading ? null : _signUp,
                  style: ElevatedButton.styleFrom(
                    backgroundColor: const Color(0xFF6152ff),
                    foregroundColor: Colors.white,
                    minimumSize: const Size(double.infinity, 50),
                    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
                  ),
                  child: _isLoading
                      ? const CircularProgressIndicator(color: Colors.white)
                      : const Text('Sign Up', style: TextStyle(fontSize: 16)),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget buildTextField(
    TextEditingController controller,
    String label,
    IconData icon,
    bool obscureText, {
    bool isPassword = false,
    bool isConfirmPassword = false,
  }) {
    return TextField(
      controller: controller,
      obscureText: isPassword ? !_passwordVisible : isConfirmPassword ? !_confirmPasswordVisible : false,
      style: const TextStyle(color: Colors.white), // Set text color to white
      decoration: InputDecoration(
        labelText: label,
        labelStyle: const TextStyle(color: Colors.white), // Label text color
        prefixIcon: Icon(icon, color: Color(0xFF6152ff)), // Icon color
        enabledBorder: const UnderlineInputBorder(
          borderSide: BorderSide(color:  Color(0xFF6152ff)), // Underline color
        ),
        focusedBorder: const UnderlineInputBorder(
          borderSide: BorderSide(color:  Color(0xFF6152ff)), // Focus underline color
        ),
        suffixIcon: isPassword || isConfirmPassword
            ? IconButton(
                icon: Icon(
                  (isPassword ? _passwordVisible : _confirmPasswordVisible) ? Icons.visibility : Icons.visibility_off,
                  color: Colors.white,
                ),
                onPressed: () {
                  setState(() {
                    if (isPassword) {
                      _passwordVisible = !_passwordVisible;
                    } else {
                      _confirmPasswordVisible = !_confirmPasswordVisible;
                    }
                  });
                },
              )
            : null,
      ),
    );
  }
}
