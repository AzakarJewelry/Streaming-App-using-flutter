import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'dashboard_screen.dart';
import 'favorites_screen.dart';
import 'main.dart';

class ProfileScreen extends StatefulWidget {
  const ProfileScreen({super.key});

  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  String userName = 'Loading...';
  String userEmail = 'Loading...';
  String userBio = 'A short bio about the user...';
  List<String> userSkills = ['Flutter', 'Dart', 'UI/UX'];
  bool isEditing = false;
  int _selectedNavIndex = 2; // Set initial index to 2 for Profile

  final FirebaseAuth _auth = FirebaseAuth.instance;
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

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
        setState(() {
          userName = userDoc['username'] ?? 'No Name';
          userEmail = userDoc['email'] ?? 'No Email';
          userBio = userDoc['bio'] ?? 'A short bio about the user...';
          userSkills = List<String>.from(userDoc['skills'] ?? ['Flutter', 'Dart', 'UI/UX']);
        });
      }
    }
  }

  void _saveProfileChanges() async {
    User? currentUser = _auth.currentUser;
    if (currentUser != null) {
      await _firestore.collection('users').doc(currentUser.uid).set({
        'username': userName,
        'email': userEmail,
        'bio': userBio,
        'skills': userSkills,
      }, SetOptions(merge: true));
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF5EFE6),
      body: Center(
        child: Padding(
          padding: const EdgeInsets.all(20.0),
          child: SingleChildScrollView(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Center(
                  child: Padding(
                    padding: const EdgeInsets.only(bottom: 20.0),
                    child: CircleAvatar(
                      radius: 80,
                      backgroundColor: Colors.grey[300],
                      backgroundImage: const NetworkImage(
                          'https://www.pngall.com/wp-content/uploads/5/User-Profile-PNG-Image.png'),
                    ),
                  ),
                ),
                _buildEditableText('Name:', userName, (value) => userName = value),
                const SizedBox(height: 15),
                _buildEditableText('Email:', userEmail, (value) => userEmail = value, keyboardType: TextInputType.emailAddress),
                const SizedBox(height: 15),
                _buildEditableText('Bio:', userBio, (value) => userBio = value, maxLines: 3),
                const SizedBox(height: 25),
                const Padding(
                  padding: EdgeInsets.only(bottom: 10.0),
                  child: Text(
                    'Skills:',
                    style: TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                      color: Color(0xFF1A4D2E),
                    ),
                  ),
                ),
                if (isEditing)
                  _buildEditableSkills()
                else
                  Padding(
                    padding: const EdgeInsets.only(bottom: 20.0),
                    child: Wrap(
                      spacing: 8.0,
                      runSpacing: 4.0,
                      children: userSkills.map((skill) => Chip(label: Text(skill))).toList(),
                    ),
                  ),
                Center(
                  child: Padding(
                    padding: const EdgeInsets.only(top: 20.0),
                    child: ElevatedButton(
                      onPressed: () {
                        setState(() {
                          isEditing = !isEditing;
                          if (!isEditing) {
                            _saveProfileChanges();
                            ScaffoldMessenger.of(context).showSnackBar(
                              const SnackBar(content: Text('Profile updated successfully!')),
                            );
                          }
                        });
                      },
                      style: ElevatedButton.styleFrom(
                        backgroundColor: const Color(0xFF1A4D2E),
                        foregroundColor: Colors.white,
                      ),
                      child: Text(isEditing ? 'Save' : 'Edit Profile'),
                    ),
                  ),
                ),
                const SizedBox(height: 20),
                Center(
                  child: ElevatedButton(
                    onPressed: _logout,
                    style: ElevatedButton.styleFrom(
                      backgroundColor: const Color(0xFF1A4D2E),
                      foregroundColor: Colors.white,
                    ),
                    child: const Text('Logout'),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
      bottomNavigationBar: _buildBottomNavigationBar(),
    );
  }

  Widget _buildEditableText(String label, String value, Function(String) onChanged, {TextInputType? keyboardType, int? maxLines}) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          label,
          style: const TextStyle(
            fontSize: 16,
            fontWeight: FontWeight.bold,
            color: Color(0xFF1A4D2E),
          ),
        ),
        const SizedBox(height: 5),
        if (isEditing)
          TextField(
            onChanged: onChanged,
            decoration: const InputDecoration(border: OutlineInputBorder()),
            keyboardType: keyboardType,
            maxLines: maxLines,
            style: const TextStyle(color: Color(0xFF1A4D2E)),
          )
        else
          Text(
            value,
            style: const TextStyle(color: Color(0xFF1A4D2E)),
          ),
      ],
    );
  }

  Widget _buildEditableSkills() {
    return Wrap(
      spacing: 8.0,
      runSpacing: 4.0,
      children: List.generate(userSkills.length + 1, (index) {
        if (index < userSkills.length) {
          return Chip(
            label: Text(userSkills[index]),
            onDeleted: () {
              setState(() {
                userSkills.removeAt(index);
              });
            },
          );
        } else {
          return ActionChip(
            label: const Text('+ Add Skill'),
            onPressed: () async {
              final newSkill = await showDialog<String>(
                context: context,
                builder: (context) => _AddSkillDialog(),
              );
              if (newSkill != null && newSkill.isNotEmpty) {
                setState(() {
                  userSkills.add(newSkill);
                });
              }
            },
          );
        }
      }),
    );
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

  Widget _buildBottomNavigationBar() {
    return BottomNavigationBar(
      backgroundColor: const Color(0xFF1A4D2E),
      selectedItemColor: const Color(0xFFF5EFE6),
      unselectedItemColor: const Color(0xFFF5EFE6).withOpacity(0.5),
      currentIndex: _selectedNavIndex,
      onTap: (index) {
        setState(() {
          _selectedNavIndex = index;
        });

        if (index == 0) {
          Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => const DashboardScreen()),
          );
        } else if (index == 1) {
          Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => const FavoriteScreen()),
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
      ],
    );
  }
}

class _AddSkillDialog extends StatefulWidget {
  @override
  _AddSkillDialogState createState() => _AddSkillDialogState();
}

class _AddSkillDialogState extends State<_AddSkillDialog> {
  final _controller = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: const Text('Add Skill'),
      content: TextField(
        controller: _controller,
        autofocus: true,
        decoration: const InputDecoration(hintText: 'Enter skill'),
      ),
      actions: [
        TextButton(
          onPressed: () => Navigator.pop(context),
          child: const Text('Cancel'),
        ),
        TextButton(
          onPressed: () => Navigator.pop(context, _controller.text),
          child: const Text('Add'),
        ),
      ],
    );
  }
}
