import 'package:azakarstream/profile/settings_screen.dart';
import 'package:azakarstream/profile/socialmedia.dart';
import 'package:azakarstream/profile/termsandconditions.dart';
import 'package:azakarstream/drama/watch_video_screen.dart';
import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:image_picker/image_picker.dart';
import 'dart:io';
import '../dashboard/dashboard_screen.dart';
import '../favorites/favorites_screen.dart';
import '../main.dart';

class ProfileScreen extends StatefulWidget {
  const ProfileScreen({super.key});

  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  String userName = 'Loading...';
  String userEmail = 'Loading...';
  String userBio = 'Loading...';
  String? profilePhotoUrl;
  bool isEditing = false;
  int _selectedNavIndex = 2; // Set initial index to 2 for Profile

  final FirebaseAuth _auth = FirebaseAuth.instance;
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _bioController = TextEditingController();

  @override
  void initState() {
    super.initState();
    _fetchUserProfile();
  }

  void _fetchUserProfile() async {
    User? currentUser = _auth.currentUser;
    if (currentUser != null) {
      DocumentSnapshot userDoc =
          await _firestore.collection('users').doc(currentUser.uid).get();

      if (userDoc.exists) {
        final data = userDoc.data() as Map<String, dynamic>?; // Safely cast to Map
        setState(() {
          userName = data?['username'] ?? 'No Name';
          userEmail = data?['email'] ?? 'No Email';
          userBio = data?['bio'] ?? 'No Bio'; // Handle missing bio field gracefully
          profilePhotoUrl = data?['profilePhoto'];
          _nameController.text = userName;
          _emailController.text = userEmail;
          _bioController.text = userBio;
        });
      }
    }
  }

  Future<void> _editProfilePhoto() async {
    final ImagePicker picker = ImagePicker();
    final XFile? image =
        await picker.pickImage(source: ImageSource.gallery, imageQuality: 50);

    if (image != null) {
      // Save the photo URL to Firestore (assumes file uploading logic exists)
      User? currentUser = _auth.currentUser;
      if (currentUser != null) {
        String newPhotoUrl = image.path; // Replace with the actual URL after uploading
        await _firestore.collection('users').doc(currentUser.uid).update({
          'profilePhoto': newPhotoUrl,
        });

        setState(() {
          profilePhotoUrl = newPhotoUrl;
        });

        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('Profile photo updated successfully!')),
        );
      }
    }
  }

  void _saveProfileChanges() async {
    User? currentUser = _auth.currentUser;
    if (currentUser != null) {
      await _firestore.collection('users').doc(currentUser.uid).set({
        'username': _nameController.text,
        'email': _emailController.text,
        'bio': _bioController.text,
      }, SetOptions(merge: true));
      setState(() {
        userName = _nameController.text;
        userEmail = _emailController.text;
        userBio = _bioController.text;
        isEditing = false;
      });
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Profile updated successfully!')),
      );
    }
  }

  void _logout() {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Logout'),
        content: const Text('Are you sure you want to logout?'),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text('Cancel'),
          ),
          TextButton(
            onPressed: () {
              _auth.signOut();
              Navigator.pushAndRemoveUntil(
                context,
                MaterialPageRoute(builder: (context) => const MyHomePage()),
                (route) => false,
              );
            },
            child: const Text('Logout'),
          ),
        ],
      ),
    );
  }

  void _showEditProfileDialog() {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Edit Profile'),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            TextField(
              controller: _nameController,
              decoration: const InputDecoration(
                labelText: 'Name',
                border: OutlineInputBorder(),
              ),
            ),
            const SizedBox(height: 10),
            TextField(
              controller: _emailController,
              decoration: const InputDecoration(
                labelText: 'Email',
                border: OutlineInputBorder(),
              ),
            ),
            const SizedBox(height: 10),
            TextField(
              controller: _bioController,
              decoration: const InputDecoration(
                labelText: 'Bio',
                border: OutlineInputBorder(),
              ),
            ),
          ],
        ),
        actions: [
          TextButton(
            onPressed: () {
              setState(() {
                isEditing = false;
              });
              Navigator.pop(context);
            },
            child: const Text('Cancel'),
          ),
          TextButton(
            onPressed: () {
              _saveProfileChanges();
              Navigator.pop(context);
            },
            child: const Text('Save'),
          ),
        ],
      ),
    );
  }

@override
Widget build(BuildContext context) {
  // Determine whether the global theme is dark.
  final bool isDarkMode = Theme.of(context).brightness == Brightness.dark;

  return Scaffold(
    body: Container(
      decoration: BoxDecoration(
        gradient: LinearGradient(
          colors: isDarkMode
                ? [
                const Color(0xFF06041F), // Dark Blue
                const Color(0xFF06041F),
              ]
            : [
                const Color(0xFF06041F), // Same for light mode
                const Color(0xFF06041F),
              ],
        begin: Alignment.topLeft,
        end: Alignment.bottomRight,
      ),
    ),
      child: Column(
        children: [
          // Profile Header
          Container(
            padding: const EdgeInsets.symmetric(vertical: 40),
            color: Colors.transparent, // Ensuring the background gradient is visible
            child: Column(
              children: [
          Stack(
            alignment: Alignment.center,
            children: [
              CircleAvatar(
                radius: 60,
                backgroundImage: profilePhotoUrl != null
              ? FileImage(File(profilePhotoUrl!))
              : null,
                child: profilePhotoUrl == null
              ? const Icon(
                  Icons.person,
                  size: 60,
                  color: Colors.white,
                )
              : null,
              ),
              Positioned(
                bottom: -15,
                right: -15,
                child: IconButton(
            onPressed: _editProfilePhoto,
            icon: const Icon(
              Icons.camera_alt,
              color: Colors.white,
            ),
                ),
              ),
            ],
          ),
          const SizedBox(height: 10),
          Text(
            userName,
            style: const TextStyle(
              fontSize: 20,
              fontWeight: FontWeight.bold,
              color: Colors.white,
            ),
          ),
          const SizedBox(height: 5),
          Text(
            userEmail,
            style: const TextStyle(
              fontSize: 16,
              color: Colors.white70,
            ),
          ),
          const SizedBox(height: 10),
          Text(
            userBio,
            style: const TextStyle(
              fontSize: 14,
              fontStyle: FontStyle.italic,
              color: Colors.white60,
            ),
          ),
              ],
            ),
          ),
          // Menu Options
          Expanded(
            child: Container(
              decoration: BoxDecoration(
          gradient: LinearGradient(
            colors: isDarkMode
                 ? [
                const Color(0xFF06041F), // Dark Blue
                const Color(0xFF06041F),
              ]
            : [
                const Color(0xFF06041F), // Same for light mode
                const Color(0xFF06041F),
              ],
        begin: Alignment.topLeft,
        end: Alignment.bottomRight,
      ),
          borderRadius: const BorderRadius.only(
            topLeft: Radius.circular(20),
            topRight: Radius.circular(20),
          ),
              ),
              child: ListView(
          padding: const EdgeInsets.all(20),
          children: [
            _buildMenuItem(
              icon: Icons.edit,
              title: 'Edit Profile',
              onTap: _showEditProfileDialog,
            ),
            _buildMenuItem(
              icon: Icons.settings,
              title: 'Settings',
              onTap: () {
                final myAppState = MyApp.of(context);
                if (myAppState != null) {
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => SettingsScreen(
                  isDarkMode: myAppState.isDarkMode,
                  onToggleDarkMode: myAppState.toggleDarkMode,
                ),
              ),
            );
                }
              },
            ),
            _buildMenuItem(
              icon: Icons.info_outline,
              title: 'Terms & Conditions',
              onTap: () {
                Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) =>
                  const TermsAndConditionsScreen(),
            ),
                );
              },
            ),
            _buildMenuItem(
              icon: Icons.info_outline,
              title: 'Visit our Social Media Platforms',
              onTap: () {
                Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => const SocialMediaLinks(),
            ),
                );
              },
            ),
            _buildMenuItem(
              icon: Icons.logout,
              title: 'Logout',
              onTap: _logout,
            ),
          ].map((widget) {
            return Container(
              margin: const EdgeInsets.symmetric(vertical: 10),
              decoration: BoxDecoration(
                color: isDarkMode ? const Color(0xFF4d004d) : const Color(0xFFf9e6ff),
                borderRadius: BorderRadius.circular(15),
                boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.1),
              blurRadius: 10,
              offset: const Offset(0, 5),
            ),
                ],
              ),
              child: widget,
            );
          }).toList(),
              ),
            ),
          ),
        ],
      ),
    ),
    bottomNavigationBar: _buildBottomNavigationBar(),
  );
}

  Widget _buildMenuItem({
    required IconData icon,
    required String title,
    VoidCallback? onTap,
  }) {
    final bool isDark = Theme.of(context).brightness == Brightness.dark;
    return ListTile(
      leading: Icon(icon, color: isDark ? Colors.white : Colors.black),
      title: Text(
        title,
        style: TextStyle(
          fontSize: 16,
          fontWeight: FontWeight.w500,
          color: isDark ? Colors.white : Colors.black,
        ),
      ),
      onTap: onTap,
    );
  }

  Widget _buildBottomNavigationBar() {
    final bool isDark = Theme.of(context).brightness == Brightness.dark;
    return BottomNavigationBar(
      backgroundColor:  const Color(0xFF06041f),
      selectedItemColor: Colors.white,
      unselectedItemColor: Colors.white.withOpacity(0.5),
      currentIndex: _selectedNavIndex,
      onTap: (index) {
        setState(() {
          _selectedNavIndex = index;
        });

        if (index == 0) {
          Navigator.pushReplacement(
            context,
            MaterialPageRoute(builder: (context) => const DashboardScreen()),
          );
        } else if (index == 1) {
          Navigator.pushReplacement(
            context,
            MaterialPageRoute(builder: (context) => const FavoriteScreen()),
          );
        } else if (index == 2) {
          Navigator.pushReplacement(
            context,
            MaterialPageRoute(builder: (context) => ProfileScreen()),
          );
        } else if (index == 3) {
          Navigator.pushReplacement(
            context,
            MaterialPageRoute(builder: (context) => const WatchVideoScreen()),
          );
        }
      },
      items: const [
        BottomNavigationBarItem(
          icon: Icon(Icons.home),
          label: 'Home',
        ),
        BottomNavigationBarItem(
          icon: Icon(Icons.favorite),
          label: 'Favorites',
        ),
        BottomNavigationBarItem(
          icon: Icon(Icons.person),
          label: 'Profile',
        ),
        BottomNavigationBarItem(
          icon: Icon(Icons.play_circle_fill),
          label: 'Segments',
        ),
      ],
      type: BottomNavigationBarType.fixed,
    );
  }
}