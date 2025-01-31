import 'package:flutter/material.dart';

class ProfileScreen extends StatefulWidget {
  const ProfileScreen({super.key});

  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  String userName = 'John Vincent Diocampo';
  String userEmail = 'john.dio@example.com';
  String userBio = 'A short bio about the user...';
  List<String> userSkills = ['Flutter', 'Dart', 'UI/UX'];
  bool isEditing = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Profile'),
        backgroundColor: const Color(0xFF1A4D2E),
        foregroundColor: Colors.white,
      ),
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

                // Skills Section
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
                            print(
                                "Saving changes: Name: $userName, Email: $userEmail, Bio: $userBio, Skills: $userSkills");
                            // TODO: Implement saving logic here
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
              ],
            ),
          ),
        ),
      ),
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

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }
}