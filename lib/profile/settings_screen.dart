import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

class SettingsScreen extends StatefulWidget {
  final bool isDarkMode;
  final ValueChanged<bool> onToggleDarkMode;

  const SettingsScreen({
    super.key,
    required this.isDarkMode,
    required this.onToggleDarkMode,
  });

  @override
  State<SettingsScreen> createState() => _SettingsScreenState();
}

class _SettingsScreenState extends State<SettingsScreen> {
  String selectedLanguage = 'English';
  double _rating = 0;

  void _changeLanguage(String? language) {
    if (language != null) {
      setState(() {
        selectedLanguage = language;
      });
    }
  }

  void _manageAccount() {
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(content: Text('Account management clicked!')),
    );
  }

  void _sendFeedback() {
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(content: Text('Feedback clicked!')),
    );
  }

  Future<void> _rateUs(double rating) async {
    setState(() {
      _rating = rating;
    });

    try {
      final user = FirebaseAuth.instance.currentUser;

      await FirebaseFirestore.instance.collection('ratings').add({
        'userId': user?.uid ?? 'anonymous',
        'email': user?.email ?? 'anonymous',
        'rating': rating,
        'timestamp': FieldValue.serverTimestamp(),
      });

      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Thanks! You rated: $rating stars')),
      );
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Failed to save rating: $e')),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    bool isDarkMode = widget.isDarkMode;

    return Scaffold(
      appBar: AppBar(
        title: const Text('Settings'),
        backgroundColor: isDarkMode ? Colors.black : Colors.white,
        iconTheme: IconThemeData(color: isDarkMode ? Colors.white : Colors.black),
      ),
      body: Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            colors: isDarkMode
                ? [const Color(0xFF1F1B24), const Color(0xFF1F1B24)]
                : [const Color(0xFFFFFFFF), const Color(0xFFFFFFFF)],
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
          ),
        ),
        child: ListView(
          padding: const EdgeInsets.all(20),
          children: [
            Text(
              'General',
              style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.bold,
                color: isDarkMode ? Colors.white : Colors.black,
              ),
            ),
            SwitchListTile(
              title: Text(
                'Dark Mode',
                style: TextStyle(color: isDarkMode ? Colors.white : Colors.black),
              ),
              value: isDarkMode,
              onChanged: widget.onToggleDarkMode,
            ),
            ListTile(
              title: Text(
                'Change Language',
                style: TextStyle(color: isDarkMode ? Colors.white : Colors.black),
              ),
              subtitle: Text(
                selectedLanguage,
                style: TextStyle(color: isDarkMode ? Colors.white70 : Colors.black54),
              ),
              trailing: Theme(
                data: Theme.of(context).copyWith(
                  canvasColor: isDarkMode ? Colors.black : Colors.white,
                ),
                child: DropdownButton<String>(
                  value: selectedLanguage,
                  dropdownColor: isDarkMode ? Colors.black : Colors.white,
                  style: TextStyle(color: isDarkMode ? Colors.white : Colors.black),
                  onChanged: _changeLanguage,
                  items: const [
                    DropdownMenuItem(
                      value: 'English',
                      child: Text('English', style: TextStyle(color: Colors.black)),
                    ),
                    DropdownMenuItem(
                      value: 'Spanish',
                      child: Text('Spanish', style: TextStyle(color: Colors.black)),
                    ),
                    DropdownMenuItem(
                      value: 'French',
                      child: Text('French', style: TextStyle(color: Colors.black)),
                    ),
                  ],
                ),
              ),
            ),
            const SizedBox(height: 20),
            Text(
              'Account',
              style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.bold,
                color: isDarkMode ? Colors.white : Colors.black,
              ),
            ),
            ListTile(
              leading: Icon(Icons.person_outline, color: isDarkMode ? Colors.white : Colors.black),
              title: Text(
                'Manage Account',
                style: TextStyle(color: isDarkMode ? Colors.white : Colors.black),
              ),
              onTap: _manageAccount,
            ),
            ListTile(
              leading: Icon(Icons.feedback_outlined, color: isDarkMode ? Colors.white : Colors.black),
              title: Text(
                'Send Feedback / Help',
                style: TextStyle(color: isDarkMode ? Colors.white : Colors.black),
              ),
              onTap: _sendFeedback,
            ),
            const SizedBox(height: 20),
            Text(
              'About Us',
              style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.bold,
                color: isDarkMode ? Colors.white : Colors.black,
              ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 8.0),
              child: Text(
                'Welcome to Azakar Jewelry, a leading streaming app developed by a passionate team dedicated to providing high-quality, seamless entertainment experiences. Our mission is to bring you closer to the content you love through an innovative, user-friendly platform.\n\n'
                'Our app is crafted with care by a dynamic group of creators and developers, including:\n\n'
                '- John Vincent B. Diocmapo – Visionary Developer & Lead Engineer\n'
                '- April Denise Bihag – Creative Director & UX/UI Specialist\n'
                '- Butch Nino Butas – Technical Architect & Backend Developer\n\n'
                'Together, we form a team that’s committed to pushing the boundaries of digital entertainment, ensuring that every user has a smooth and enjoyable experience.\n\n'
                'Azakar Jewelry isn’t just a name; it represents a passion for perfection and innovation. Our company prides itself on creating products and services that are not only functional but also beautifully crafted to enhance your everyday life.\n\n'
                'Thank you for choosing Azakar Jewelry – we look forward to being part of your entertainment journey lets go.',
                style: TextStyle(
                  color: isDarkMode ? Colors.white : Colors.black,
                  fontSize: 14,
                  height: 1.6,
                ),
              ),
            ),
            const SizedBox(height: 20),
            Text(
              'Rate Us',
              style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.bold,
                color: isDarkMode ? Colors.white : Colors.black,
              ),
            ),
            RatingBar.builder(
              initialRating: _rating,
              minRating: 1,
              itemSize: 40,
              itemPadding: const EdgeInsets.symmetric(horizontal: 4.0),
              itemBuilder: (context, _) => Icon(
                Icons.star,
                color: isDarkMode ? Colors.yellow : Colors.yellow,
              ),
              onRatingUpdate: _rateUs,
            ),
          ],
        ),
      ),
    );
  }
}
