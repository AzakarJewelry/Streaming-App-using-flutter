import 'package:flutter/material.dart';

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

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // Background color is determined by the global dark mode value.
      backgroundColor: widget.isDarkMode ? Colors.black : Colors.white,
      appBar: AppBar(
        title: const Text('Settings'),
        // AppBar color adjusts based on dark mode.
        backgroundColor: widget.isDarkMode ? Colors.black : const Color.fromARGB(255, 1, 54, 4),
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
            // Use the global dark mode state.
            value: widget.isDarkMode,
            // When toggled, call the global toggle function.
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
        ],
      ),
    );
  }
}
