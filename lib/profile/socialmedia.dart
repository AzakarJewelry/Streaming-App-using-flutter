import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:url_launcher/url_launcher.dart';

class SocialMediaLinks extends StatelessWidget {
  const SocialMediaLinks({super.key});

  void _launchURL(String url) async {
    final Uri uri = Uri.parse(url);
    if (await canLaunchUrl(uri)) {
      await launchUrl(uri);
    } else {
      throw 'Could not launch $url';
    }
  }

  Widget _buildSocialMediaButton({
    required BuildContext context,
    required IconData icon,
    required String text,
    required String url,
  }) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 20.0), // Increased spacing
      child: GestureDetector(
        onTap: () => _launchURL(url),
        child: Row(
          children: [
            const Icon(FontAwesomeIcons.link, color: Colors.white, size: 28), // Icon color set to white
            const SizedBox(width: 20),
            Expanded(
              child: Text(
                text,
                style: const TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                  color: Colors.white, // Text color set to white
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Social Media Links'),
        centerTitle: true,
        foregroundColor: Colors.black, // AppBar text color set to white
      ),
      body: Container(
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            colors: [
              Color(0xFF06041F), // Dark Blue
              Color(0xFF06041F),
            ],
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
          ),
        ),
        child: Padding(
          padding: const EdgeInsets.all(20.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              _buildSocialMediaButton(
                context: context,
                icon: FontAwesomeIcons.facebook,
                text: "Follow us on FACEBOOK",
                url: "https://www.facebook.com/brljewelry",
              ),
              _buildSocialMediaButton(
                context: context,
                icon: FontAwesomeIcons.instagram,
                text: "Follow us on INSTAGRAM",
                url:
                    "https://www.instagram.com/brljewelry/?fbclid=IwY2xjawIfd-9leHRuA2FlbQIxMAABHQNDxTVHF8beBPiz_bU0nq9LQYKF4jotLMDMxAWENi_VsixRsk3uk6iyyw_aem_NzsftROLtfWkvdZRic5d3w#",
              ),
              _buildSocialMediaButton(
                context: context,
                icon: FontAwesomeIcons.tiktok,
                text: "Follow us on TIKTOK",
                url:
                    "https://www.tiktok.com/@brljewelry?fbclid=IwY2xjawIfeIdleHRuA2FlbQIxMAABHeZJoXIR5sEwkoKjaA1DpupQfQQ5j868v7KIXlPpp-rSdvq61PgeuxBr0Q_aem_-lFBLucTu7Rp2lZyD7AMPQ",
              ),
              _buildSocialMediaButton(
                context: context,
                icon: FontAwesomeIcons.youtube,
                text: "Subscribe on YOUTUBE",
                url: "https://www.youtube.com/@azakarjewelryyoutubechanne502",
              ),
              _buildSocialMediaButton(
                context: context,
                icon: FontAwesomeIcons.shoppingBag,
                text: "Shop on SHOPEE",
                url: "https://shopee.ph/azakarjewelryph",
              ),
            ],
          ),
        ),
      ),
    );
  }
}
