import 'package:flutter/material.dart';
import 'dashboard_screen.dart'; // Import the DashboardScreen
import 'forgotpassword.dart'; // Import the Forgot Password screen

class LoginScreen extends StatelessWidget {
  const LoginScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Login'),
        foregroundColor: const Color(0xFFF5EFE6), // Cream text
        backgroundColor: const Color(0xFF1A4D2E), // Green app bar
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: Color(0xFFF5EFE6)), // Cream back arrow
          onPressed: () => Navigator.pop(context),
        ),
      ),
      backgroundColor: const Color(0xFFF5EFE6), // Cream background
      body: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            // Logo above the 'STREAMSCAPE' text
            Image.network(
              'https://media-hosting.imagekit.io//b79407aaf50f4ad5/Screenshot_2025-02-04_142335-removebg-preview.png?Expires=1833258285&Key-Pair-Id=K2ZIVPTIP2VGHC&Signature=Cl~OJbyKFtcVu27ETGwEKLb0DxYaGYBXRxy9k9D7CLM61zLPD4Qy5ZfXMEWOk7Ktxc~ogKau3hllEYDzGJm7ca7B5mLJGggLB772vNSOCMj3ug2me5SzT3TaSzG3VxF9ehzxz3tFRkYQ6br5Guoy-2gfbjHB~3SXSL1YLtvZlFsyj0skPS841jdCt2l014z7hHEBTq0IStHyT-f~H3Sdqz5nUBPz6WWVdXm3dyqpAxZhhwME57QShkVxadcqm-cQf7EwsNAx88gsU5h5sGFBk0WfLDaePQGzD3mj8z-sWYfLs19fH95covT0MKmyOsPDtN5ElCGt3w9Mj0M1XcFBZw__',
              width: 100, // Adjust width if necessary
              height: 100, // Adjust height if necessaryx
              fit: BoxFit.contain,
            ),
            const SizedBox(height: 20),
            const Text(
              'STREAMSCAPE',
              style: TextStyle(
                fontSize: 32,
                fontWeight: FontWeight.bold,
                color: Color(0xFF1A4D2E), // Green text
              ),
            ),
            const SizedBox(height: 39),
            TextField(
              decoration: InputDecoration(
                labelText: 'Email or Username',
                border: OutlineInputBorder(
                  borderSide: BorderSide(color: const Color(0xFF1A4D2E)), // Green border
                ),
                labelStyle: const TextStyle(color: Color(0xFF1A4D2E)), // Green label
                focusedBorder: OutlineInputBorder( // Green focused border
                  borderSide: BorderSide(color: const Color(0xFF1A4D2E)),
                ),
              ),
              style: const TextStyle(color: Color(0xFF1A4D2E)), // Green text
            ),
            const SizedBox(height: 20),
            TextField(
              decoration: InputDecoration(
                labelText: 'Password',
                border: OutlineInputBorder(
                  borderSide: BorderSide(color: const Color(0xFF1A4D2E)), // Green border
                ),
                labelStyle: const TextStyle(color: Color(0xFF1A4D2E)), // Green label
                suffixIcon: IconButton(
                  icon: const Icon(Icons.visibility, color: Color(0xFF1A4D2E)), // Green icon
                  onPressed: () {},
                ),
                focusedBorder: OutlineInputBorder( // Green focused border
                  borderSide: BorderSide(color: const Color(0xFF1A4D2E)),
                ),
              ),
              obscureText: true,
              style: const TextStyle(color: Color(0xFF1A4D2E)), // Green text
            ),
            const SizedBox(height: 10),
            Align(
              alignment: Alignment.centerRight,
              child: TextButton(
                onPressed: () {
                  // Navigate to Forgot Password screen
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => ForgotPasswordScreen()),
                  );
                },
                child: const Text(
                  'Forgot Password?',
                  style: TextStyle(color: Color(0xFF1A4D2E)), // Green text
                ),
              ),
            ),
            const SizedBox(height: 30),
            ElevatedButton(
              onPressed: () {
                // Navigate to the DashboardScreen
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => const DashboardScreen()),
                );
              },
              style: ElevatedButton.styleFrom(
                backgroundColor: const Color(0xFF1A4D2E), // Green button
                foregroundColor: const Color(0xFFF5EFE6), // Cream text
                minimumSize: const Size(double.infinity, 50),
              ),
              child: const Text('Log In'),
            ),
          ],
        ),
      ),
    );
  }
}
