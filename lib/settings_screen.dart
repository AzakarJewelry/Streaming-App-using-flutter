import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';

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

  void _rateUs(double rating) {
    setState(() {
      _rating = rating;
    });
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(content: Text('You rated: ${rating.toString()} stars')),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: widget.isDarkMode ? Colors.black : Colors.white,
      appBar: AppBar(
        title: const Text('Settings'),
        backgroundColor: widget.isDarkMode ? Colors.black : Colors.white,
      ),
      body: ListView(
        padding: const EdgeInsets.all(20),
        children: [
          Text(
            'General',
            style: TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.bold,
              color: widget.isDarkMode ? Colors.white : Colors.black,
            ),
          ),
          SwitchListTile(
            title: Text(
              'Dark Mode',
              style: TextStyle(
                color: widget.isDarkMode ? Colors.white : Colors.black,
              ),
            ),
            value: widget.isDarkMode,
            onChanged: widget.onToggleDarkMode,
          ),
          ListTile(
            title: Text(
              'Change Language',
              style: TextStyle(
                color: widget.isDarkMode ? Colors.white : Colors.black,
              ),
            ),
            subtitle: Text(
              selectedLanguage,
              style: TextStyle(
                color: widget.isDarkMode ? Colors.white70 : Colors.black54,
              ),
            ),
            trailing: DropdownButton<String>(
              value: selectedLanguage,
              onChanged: _changeLanguage,
              items: const [
                DropdownMenuItem(
                  value: 'English',
                  child: Text('English'),
                ),
                DropdownMenuItem(
                  value: 'Spanish',
                  child: Text('Spanish'),
                ),
                DropdownMenuItem(
                  value: 'French',
                  child: Text('French'),
                ),
              ],
            ),
          ),
          const SizedBox(height: 20),
          Text(
            'Account',
            style: TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.bold,
              color: widget.isDarkMode ? Colors.white : Colors.black,
            ),
          ),
          ListTile(
            leading: Icon(
              Icons.person_outline,
              color: widget.isDarkMode ? Colors.white : Colors.black,
            ),
            title: Text(
              'Manage Account',
              style: TextStyle(
                color: widget.isDarkMode ? Colors.white : Colors.black,
              ),
            ),
            onTap: _manageAccount,
          ),
          ListTile(
            leading: Icon(
              Icons.feedback_outlined,
              color: widget.isDarkMode ? Colors.white : Colors.black,
            ),
            title: Text(
              'Send Feedback / Help',
              style: TextStyle(
                color: widget.isDarkMode ? Colors.white : Colors.black,
              ),
            ),
            onTap: _sendFeedback,
          ),
          const SizedBox(height: 20),
          Text(
            'About Us',
            style: TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.bold,
              color: widget.isDarkMode ? Colors.white : Colors.black,
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
                color: widget.isDarkMode ? Colors.white : Colors.black,
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
              color: widget.isDarkMode ? Colors.white : Colors.black,
            ),
          ),
          RatingBar.builder(
            initialRating: _rating,
            minRating: 1,
            itemSize: 40,
            itemPadding: const EdgeInsets.symmetric(horizontal: 4.0),
            itemBuilder: (context, _) => Icon(
              Icons.star,
              color: widget.isDarkMode ? Colors.yellow : Colors.orange,
            ),
            onRatingUpdate: _rateUs,
          ),
        ],
      ),
    );
  }
}
