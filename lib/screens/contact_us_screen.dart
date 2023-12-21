import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';

class FollowUsScreen extends StatelessWidget {
  const FollowUsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Contact Us'),
      ),
      body: SingleChildScrollView(
        child: Container(
          padding: const EdgeInsets.all(16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Center(
                child: Container(
                  width: 150,
                  height: 150,
                  decoration: const BoxDecoration(
                    shape: BoxShape.circle,
                    image: DecorationImage(
                      image: AssetImage(
                        'assets/images/Logo.png',
                      ),
                    ),
                  ),
                ),
              ),
              const SizedBox(height: 16),
              Text(
                'Contact Us',
                style: Theme.of(context).textTheme.displayLarge,
              ),
              const SizedBox(height: 8),
              // Your contact information here

              // Add Hero animations for smooth transitions
              const ListTile(
                leading: Hero(
                  tag: 'locationIcon',
                  child: Icon(Icons.location_on),
                ),
                title: Text(
                  '123 Main Street',
                  style: TextStyle(
                    fontSize: 18,
                    // color: Colors.white,
                  ),
                ),
                subtitle: Text(
                  'Anytown, USA 12345',
                  style: TextStyle(
                    fontSize: 16,
                    // color: Colors.white,
                  ),
                ),
              ),
              const ListTile(
                leading: Hero(
                  tag: 'phoneIcon',
                  child: Icon(Icons.phone),
                ),
                title: Text(
                  '(123) 456-7890',
                  style: TextStyle(
                    fontSize: 18, // Increase the font size
                    // color: Colors.white, // Customize the text color
                  ),
                ),
              ),
              const ListTile(
                leading: Hero(
                  tag: 'emailIcon',
                  child: Icon(Icons.email),
                ),
                title: Text(
                  'info@company.com',
                  style: TextStyle(
                    fontSize: 18, // Increase the font size
                    // color: Colors.white, // Customize the text color
                  ),
                ),
              ),
              const SizedBox(height: 16),
              const Text(
                'Follow Us',
                style: TextStyle(
                  fontSize: 24, // Increase the font size
                  fontWeight: FontWeight.bold, // Use a bold font
                  // color: Colors.white, // Customize the text color
                ),
              ),
              const SizedBox(height: 8),
              // Social media icons with animations
              ListTile(
                leading: const Hero(
                  tag: 'githubIcon',
                  child: Icon(Icons.link),
                ),
                title: const Text(
                  'GitHub',
                  style: TextStyle(
                    fontSize: 18, // Increase the font size
                    // color: Colors.white, // Customize the text color
                  ),
                ),
                onTap: () =>
                    _launchURL(Uri.parse('https://github.com/Nimit19')),
              ),
              ListTile(
                leading: const Hero(
                  tag: 'twitterIcon',
                  child: Icon(Icons.link),
                ),
                title: const Text(
                  'Twitter',
                  style: TextStyle(
                    fontSize: 18, // Increase the font size
                    // color: Colors.white, // Customize the text color
                  ),
                ),
                onTap: () =>
                    _launchURL(Uri.parse('https://www.twitter.com/yourpage')),
              ),
              ListTile(
                leading: const Hero(
                  tag: 'instagramIcon',
                  child: Icon(Icons.link),
                ),
                title: const Text(
                  'Instagram',
                  style: TextStyle(
                    fontSize: 18, // Increase the font size
                    // color: Colors.white, // Customize the text color
                  ),
                ),
                onTap: () =>
                    _launchURL(Uri.parse('https://www.instagram.com/yourpage')),
              ),
            ],
          ),
        ),
      ),
    );
  }

  _launchURL(Uri websiteUrl) async {
    final Uri url = websiteUrl;
    if (!await launchUrl(url)) {
      throw Exception('Could not launch $url');
    }
  }
}
