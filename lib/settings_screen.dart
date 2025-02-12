import 'package:flutter/material.dart';

class SettingsScreen extends StatefulWidget {
  const SettingsScreen({super.key});

  @override
  State<SettingsScreen> createState() => _SettingsScreenState();
}

class _SettingsScreenState extends State<SettingsScreen> {
  bool isDarkMode = false;
  String selectedLanguage = 'Englishh';

  void _toggleDarkMode(bool value) {
    setState(() {
      isDarkMode = value;
    });
    // Logic to apply dark mode can be added here
  }

  void _changeLanguage(String? language) {
    if (language != null) {
      setState(() {
        selectedLanguage = language;
      });
      // Logic to apply language changes can be added here
    }
  }

  void _manageAccount() {
    // Implement account management actions
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(content: Text('Account management clicked!')),
    );
  }

  void _sendFeedback() {
    // Implement feedback or help actions
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(content: Text('Feedback clicked!')),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Settings'),
        backgroundColor: const Color(0xFFF5EFE6),
      ),
      body: ListView(
        padding: const EdgeInsets.all(20),
        children: [
          const Text(
            'General',
            style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
          ),
          SwitchListTile(
            title: const Text('Dark Mode'),
            value: isDarkMode,
            onChanged: _toggleDarkMode,
          ),
          ListTile(
            title: const Text('Change Language'),
            subtitle: Text(selectedLanguage),
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
          const Text(
            'Account',
            style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
          ),
          ListTile(
            leading: const Icon(Icons.person_outline),
            title: const Text('Manage Account'),
            onTap: _manageAccount,
          ),
          ListTile(
            leading: const Icon(Icons.feedback_outlined),
            title: const Text('Send Feedback / Help'),
            onTap: _sendFeedback,
          ),
        ],
      ),
    );
  }
}
