import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:url_launcher/url_launcher.dart';

class SocialMediaLinks extends StatelessWidget {
  const SocialMediaLinks({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Social Media Links'),
      ),
      body: Container(
        color: Colors.white, // Set the background color here
        child: ListView(
          padding: const EdgeInsets.all(16.0),
          children: [
            const SizedBox(height: 15),
            GestureDetector(
              onTap: () {
                launchUrl(Uri.parse("https://www.facebook.com/brljewelry"));
              },
              child: Padding(
                padding: const EdgeInsets.symmetric(vertical: 8.0),
                child: Row(
                  children: [
                    const Icon(
                      FontAwesomeIcons.facebook,
                      color: Colors.black,
                    ),
                    const SizedBox(width: 17),
                    const Text(
                      "Follow us on FACEBOOK",
                      style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                        color: Colors.black,
                      ),
                    ),
                  ],
                ),
              ),
            ),
            GestureDetector(
              onTap: () {
                launchUrl(Uri.parse(
                    "https://www.instagram.com/brljewelry/?fbclid=IwY2xjawIfd-9leHRuA2FlbQIxMAABHQNDxTVHF8beBPiz_bU0nq9LQYKF4jotLMDMxAWENi_VsixRsk3uk6iyyw_aem_NzsftROLtfWkvdZRic5d3w#"));
              },
              child: Padding(
                padding: const EdgeInsets.symmetric(vertical: 8.0),
                child: Row(
                  children: [
                    const Icon(
                      FontAwesomeIcons.instagram,
                      color: Colors.black,
                    ),
                    const SizedBox(width: 17),
                    const Text(
                      "Follow us on INSTAGRAM",
                      style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                        color: Colors.black,
                      ),
                    ),
                  ],
                ),
              ),
            ),
            GestureDetector(
              onTap: () {
                launchUrl(Uri.parse(
                    "https://www.tiktok.com/@brljewelry?fbclid=IwY2xjawIfeIdleHRuA2FlbQIxMAABHeZJoXIR5sEwkoKjaA1DpupQfQQ5j868v7KIXlPpp-rSdvq61PgeuxBr0Q_aem_-lFBLucTu7Rp2lZyD7AMPQ"));
              },
              child: Padding(
                padding: const EdgeInsets.symmetric(vertical: 8.0),
                child: Row(
                  children: [
                    const Icon(
                      FontAwesomeIcons.tiktok,
                      color: Colors.black,
                    ),
                    const SizedBox(width: 17),
                    const Text(
                      "Follow us on TIKTOK",
                      style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                        color: Colors.black,
                      ),
                    ),
                  ],
                ),
              ),
            ),
            GestureDetector(
              onTap: () {
                launchUrl(Uri.parse("https://www.youtube.com/@azakarjewelryyoutubechanne502"));
              },
              child: Padding(
                padding: const EdgeInsets.symmetric(vertical: 8.0),
                child: Row(
                  children: [
                    const Icon(
                      FontAwesomeIcons.youtube,
                      color: Colors.black,
                    ),
                    const SizedBox(width: 17),
                    const Text(
                      "Subscribe on YOUTUBE",
                      style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                        color: Colors.black,
                      ),
                    ),
                  ],
                ),
              ),
            ),
            GestureDetector(
              onTap: () {
                launchUrl(Uri.parse("https://shopee.ph/azakarjewelryph"));
              },
              child: Padding(
                padding: const EdgeInsets.symmetric(vertical: 8.0),
                child: Row(
                  children: [
                    const Icon(
                        FontAwesomeIcons.shoppingBag,
                      color: Colors.black,
                    ),
                    const SizedBox(width: 17),
                    const Text(
                      "Shop on SHOPEE",
                      style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                        color: Colors.black,
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
