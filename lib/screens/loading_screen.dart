import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';

class LoadingScreen extends StatelessWidget {
  const LoadingScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          // Background: ModalBarrier
          ModalBarrier(
            color: Colors.black.withOpacity(0.3), // Adjust opacity as needed
            dismissible: false,
          ),
          // Loading Indicator
          Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: const [
                SpinKitFadingCircle(
                  // You can use any loading indicator from flutter_spinkit
                  color: Colors.white,
                  size: 50.0,
                ),
                SizedBox(height: 16.0),
                Text(
                  'Loading...',
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 16.0,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
