import 'package:flutter/material.dart';
import 'package:flutter/services.dart' show rootBundle;
import 'package:flutter_widget_from_html_core/flutter_widget_from_html_core.dart';

class PrivacyPolicyScreen extends StatelessWidget {
  const PrivacyPolicyScreen({super.key});

  Future<String> loadHtmlFromAsset() async {
    return await rootBundle.loadString('assets/file/policy');
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Privacy Policy'),
      ),
      body: FutureBuilder<String>(
        future: loadHtmlFromAsset(),
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            return ListView(
              padding: const EdgeInsets.all(16.0),
              children: <Widget>[
                HtmlWidget(
                  snapshot.data.toString(), // The HTML content from the file
                ),
              ],
            );
          } else if (snapshot.hasError) {
            return const Center(
              child: Text('Error loading Privacy Policy'),
            );
          } else {
            return const Center(
              child:
                  CircularProgressIndicator(), // Show a loading indicator while loading the HTML
            );
          }
        },
      ),
    );
  }
}
