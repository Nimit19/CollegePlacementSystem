import 'dart:io';

import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

class ChangeImagePickerWidgets extends StatefulWidget {
  final void Function(File pickedImage) onPickImage;

  ChangeImagePickerWidgets({required this.onPickImage});

  @override
  _ChangeImagePickerWidgetsState createState() =>
      _ChangeImagePickerWidgetsState();
}

class _ChangeImagePickerWidgetsState extends State<ChangeImagePickerWidgets> {
  void _pickImage(ImageSource source) async {
    final pickedImage = await ImagePicker().pickImage(
      source: source,
      imageQuality: 90,
      maxWidth: 150,
    );

    if (pickedImage == null) {
      return;
    }

    Navigator.of(context).pop(); // Close the bottom sheet

    final pickedImageFile = File(pickedImage.path);

    widget.onPickImage(pickedImageFile);
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        showModalBottomSheet(
          context: context,
          isDismissible: true,
          builder: (_) {
            return Container(
              height: 175,
              margin: const EdgeInsets.only(
                  left: 20, right: 10, top: 10, bottom: 10),
              child: Column(
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      const Text(
                        "Profile Image",
                        style: TextStyle(fontSize: 25),
                      ),
                      IconButton(
                        onPressed: () {
                          Navigator.of(context).pop();
                        },
                        icon: const Icon(Icons.delete),
                      ),
                    ],
                  ),
                  const SizedBox(
                    height: 18,
                  ),
                  Row(
                    children: [
                      buildCircularIconButton(
                        icon: Icons.camera_alt,
                        buttonText: "Camera",
                        onPressed: () {
                          _pickImage(ImageSource.camera);
                        },
                      ),
                      const SizedBox(
                        width: 25,
                      ),
                      buildCircularIconButton(
                        icon: Icons.image,
                        buttonText: "Gallery",
                        onPressed: () {
                          _pickImage(ImageSource.gallery);
                        },
                      ),
                    ],
                  ),
                ],
              ),
            );
          },
        );
      },
      behavior: HitTestBehavior.opaque,
      child: Text(
          "Tap to Open Image Picker"), // Replace with your desired trigger text or button
    );
  }

  Widget buildCircularIconButton(
      {required IconData icon,
      required buttonText,
      required VoidCallback onPressed}) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        InkWell(
          onTap: onPressed,
          child: Container(
            width: 56.0,
            height: 56.0,
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              color: Colors.blue,
            ),
            child: Icon(
              icon,
              color: Colors.white,
              size: 24.0,
            ),
          ),
        ),
        TextButton(
          onPressed: onPressed,
          child: Text(
            buttonText,
            style: TextStyle(
                color: Colors.blue), // Customize the text style if needed
          ),
        ),
      ],
    );
  }
}
