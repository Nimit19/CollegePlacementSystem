import 'package:flutter/material.dart';

void showConfirmationAlertDialog(
  BuildContext context,
  String title,
  String content,
  VoidCallback yesFunc,
) {
  showDialog(
    context: context,
    builder: (BuildContext context) {
      return AlertDialog(
        title: Text(title, style: Theme.of(context).textTheme.displayLarge),
        content: Text(
          content,
          style: Theme.of(context).textTheme.bodyLarge!.copyWith(
                color: Colors.black,
              ),
        ),
        actions: [
          TextButton(
            onPressed: () {
              Navigator.of(context).pop();
            },
            child: Text(
              "No",
              style: Theme.of(context).textTheme.titleLarge!.copyWith(
                    fontSize: 26,
                    color: Colors.deepPurple.shade600,
                  ),
            ),
          ),
          TextButton(
            onPressed: () {
              yesFunc();
              Navigator.of(context).pop();
            },
            child: Text(
              "Yes",
              style: Theme.of(context).textTheme.titleLarge!.copyWith(
                    fontSize: 26,
                    color: Colors.deepPurple.shade600,
                  ),
            ),
          ),
        ],
      );
    },
  );
}
