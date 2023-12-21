import 'package:flutter/material.dart';

class ErrorScreen extends StatelessWidget {
  const ErrorScreen(Object e, StackTrace stackTrace, {super.key});

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      body: Center(
        child: Text("Error...."),
      ),
    );
  }
}
