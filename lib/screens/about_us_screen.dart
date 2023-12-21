import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';

class AboutUsScreen extends StatelessWidget {
  const AboutUsScreen({super.key});

  Future<void> _launchURL(String url) async {
    if (await canLaunch(url)) {
      await launch(url);
    } else {
      throw 'Could not launch $url';
    }
  }

  @override
  Widget build(BuildContext context) {
    double screenWidth = MediaQuery.of(context).size.width;

    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'About Us',
          style: TextStyle(
            color: Colors.white, // Text color for the app bar title
          ),
        ),
        backgroundColor: Colors.deepPurple, // Background color for the app bar
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            // Name and Logo
            Container(
              width: screenWidth,
              padding: const EdgeInsets.all(16),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisSize: MainAxisSize.max,
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  const Text(
                    'NAA Tech Fusion',
                    style: TextStyle(
                      fontSize: 24,
                      fontWeight: FontWeight.bold,
                      color: Colors.deepPurple, // Text color
                    ),
                  ),
                  const SizedBox(height: 16),
                  Container(
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
                ],
              ),
            ),

            // Brief summary
            Container(
              width: screenWidth,
              padding: const EdgeInsets.all(16),
              child: const Text(
                'Welcome to the College Placement System App! We are a passionate team of three computer engineering students – Ankit, Nimit, and Ashutosh – on a mission to bridge the gap between students and their dream careers. This app is the culmination of our collective vision, a labor of love that started as a mini-project during our college journey.',
                style: TextStyle(
                  fontSize: 16,
                  color: Colors.black87,
                ),
                textAlign: TextAlign.justify,
              ),
            ),

            // Mission Statement and Values
            Container(
              width: screenWidth,
              padding: const EdgeInsets.all(16),
              child: const Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Our Journey:',
                    style: TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                      color: Colors.deepPurple,
                    ),
                  ),
                  SizedBox(height: 8),
                  Text(
                    'As computer engineering enthusiasts, we shared a common goal – to simplify the complex process of job hunting and campus placements. We understood the challenges students face when navigating the job market, from finding the right opportunities to preparing for interviews. Inspired by these challenges, we embarked on a journey to develop an app that could make this journey smoother and more rewarding.',
                    style: TextStyle(
                      fontSize: 16,
                      color: Colors.black87,
                    ),
                    textAlign: TextAlign.justify,
                  ),
                  SizedBox(height: 16),
                  Text(
                    'Vision',
                    style: TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                      color: Colors.deepPurple,
                    ),
                  ),
                  SizedBox(height: 8),
                  ListTile(
                    leading: Icon(
                      Icons.check,
                      color: Colors.green, // Checkmark color
                    ),
                    title: Text(
                      'To empower students with the tools and resources they need to succeed in the professional world.',
                      style: TextStyle(
                        fontSize: 16,
                        color: Colors.black87,
                      ),
                      textAlign: TextAlign.justify,
                    ),
                  ),
                  ListTile(
                    leading: Icon(
                      Icons.check,
                      color: Colors.green, // Checkmark color
                    ),
                    title: Text(
                      'We believe that every student deserves a chance to pursue their dream career, and that\'s why we have created this platform.',
                      style: TextStyle(
                        fontSize: 16,
                        color: Colors.black87,
                      ),
                      textAlign: TextAlign.justify,
                    ),
                  ),
                  ListTile(
                    leading: Icon(
                      Icons.check,
                      color: Colors.green, // Checkmark color
                    ),
                    title: Text(
                      'We are dedicated to helping you discover your potential, explore new opportunities, and excel in your career.',
                      style: TextStyle(
                        fontSize: 16,
                        color: Colors.black87,
                      ),
                      textAlign: TextAlign.justify,
                    ),
                  ),
                ],
              ),
            ),

            // History and Background

            // Products or Services
            Container(
              width: screenWidth,
              padding: const EdgeInsets.all(16),
              child: const Text(
                'We invite you to join us on this exciting journey of career growth and exploration. As students ourselves, we understand the challenges you face, and we are committed to making your journey easier and more fruitful.',
                style: TextStyle(
                  fontSize: 16,
                  color: Colors.black87,
                ),
                textAlign: TextAlign.justify,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
