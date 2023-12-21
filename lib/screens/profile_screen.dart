import 'dart:io';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:image_picker/image_picker.dart';
import 'package:placement/models/additional.dart';
import 'package:placement/provider/additional_details_provider.dart';
import 'package:url_launcher/url_launcher.dart';

import '../models/education.dart';
import '../models/student.dart';
import '../provider/auth_provider.dart';
import '../provider/education_provider.dart';
import '../provider/student_provider.dart';

class ProfileScreen extends ConsumerWidget {
  const ProfileScreen({super.key});
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final userId = FirebaseAuth.instance.currentUser!.uid;
    final String studentId =
        ModalRoute.of(context)!.settings.arguments as String? ?? userId;

    final studInfo = ref.watch(studentInfoProvider);
    final eduInfo = ref.watch(educationDetailsProvider);
    final authProfile = ref.watch(authenticationProvider);
    final additionalInfo = ref.watch(additionalDetailsProvider);

    final isAdmin = authProfile.isAdmin(userId);

    void _launchURL(uploadedResumeUrl) {
      debugPrint('opening PDF url = $uploadedResumeUrl');
      var googleDocsUrl =
          'https://docs.google.com/gview?embedded=true&url=${Uri.encodeQueryComponent(uploadedResumeUrl)}';
      final Uri uri = Uri.parse(googleDocsUrl);
      launchUrl(uri, mode: LaunchMode.inAppWebView);
    }

    return Scaffold(
      appBar: isAdmin
          ? AppBar(
              title: const Text("Student Profile"),
              backgroundColor: Theme.of(context).colorScheme.inversePrimary,
            )
          : null,
      body: StreamBuilder<StudentInfo?>(
        stream: studInfo.getStudentDetails(studentId),
        builder: (context, studentSnapshot) {
          if (studentSnapshot.connectionState == ConnectionState.waiting) {
            return const Center(
              child: CircularProgressIndicator(),
            );
          }

          if (!studentSnapshot.hasData) {
            return const Center(
              child: Text('No Data Found from student'),
            );
          }

          if (studentSnapshot.hasError) {
            return const Center(
              child: Text('Something went wrong..'),
            );
          }

          return StreamBuilder<EducationDetails?>(
            stream: eduInfo.getEducationDetails(studentId),
            builder: (context, educationSnapshot) {
              if (educationSnapshot.connectionState ==
                  ConnectionState.waiting) {
                return const Center(
                  child: CircularProgressIndicator(),
                );
              }

              if (!educationSnapshot.hasData) {
                return const Center(
                  child: Text('No Data Found from education'),
                );
              }

              if (educationSnapshot.hasError) {
                return const Center(
                  child: Text('Something went wrong..'),
                );
              }
              return StreamBuilder<AdditionalDetails?>(
                stream: additionalInfo.getAdditionalDetailsStream(studentId),
                builder: (context, additionalInfoSnapshot) {
                  if (additionalInfoSnapshot.connectionState ==
                      ConnectionState.waiting) {
                    return const Center(
                      child: CircularProgressIndicator(),
                    );
                  }

                  if (!additionalInfoSnapshot.hasData) {
                    return const Center(
                      child: Text('No Data Found from additionalInfo'),
                    );
                  }

                  if (additionalInfoSnapshot.hasError) {
                    return const Center(
                      child: Text('Something went wrong..'),
                    );
                  }

                  return StreamBuilder<String?>(
                    stream: authProfile.getUserImageUrlStream(),
                    builder: (context, imageSnapshot) {
                      if (imageSnapshot.connectionState ==
                          ConnectionState.waiting) {
                        return const Center(
                          child: CircularProgressIndicator(),
                        );
                      }

                      if (!imageSnapshot.hasData) {
                        return const Center(
                          child: Text('No Data Found from studentProfile'),
                        );
                      }

                      if (imageSnapshot.hasError) {
                        return const Center(
                          child: Text('Something went wrong..'),
                        );
                      }

                      final studentData = studentSnapshot.data!;
                      final educationData = educationSnapshot.data!;
                      final additionalData = additionalInfoSnapshot.data!;
                      // final imgUrl = imageSnapshot.data!;
                      final sgpaList = educationData.sgpaList;

                      return SingleChildScrollView(
                        child: Column(
                          children: [
                            TopPortion(
                                imageUrl: studentData.profileImgUrl,
                                isAdmin: isAdmin),
                            Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Column(
                                children: [
                                  const Divider(),
                                  Row(
                                    mainAxisAlignment: MainAxisAlignment.end,
                                    children: [
                                      InkWell(
                                        onTap: () => _launchURL(
                                            additionalData.uploadedPdfPath),
                                        child: Container(
                                          width: 170,
                                          decoration: BoxDecoration(
                                            borderRadius:
                                                BorderRadius.circular(16),
                                            color: Theme.of(context)
                                                .colorScheme
                                                .inversePrimary,
                                          ),
                                          padding: const EdgeInsets.fromLTRB(
                                              5, 8, 10, 8),
                                          child: Stack(
                                            alignment: Alignment.center,
                                            children: <Widget>[
                                              Text(
                                                "Resume",
                                                style: Theme.of(context)
                                                    .textTheme
                                                    .displayMedium
                                                    ?.copyWith(
                                                      color: Colors.black,
                                                    ),
                                              ),
                                              Align(
                                                alignment: Alignment.topRight,
                                                child: Container(
                                                  decoration:
                                                      const BoxDecoration(
                                                    shape: BoxShape.circle,
                                                    color: Colors.black26,
                                                  ),
                                                  width: 35,
                                                  height: 35,
                                                  child: const Padding(
                                                    padding:
                                                        EdgeInsets.all(8.0),
                                                    child: Icon(
                                                      Icons.arrow_forward,
                                                      color: Colors.black,
                                                      size: 20,
                                                    ),
                                                  ),
                                                ),
                                              ),
                                            ],
                                          ),
                                        ),
                                      ),
                                    ],
                                  ),
                                  const SizedBox(
                                    height: 15,
                                  ),
                                  Container(
                                    decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(10),
                                      border: Border.all(
                                        color: Colors.grey,
                                      ),
                                    ),
                                    child: Padding(
                                      padding: const EdgeInsets.only(
                                        left: 12,
                                        right: 12,
                                        bottom: 12,
                                        top: 12,
                                      ),
                                      child: Column(
                                        children: [
                                          Row(
                                            mainAxisAlignment:
                                                MainAxisAlignment.spaceBetween,
                                            children: [
                                              Text(
                                                "About Me",
                                                style: Theme.of(context)
                                                    .textTheme
                                                    .displayMedium,
                                              ),
                                              if (!isAdmin)
                                                InkWell(
                                                  onTap: () {},
                                                  child: Image.asset(
                                                    'assets/icons/edit.png',
                                                    height: 24,
                                                    color: Colors
                                                        .deepPurple.shade900,
                                                  ),
                                                ),
                                            ],
                                          ),
                                          const SizedBox(
                                            height: 15,
                                          ),
                                          Text(
                                            additionalData.aboutMe,
                                            style: Theme.of(context)
                                                .textTheme
                                                .bodyLarge,
                                            textAlign: TextAlign.justify,
                                          )
                                        ],
                                      ),
                                    ),
                                  ),
                                  const SizedBox(
                                    height: 10,
                                  ),
                                  Container(
                                    decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(10),
                                      border: Border.all(
                                        color: Colors.grey,
                                      ),
                                    ),
                                    child: Padding(
                                      padding: const EdgeInsets.only(
                                        left: 12,
                                        right: 12,
                                        bottom: 12,
                                        top: 12,
                                      ),
                                      child: Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          Row(
                                            mainAxisAlignment:
                                                MainAxisAlignment.spaceBetween,
                                            children: [
                                              Text(
                                                'Personal Details',
                                                style: Theme.of(context)
                                                    .textTheme
                                                    .displayMedium,
                                              ),
                                              if (!isAdmin)
                                                InkWell(
                                                  onTap: () {},
                                                  child: Image.asset(
                                                    'assets/icons/edit.png',
                                                    height: 24,
                                                    color: Colors
                                                        .deepPurple.shade900,
                                                  ),
                                                ),
                                            ],
                                          ),
                                          const SizedBox(
                                            height: 15,
                                          ),
                                          Row(
                                            children: [
                                              Text(
                                                "Name: ",
                                                style: Theme.of(context)
                                                    .textTheme
                                                    .bodyLarge,
                                              ),
                                              Text(
                                                "${studentData.firstName} ${studentData.lastName}",
                                                style: Theme.of(context)
                                                    .textTheme
                                                    .bodyLarge,
                                              ),
                                            ],
                                          ),
                                          const SizedBox(
                                            height: 4,
                                          ),
                                          Row(
                                            children: [
                                              Text(
                                                "Number: ",
                                                style: Theme.of(context)
                                                    .textTheme
                                                    .bodyLarge,
                                              ),
                                              Text(
                                                studentData.number,
                                                style: Theme.of(context)
                                                    .textTheme
                                                    .bodyLarge,
                                              ),
                                            ],
                                          ),
                                          const SizedBox(
                                            height: 4,
                                          ),
                                          Row(
                                            children: [
                                              Text(
                                                "Email: ",
                                                style: Theme.of(context)
                                                    .textTheme
                                                    .bodyLarge,
                                              ),
                                              Text(
                                                studentData.email,
                                                style: Theme.of(context)
                                                    .textTheme
                                                    .bodyLarge,
                                              ),
                                            ],
                                          ),
                                          const SizedBox(
                                            height: 4,
                                          ),
                                          Row(
                                            children: [
                                              Text(
                                                "Address: ",
                                                style: Theme.of(context)
                                                    .textTheme
                                                    .bodyLarge,
                                              ),
                                              Expanded(
                                                child: SingleChildScrollView(
                                                  scrollDirection:
                                                      Axis.horizontal,
                                                  child: Text(
                                                    studentData.location,
                                                    overflow:
                                                        TextOverflow.ellipsis,
                                                    style: Theme.of(context)
                                                        .textTheme
                                                        .bodyLarge,
                                                  ),
                                                ),
                                              ),
                                            ],
                                          ),
                                          // const SizedBox(height: 10),
                                        ],
                                      ),
                                    ),
                                  ),
                                  const SizedBox(
                                    height: 10,
                                  ),
                                  Container(
                                    decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(10),
                                      border: Border.all(
                                        color: Colors.grey,
                                      ),
                                    ),
                                    child: Padding(
                                      padding: const EdgeInsets.only(
                                        left: 12,
                                        right: 12,
                                        bottom: 12,
                                        top: 12,
                                      ),
                                      child: Column(
                                        children: [
                                          Row(
                                            mainAxisAlignment:
                                                MainAxisAlignment.spaceBetween,
                                            children: [
                                              Text(
                                                'Skills',
                                                style: Theme.of(context)
                                                    .textTheme
                                                    .displayMedium,
                                              ),
                                              if (!isAdmin)
                                                InkWell(
                                                  onTap: () {},
                                                  child: Image.asset(
                                                    'assets/icons/edit.png',
                                                    height: 24,
                                                    color: Colors
                                                        .deepPurple.shade900,
                                                  ),
                                                ),
                                            ],
                                          ),
                                          const SizedBox(
                                            height: 15,
                                          ),
                                          Wrap(
                                            alignment:
                                                WrapAlignment.spaceEvenly,
                                            children: [
                                              for (int i = 0;
                                                  i <
                                                      additionalData
                                                          .skills.length;
                                                  i++)
                                                Padding(
                                                  padding:
                                                      const EdgeInsets.only(
                                                    right: 8,
                                                    bottom: 8,
                                                  ),
                                                  child: Container(
                                                    width: additionalData
                                                                .skills[i]
                                                                .length <=
                                                            12
                                                        ? 100
                                                        : 150,
                                                    decoration: BoxDecoration(
                                                      borderRadius:
                                                          BorderRadius.circular(
                                                        25,
                                                      ),
                                                      border: Border.all(
                                                        width: 1,
                                                        color: Colors.grey,
                                                      ),
                                                    ),
                                                    child: Padding(
                                                      padding:
                                                          const EdgeInsets.all(
                                                              8.0),
                                                      child: Center(
                                                        child: Text(
                                                          additionalData
                                                              .skills[i],
                                                          style:
                                                              Theme.of(context)
                                                                  .textTheme
                                                                  .bodyLarge,
                                                        ),
                                                      ),
                                                    ),
                                                  ),
                                                ),
                                            ],
                                          )
                                        ],
                                      ),
                                    ),
                                  ),
                                  const SizedBox(
                                    height: 10,
                                  ),
                                  Container(
                                    decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(10),
                                      border: Border.all(
                                        color: Colors.grey,
                                      ),
                                    ),
                                    child: Padding(
                                      padding: const EdgeInsets.only(
                                        left: 12,
                                        right: 12,
                                        bottom: 12,
                                        top: 12,
                                      ),
                                      child: Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          Row(
                                            mainAxisAlignment:
                                                MainAxisAlignment.spaceBetween,
                                            children: [
                                              Text(
                                                'Academic Details',
                                                style: Theme.of(context)
                                                    .textTheme
                                                    .displayMedium,
                                              ),
                                              if (!isAdmin)
                                                InkWell(
                                                  onTap: () {},
                                                  child: Image.asset(
                                                    'assets/icons/edit.png',
                                                    height: 24,
                                                    color: Colors
                                                        .deepPurple.shade900,
                                                  ),
                                                ),
                                            ],
                                          ),
                                          const SizedBox(
                                            height: 15,
                                          ),
                                          Column(
                                            crossAxisAlignment:
                                                CrossAxisAlignment.start,
                                            children: [
                                              _buildAcademicDetail(
                                                educationData.tenthSchoolName,
                                                "Percentage: ${educationData.tenthPercentage}",
                                                context,
                                              ),
                                              _buildAcademicDetail(
                                                educationData.twelfthSchoolName,
                                                "Percentage: ${educationData.twelfthPercentage}",
                                                context,
                                              ),
                                              _buildAcademicDetail(
                                                educationData.collegeName,
                                                "Cgpa: ${educationData.cgpa}",
                                                context,
                                              ),
                                            ],
                                          ),
                                        ],
                                      ),
                                    ),
                                  ),
                                  const SizedBox(
                                    height: 10,
                                  ),
                                  Container(
                                    decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(10),
                                      border: Border.all(
                                        color: Colors.grey,
                                      ),
                                    ),
                                    child: Padding(
                                      padding: const EdgeInsets.only(
                                        left: 12,
                                        right: 12,
                                        bottom: 12,
                                        top: 12,
                                      ),
                                      child: Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.center,
                                        children: [
                                          Row(
                                            mainAxisAlignment:
                                                MainAxisAlignment.spaceBetween,
                                            children: [
                                              Text(
                                                'Semester Grade Point Average',
                                                style: Theme.of(context)
                                                    .textTheme
                                                    .displayMedium,
                                              ),
                                              if (!isAdmin)
                                                InkWell(
                                                  onTap: () {},
                                                  child: Image.asset(
                                                    'assets/icons/edit.png',
                                                    height: 24,
                                                    color: Colors
                                                        .deepPurple.shade900,
                                                  ),
                                                ),
                                            ],
                                          ),
                                          const SizedBox(
                                            height: 15,
                                          ),
                                          Column(
                                            children: [
                                              for (int i = 0;
                                                  i < sgpaList.length;
                                                  i += 2)
                                                Column(
                                                  children: [
                                                    Row(
                                                      mainAxisAlignment:
                                                          MainAxisAlignment
                                                              .spaceEvenly,
                                                      children: [
                                                        Text(
                                                          "Semester ${i + 1}: ${sgpaList[i].toStringAsFixed(2)}",
                                                          style:
                                                              Theme.of(context)
                                                                  .textTheme
                                                                  .bodyLarge,
                                                        ),
                                                        if (i + 1 <
                                                            sgpaList.length)
                                                          Text(
                                                            "Semester ${i + 2}: ${sgpaList[i + 1].toStringAsFixed(2)}",
                                                            style: Theme.of(
                                                                    context)
                                                                .textTheme
                                                                .bodyLarge,
                                                          ),
                                                      ],
                                                    ),
                                                    const SizedBox(
                                                      height: 7.5,
                                                    ),
                                                  ],
                                                )
                                            ],
                                          ),
                                        ],
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ],
                        ),
                      );
                    },
                  );
                },
              );
            },
          );
        },
      ),
    );
  }
}

class TopPortion extends ConsumerStatefulWidget {
  const TopPortion({Key? key, required this.imageUrl, required this.isAdmin})
      : super(key: key);
  final String imageUrl;
  final isAdmin;

  @override
  ConsumerState<TopPortion> createState() => _TopPortionState();
}

class _TopPortionState extends ConsumerState<TopPortion> {
  File? _pickedImageFile;
  bool _isLoading = false;

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

    final _auth = ref.watch(authenticationProvider);

    final userId = FirebaseAuth.instance.currentUser!.uid;

    setState(() {
      _isLoading = true;
    });

    _pickedImageFile = File(pickedImage.path);

    final imageUrl = await _auth.uploadImageToStorage(
      _pickedImageFile!,
      userId, // Use the user's UID as the image name
    );

    // Save the user's image URL to Firestore
    await _auth.saveUserImage(
      userId,
      imageUrl,
    );

    await ref.watch(studentInfoProvider).updateProfileImageUrl(imageUrl);

    setState(() {
      _isLoading = false;
    });
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
              color: Colors.deepPurple.shade200,
            ),
            child: Icon(
              icon,
              color: Colors.black,
              size: 24.0,
            ),
          ),
        ),
        TextButton(
          onPressed: onPressed,
          child: Text(
            buttonText,
            // Customize the text style if needed
          ),
        ),
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 250,
      child: Stack(
        fit: StackFit.loose,
        children: [
          Container(
            margin: const EdgeInsets.only(bottom: 60),
            decoration: BoxDecoration(
              gradient: LinearGradient(
                begin: Alignment.bottomCenter,
                end: Alignment.topCenter,
                colors: [
                  // Color(0xff0043ba),
                  // Color(0xff006df1),
                  Theme.of(context).colorScheme.inversePrimary,
                  const Color(0xFF4568DC),
                ],
              ),
              borderRadius: const BorderRadius.only(
                bottomLeft: Radius.circular(
                  50,
                ),
                bottomRight: Radius.circular(50),
              ),
            ),
          ),
          Align(
            alignment: Alignment.bottomCenter,
            child: SizedBox(
              width: 160,
              height: 160,
              child: Stack(
                children: [
                  Container(
                    decoration: const BoxDecoration(
                      color: Colors.white,
                      shape: BoxShape.circle,
                    ),
                  ),
                  Container(
                    margin: const EdgeInsets.all(10),
                    alignment: Alignment.center,
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      color: Colors.white,
                      image: _isLoading
                          ? null
                          : DecorationImage(
                              image: NetworkImage(widget.imageUrl),
                            ),
                    ),
                    child:
                        _isLoading ? const CircularProgressIndicator() : null,
                  ),
                  if (!widget.isAdmin)
                    Positioned(
                      bottom: 0,
                      right: 15,
                      top: 100,
                      child: CircleAvatar(
                        radius: 20,
                        child: IconButton(
                          onPressed: () {
                            showModalBottomSheet(
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
                                        left: 20,
                                        right: 10,
                                        top: 10,
                                        bottom: 10),
                                    child: Column(
                                      children: [
                                        Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.spaceBetween,
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
                                          mainAxisAlignment:
                                              MainAxisAlignment.spaceEvenly,
                                          children: [
                                            buildCircularIconButton(
                                              icon: Icons.camera_alt_outlined,
                                              buttonText: "Camera",
                                              onPressed: () {
                                                _pickImage(ImageSource.camera,
                                                    context);
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
                                                _pickImage(ImageSource.gallery,
                                                    context);
                                              },
                                            ),
                                          ],
                                        ),
                                      ],
                                    ),
                                  ),
                                );
                              },
                            );
                          },
                          icon: const Icon(Icons.camera_alt_outlined),
                        ),
                      ),
                    ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}

Widget _buildAcademicDetail(
  String schoolOrCollegeName,
  String percentageOrCgpa,
  BuildContext context,
) {
  return Column(
    crossAxisAlignment: CrossAxisAlignment.start,
    children: [
      Text(
        schoolOrCollegeName,
        style: Theme.of(context).textTheme.bodyLarge!.copyWith(fontSize: 17.5),
      ),
      Text(
        percentageOrCgpa,
        style: Theme.of(context).textTheme.bodyLarge!.copyWith(fontSize: 17.5),
      ),
      const SizedBox(
        height: 10,
      ),
    ],
  );
}
