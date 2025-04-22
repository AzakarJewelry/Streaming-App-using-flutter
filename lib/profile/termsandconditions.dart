import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

class TermsAndConditionsScreen extends StatefulWidget {
  const TermsAndConditionsScreen({super.key});

  @override
  State<TermsAndConditionsScreen> createState() =>
      _TermsAndConditionsScreenState();
}

class _TermsAndConditionsScreenState extends State<TermsAndConditionsScreen> {
  bool hasAgreed = false;
  bool isAgreedSubmitted = false;

  @override
  void initState() {
    super.initState();
    _checkAgreementStatus();
  }

  // Function to check if the user has already agreed
  Future<void> _checkAgreementStatus() async {
    User? user = FirebaseAuth.instance.currentUser;
    if (user != null) {
      DocumentSnapshot doc = await FirebaseFirestore.instance
          .collection('user_agreements')
          .doc(user.uid)
          .get();

      if (doc.exists && doc['agreed'] == true) {
        setState(() {
          hasAgreed = true;
          isAgreedSubmitted = true;
        });
      }
    }
  }

  // Function to store agreement in Firestore
  Future<void> _submitAgreement() async {
    if (!hasAgreed) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Please agree to the terms first!')),
      );
      return;
    }

    User? user = FirebaseAuth.instance.currentUser; // Get current user

    if (user != null) {
      await FirebaseFirestore.instance
          .collection('user_agreements')
          .doc(user.uid)
          .set({
        'userId': user.uid,
        'agreed': true,
        'timestamp': FieldValue.serverTimestamp(),
      });

      setState(() {
        isAgreedSubmitted = true;
      });

      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('You have agreed to the terms!')),
      );
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('User not logged in!')),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Terms and Conditions'),
        foregroundColor: Colors.white,
        backgroundColor: const Color(0xFF06041F),
      ),
      body: Container(
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            colors: [Color(0xFF1F1B24), Color(0xFF1F1B24)],
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
          ),
        ),
        child: Padding(
          padding: const EdgeInsets.all(20.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Expanded(
                child: SingleChildScrollView(
                  child: const Text(
                    'Terms and Conditions\n\n'
                    '1. Acceptance of Terms\nBy accessing or using the App, you agree to these Terms and Conditions and our Privacy Policy. '
                    'If you do not agree, you must stop using the App immediately.\n\n'
                    '2. Changes to Terms\nWe reserve the right to change these Terms and Conditions at any time. '
                    'Any changes will be effective immediately upon posting the revised version on the App.\n\n'
                    '3. Privacy Policy\nOur Privacy Policy is available at Azakar. By using the App, you agree to the terms of our Privacy Policy.\n\n'
                    '4. Contact Us\nIf you have any questions about these Terms and Conditions, please contact us at azakar@gmail.com.\n\n'
                    'Last updated: 1 January 2025',
                    style: TextStyle(fontSize: 16, color: Colors.white),
                  ),
                ),
              ),
              CheckboxListTile(
                value: hasAgreed,
                onChanged: isAgreedSubmitted
                    ? null // Disable checkbox if already agreed
                    : (value) {
                        setState(() {
                          hasAgreed = value ?? false;
                        });
                      },
                title: Text(
                  isAgreedSubmitted
                      ? 'You have agreed to the Terms and Conditions ✅'
                      : 'I agree to the Terms and Conditions',
                  style: const TextStyle(color: Colors.white),
                ),
                checkColor: Colors.black,
                activeColor: Colors.white,
              ),
              SizedBox(
                width: double.infinity,
                child: ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    backgroundColor: isAgreedSubmitted
                        ? Colors.grey
                        : const Color(0xFF6237A0),
                    foregroundColor: Colors.white,
                  ),
                  onPressed: isAgreedSubmitted ? null : _submitAgreement,
                  child: const Text('Submit'),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
