import 'package:flutter/material.dart';
import 'login.dart'; // Import your existing login screen

class SignUpScreen extends StatelessWidget {
  const SignUpScreen({super.key});

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
      body: Center(
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(20.0),
          child: Center(
            child: ConstrainedBox(
              constraints: const BoxConstraints(maxWidth: 400),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  // Logo added here
                  Image.network(
                    'https://media-hosting.imagekit.io//b79407aaf50f4ad5/Screenshot_2025-02-04_142335-removebg-preview.png?Expires=1833258285&Key-Pair-Id=K2ZIVPTIP2VGHC&Signature=Cl~OJbyKFtcVu27ETGwEKLb0DxYaGYBXRxy9k9D7CLM61zLPD4Qy5ZfXMEWOk7Ktxc~ogKau3hllEYDzGJm7ca7B5mLJGggLB772vNSOCMj3ug2me5SzT3TaSzG3VxF9ehzxz3tFRkYQ6br5Guoy-2gfbjHB~3SXSL1YLtvZlFsyj0skPS841jdCt2l014z7hHEBTq0IStHyT-f~H3Sdqz5nUBPz6WWVdXm3dyqpAxZhhwME57QShkVxadcqm-cQf7EwsNAx88gsU5h5sGFBk0WfLDaePQGzD3mj8z-sWYfLs19fH95covT0MKmyOsPDtN5ElCGt3w9Mj0M1XcFBZw__',
                    height: 100, // Set height for the logo
                    width: 100,  // Set width for the logo
                  ),

                 const SizedBox(height: 20),
                   const Center(
                   child: Text(
                   'STREAMSCAPE',
                   style: TextStyle(
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
                    decoration: InputDecoration(
                      labelText: 'Email or Username',
                      border: OutlineInputBorder(
                        borderSide: BorderSide(color: const Color(0xFF1A4D2E)),
                      ),
                      labelStyle: const TextStyle(color: Color(0xFF1A4D2E)),
                      focusedBorder: OutlineInputBorder(
                        borderSide: BorderSide(color: const Color(0xFF1A4D2E)),
                      ),
                    ),
                    style: const TextStyle(color: Color(0xFF1A4D2E)),
                  ),
                  const SizedBox(height: 20),
                  TextField(
                    decoration: InputDecoration(
                      labelText: 'Name',
                      border: OutlineInputBorder(
                        borderSide: BorderSide(color: const Color(0xFF1A4D2E)),
                      ),
                      labelStyle: const TextStyle(color: Color(0xFF1A4D2E)),
                      focusedBorder: OutlineInputBorder(
                        borderSide: BorderSide(color: const Color(0xFF1A4D2E)),
                      ),
                    ),
                    style: const TextStyle(color: Color(0xFF1A4D2E)),
                  ),
                  const SizedBox(height: 20),
                  TextField(
                    decoration: InputDecoration(
                      labelText: 'Password',
                      border: OutlineInputBorder(
                        borderSide: BorderSide(color: const Color(0xFF1A4D2E)),
                      ),
                      labelStyle: const TextStyle(color: Color(0xFF1A4D2E)),
                      focusedBorder: OutlineInputBorder(
                        borderSide: BorderSide(color: const Color(0xFF1A4D2E)),
                      ),
                    ),
                    obscureText: true,
                    style: const TextStyle(color: Color(0xFF1A4D2E)),
                  ),
                  const SizedBox(height: 20),
                  TextField(
                    decoration: InputDecoration(
                      labelText: 'Confirm Password',
                      border: OutlineInputBorder(
                        borderSide: BorderSide(color: const Color(0xFF1A4D2E)),
                      ),
                      labelStyle: const TextStyle(color: Color(0xFF1A4D2E)),
                      focusedBorder: OutlineInputBorder(
                        borderSide: BorderSide(color: const Color(0xFF1A4D2E)),
                      ),
                    ),
                    obscureText: true,
                    style: const TextStyle(color: Color(0xFF1A4D2E)),
                  ),
                  const SizedBox(height: 30),
                  ElevatedButton(
                    onPressed: () {
                      // Navigate to the login screen
                      Navigator.push(
                        context,
                        MaterialPageRoute(builder: (context) => const LoginScreen()), // Use your LoginScreen widget
                      );
                    },
                    style: ElevatedButton.styleFrom(
                      backgroundColor: const Color(0xFF1A4D2E),
                      foregroundColor: const Color(0xFFF5EFE6),
                      minimumSize: const Size(double.infinity, 50),
                    ),
                    child: const Text('Sign Up'),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
