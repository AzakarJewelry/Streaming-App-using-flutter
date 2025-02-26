import 'package:flutter/material.dart';

class TermsAndConditionsScreen extends StatefulWidget {
  const TermsAndConditionsScreen({super.key});

  @override
  State<TermsAndConditionsScreen> createState() =>
      _TermsAndConditionsScreenState();
}

class _TermsAndConditionsScreenState extends State<TermsAndConditionsScreen> {
  bool hasAgreed = false;

  void _submitAgreement() {
    if (hasAgreed) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('You have agreed to the terms!')),
      );
      Navigator.pop(context); // Navigate back after agreement
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Please agree to the terms first!')),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Terms and Conditions'),
        foregroundColor: const Color(0xFFF5EFE6),
        backgroundColor: const Color(0xFF4d0066),
      ),
      body: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Expanded(
              child: SingleChildScrollView(
                child: Text(
                  'Terms and Conditions\n\n'
                  '1. Acceptance of Terms\nBy accessing or using the App, you agree to these Terms and Conditions and our Privacy Policy. '
                  'If you do not agree, you must stop using the App immediately.\n\n'
                  '2. Changes to Terms\nWe reserve the right to change these Terms and Conditions at any time. '
                  'Any changes will be effective immediately upon posting the revised version on the App.\n\n'
                  '3. Privacy Policy\nOur Privacy Policy is available at Azakar. By using the App, you agree to the terms of our Privacy Policy.\n\n'
                  '4. Contact Us\nIf you have any questions about these Terms and Conditions, please contact us at azakar@gmail.com.\n\n'
                  'Last updated: 1 January 2025',
                  style: TextStyle(fontSize: 16),
                ),
              ),
            ),
            CheckboxListTile(
              value: hasAgreed,
              onChanged: (value) {
                setState(() {
                  hasAgreed = value ?? false;
                });
              },
              title: const Text('I agree to the Terms and Conditions'),
            ),
            SizedBox(
              width: double.infinity,
              child: ElevatedButton(
                style: ElevatedButton.styleFrom(
                  backgroundColor: const Color(0xFF4d0066),
                  foregroundColor: const Color(0xFFF5EFE6),
                ),
                onPressed: _submitAgreement,
                child: const Text('Submit'),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
