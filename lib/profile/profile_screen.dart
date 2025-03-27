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
import 'dart:ui';
import 'package:flutter_svg/flutter_svg.dart';

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
        final data = userDoc.data() as Map<String, dynamic>?;
        setState(() {
          userName = data?['username'] ?? 'No Name';
          userEmail = data?['email'] ?? 'No Email';
          userBio = data?['bio'] ?? 'No Bio';
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
      User? currentUser = _auth.currentUser;
      if (currentUser != null) {
        String newPhotoUrl = image.path;
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
    final isDarkMode = Theme.of(context).brightness == Brightness.dark;
    
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        backgroundColor: isDarkMode ? Colors.grey[900] : Colors.white,
        title: Text(
          'Edit Profile',
          style: TextStyle(color: isDarkMode ? Colors.white : Colors.black),
        ),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            TextField(
              controller: _nameController,
              decoration: InputDecoration(
                labelText: 'Name',
                labelStyle: TextStyle(color: isDarkMode ? Colors.white70 : Colors.black54),
                border: OutlineInputBorder(),
                enabledBorder: OutlineInputBorder(
                  borderSide: BorderSide(color: isDarkMode ? Colors.white54 : Colors.black54),
                ),
              ),
              style: TextStyle(color: isDarkMode ? Colors.white : Colors.black),
            ),
            const SizedBox(height: 10),
            TextField(
              controller: _emailController,
              decoration: InputDecoration(
                labelText: 'Email',
                labelStyle: TextStyle(color: isDarkMode ? Colors.white70 : Colors.black54),
                border: OutlineInputBorder(),
                enabledBorder: OutlineInputBorder(
                  borderSide: BorderSide(color: isDarkMode ? Colors.white54 : Colors.black54),
                ),
              ),
              style: TextStyle(color: isDarkMode ? Colors.white : Colors.black),
            ),
            const SizedBox(height: 10),
            TextField(
              controller: _bioController,
              decoration: InputDecoration(
                labelText: 'Bio',
                labelStyle: TextStyle(color: isDarkMode ? Colors.white70 : Colors.black54),
                border: OutlineInputBorder(),
                enabledBorder: OutlineInputBorder(
                  borderSide: BorderSide(color: isDarkMode ? Colors.white54 : Colors.black54),
                ),
              ),
              style: TextStyle(color: isDarkMode ? Colors.white : Colors.black),
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
            child: Text(
              'Cancel',
              style: TextStyle(color: isDarkMode ? Colors.white : Colors.black),
            ),
          ),
          TextButton(
            onPressed: () {
              _saveProfileChanges();
              Navigator.pop(context);
            },
            child: const Text(
              'Save',
              style: TextStyle(color: Color(0xFF6152FF)),
            ),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final isDarkMode = Theme.of(context).brightness == Brightness.dark;
    final textColor = isDarkMode ? Colors.white : Colors.black;
    final iconColor = isDarkMode ? Colors.white : Colors.black;
    final backgroundColor = isDarkMode ? Colors.grey[900]! : Colors.white;
    final cardColor = isDarkMode ? Colors.grey[800]! : Colors.white;
    final shadowColor = isDarkMode ? Colors.black : Colors.grey[200]!;

    return Scaffold(
      backgroundColor: backgroundColor,
      body: Stack(
        children: [
          Column(
            children: [
              // Profile Header
              Container(
                padding: const EdgeInsets.symmetric(vertical: 40),
                decoration: BoxDecoration(
                  gradient: isDarkMode
                      ? LinearGradient(
                          colors: [Colors.grey[850]!, Colors.grey[900]!],
                          begin: Alignment.topLeft,
                          end: Alignment.bottomRight,
                        )
                      : LinearGradient(
                          colors: [Colors.blue[50]!, Colors.white],
                          begin: Alignment.topLeft,
                          end: Alignment.bottomRight,
                        ),
                ),
                child: Column(
                  children: [
                    Stack(
                      alignment: Alignment.center,
                      children: [
                        CircleAvatar(
                          radius: 60,
                          backgroundColor: isDarkMode ? Colors.grey[800] : Colors.grey[200],
                          backgroundImage: profilePhotoUrl != null
                              ? FileImage(File(profilePhotoUrl!))
                              : null,
                          child: profilePhotoUrl == null
                              ? Icon(
                                  Icons.person,
                                  size: 60,
                                  color: iconColor,
                                )
                              : null,
                        ),
                        Positioned(
                          bottom: -15,
                          right: -15,
                          child: IconButton(
                            onPressed: _editProfilePhoto,
                            icon: Container(
                              padding: const EdgeInsets.all(8),
                              decoration: BoxDecoration(
                                color: const Color(0xFF6152FF),
                                shape: BoxShape.circle,
                              ),
                              child: Icon(
                                Icons.camera_alt,
                                color: Colors.white,
                                size: 20,
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 10),
                    Text(
                      userName,
                      style: TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                        color: textColor,
                      ),
                    ),
                    const SizedBox(height: 5),
                    Text(
                      userEmail,
                      style: TextStyle(
                        fontSize: 16,
                        color: textColor.withOpacity(0.7),
                      ),
                    ),
                    const SizedBox(height: 10),
                    Text(
                      userBio,
                      style: TextStyle(
                        fontSize: 14,
                        fontStyle: FontStyle.italic,
                        color: textColor.withOpacity(0.5),
                      ),
                    ),
                  ],
                ),
              ),
              // Menu Options
              Expanded(
                child: Container(
                  color: backgroundColor,
                  child: ListView(
                    padding: const EdgeInsets.all(20),
                    children: [
                      _buildMenuItem(
                        icon: Icons.edit,
                        title: 'Edit Profile',
                        onTap: _showEditProfileDialog,
                        textColor: textColor,
                        iconColor: iconColor,
                        cardColor: cardColor,
                        shadowColor: shadowColor,
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
                        textColor: textColor,
                        iconColor: iconColor,
                        cardColor: cardColor,
                        shadowColor: shadowColor,
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
                        textColor: textColor,
                        iconColor: iconColor,
                        cardColor: cardColor,
                        shadowColor: shadowColor,
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
                        textColor: textColor,
                        iconColor: iconColor,
                        cardColor: cardColor,
                        shadowColor: shadowColor,
                      ),
                      _buildMenuItem(
                        icon: Icons.logout,
                        title: 'Logout',
                        onTap: _logout,
                        textColor: textColor,
                        iconColor: iconColor,
                        cardColor: cardColor,
                        shadowColor: shadowColor,
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
          // Bottom Navigation Bar
          Positioned(
            left: 20,
            right: 20,
            bottom: 0,
            child: Padding(
              padding: const EdgeInsets.only(bottom: 12.0),
              child: ClipRRect(
                borderRadius: BorderRadius.circular(20),
                child: BackdropFilter(
                  filter: ImageFilter.blur(sigmaX: 10, sigmaY: 10), // Stronger blur
                  child: Container(
                    margin: const EdgeInsets.symmetric(horizontal: 5),
                    padding: const EdgeInsets.symmetric(vertical: 5 ),
                    decoration: BoxDecoration(
                      color: Colors.transparent,
                    
                    ),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      children: [
                        _buildNavItem('assets/icons/home.svg', 'Home', 0, textColor),
                        _buildNavItem('assets/icons/heart.svg', 'Favorites', 1, textColor),
                        _buildNavItem('assets/icons/user.svg', 'Profile', 2, textColor),
                        _buildNavItem('assets/icons/play-circle.svg', 'Reels', 3, textColor),
                      ],
                    ),
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildNavItem(String iconPath, String label, int index, Color textColor) {
    final isSelected = _selectedNavIndex == index;
    final isDarkMode = Theme.of(context).brightness == Brightness.dark;

    return GestureDetector(
      onTap: () {
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
        } else if (index == 3) {
          Navigator.pushReplacement(
            context,
            MaterialPageRoute(builder: (context) => const WatchVideoScreen()),
          );
        }
      },
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          SvgPicture.asset(
            iconPath,
            height: 24,
            width: 24,
            colorFilter: ColorFilter.mode(
              isSelected
                  ? const Color(0xFF6152FF)
                  : isDarkMode ? Colors.white70 : Colors.black54,
              BlendMode.srcIn,
            ),
          ),
          const SizedBox(height: 4),
          Text(
            label,
            style: TextStyle(
              fontSize: 12,
              color: isSelected
                  ? const Color(0xFF6152FF)
                  : isDarkMode ? Colors.white70 : Colors.black54,
              fontWeight: isSelected ? FontWeight.bold : FontWeight.normal,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildMenuItem({
    required IconData icon,
    required String title,
    VoidCallback? onTap,
    required Color textColor,
    required Color iconColor,
    required Color cardColor,
    required Color shadowColor,
  }) {
    return Container(
      margin: const EdgeInsets.symmetric(vertical: 8),
      decoration: BoxDecoration(
        color: cardColor,
        borderRadius: BorderRadius.circular(15),
        boxShadow: [
          BoxShadow(
            color: shadowColor,
            blurRadius: 10,
            offset: const Offset(0, 5),
          ),
        ],
      ),
      child: ListTile(
        leading: Icon(icon, color: iconColor),
        title: Text(
          title,
          style: TextStyle(
            fontSize: 16,
            fontWeight: FontWeight.w500,
            color: textColor,
          ),
        ),
        trailing: Icon(Icons.chevron_right, color: iconColor),
        onTap: onTap,
      ),
    );
  }
}