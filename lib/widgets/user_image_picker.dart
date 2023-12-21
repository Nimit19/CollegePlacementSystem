import 'dart:io';

import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

class UserImagePicker extends StatefulWidget {
  const UserImagePicker({super.key, required this.onPickImage});

  final void Function(File pickedImage) onPickImage;
  @override
  State<UserImagePicker> createState() => _UserImagePickerState();
}

class _UserImagePickerState extends State<UserImagePicker> {
  File? _pickedImageFile;

  void _pickImage(ImageSource source, ctx) async {
    final pickedImage = await ImagePicker().pickImage(
      source: source,
      imageQuality: 95,
      maxWidth: 500,
    );

    if (pickedImage == null) {
      return;
    }

    Navigator.of(ctx).pop();

    setState(() {
      _pickedImageFile = File(pickedImage.path);
    });

    widget.onPickImage(_pickedImageFile!);
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
            decoration: const BoxDecoration(
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

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            InkWell(
              onTap: () => showModalBottomSheet(
                  context: context,
                  isDismissible:
                      true, // Set this to true to enable tapping outside to dismiss the bottom sheet.
                  builder: (_) {
                    return GestureDetector(
                      onTap: () {},
                      behavior: HitTestBehavior.opaque,
                      child: Container(
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
                                    setState(() {
                                      _pickedImageFile = null;
                                    });
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
                              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                              children: [
                                buildCircularIconButton(
                                  icon: Icons.camera_alt_outlined,
                                  buttonText: "Camera",
                                  onPressed: () {
                                    _pickImage(ImageSource.camera, context);
                                  },
                                ),
                                Container(
                                  height: 74,
                                  width: 1.0,
                                  color: Colors.black,
                                  margin: const EdgeInsets.only(
                                    left: 15.0,
                                    right: 15.0,
                                    bottom: 35,
                                  ),
                                ),
                                buildCircularIconButton(
                                  icon: Icons.image_outlined,
                                  buttonText: "Gallery",
                                  onPressed: () {
                                    _pickImage(ImageSource.gallery, context);
                                  },
                                ),
                              ],
                            ),
                          ],
                        ),
                      ),
                    );
                  }),
              child: Container(
                width: 120,
                height: 120,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(10),
                  color: Colors.blue,
                  image: _pickedImageFile != null
                      ? DecorationImage(
                          image: FileImage(File(_pickedImageFile!.path)),
                          fit: BoxFit.cover,
                        )
                      : null,
                ),
              ),
            ),
            // const Padding(
            //   padding: EdgeInsets.only(right: 10),
            //   child: Text(
            //     "Sign Up",
            //     style: TextStyle(fontSize: 55),
            //   ),
            // ),
          ],
        ),
        const SizedBox(
          height: 18,
        ),
      ],
    );
  }
}
