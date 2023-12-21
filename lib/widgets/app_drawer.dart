import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:placement/functions/custom_alert_dialog.dart';

import '../models/auth.dart';
import '../models/student.dart';
import '../provider/auth_provider.dart';
import '../provider/student_provider.dart';
import '../routes/app_routes.dart';
import '../screens/introduction_app_screen.dart';

class AppDrawer extends ConsumerWidget {
  const AppDrawer({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final authProfile = Authentication();
    final studInfo = ref.watch(studentInfoProvider);
    final userId = FirebaseAuth.instance.currentUser!.uid;

    return ClipPath(
      clipper: OvalRightBorderClipper(),
      clipBehavior: Clip.antiAliasWithSaveLayer,
      child: Drawer(
        child: Container(
          padding: const EdgeInsets.only(left: 16.0, right: 40),
          decoration: const BoxDecoration(),
          width: 300,
          child: SafeArea(
            child: SingleChildScrollView(
              child: Column(
                children: <Widget>[
                  Container(
                    alignment: Alignment.centerRight,
                    padding: const EdgeInsets.all(8),
                    child: IconButton(
                      icon: const Icon(
                        Icons.power_settings_new,
                      ),
                      onPressed: () => showConfirmationAlertDialog(
                        context,
                        "Are you sure?",
                        "Do you want to Logout from the Clg Placement System App?",
                        () async {
                          await ref
                              .read(authenticationProvider)
                              .signOut()
                              .then((value) {
                            Navigator.of(context).pushReplacement(
                              MaterialPageRoute(
                                builder: (context) =>
                                    const IntroAppPagesScreen(),
                              ),
                            );
                          });
                        },
                      ),
                    ),
                  ),
                  StreamBuilder<String?>(
                    stream: authProfile.getUserImageUrlStream(),
                    builder: (context, imageSnapshot) {
                      if (!imageSnapshot.hasData) {
                        return const Center(
                          child: Text('No Data Found from profile image'),
                        );
                      }

                      if (imageSnapshot.hasError) {
                        return const Center(
                          child: Text('Something went wrong..'),
                        );
                      }

                      final imgUrl = imageSnapshot.data!;
                      return Container(
                        height: 90,
                        width: 90,
                        alignment: Alignment.center,
                        decoration: BoxDecoration(
                          shape: BoxShape.circle,
                          border: Border.all(
                            width: 2,
                            color: Colors.deepPurple.shade200,
                          ),
                          image: DecorationImage(
                            image: NetworkImage(imgUrl),
                          ),
                        ),
                      );
                    },
                  ),
                  const SizedBox(
                    height: 5.0,
                  ),
                  StreamBuilder<StudentInfo?>(
                    stream: studInfo.getStudentDetails(userId),
                    builder: (context, studentSnapshot) {
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

                      final studentData = studentSnapshot.data!;

                      return Column(
                        children: [
                          Text(
                            "${studentData.firstName} ${studentData.lastName}",
                            style: const TextStyle(
                              fontSize: 20.0,
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                          Text(
                            studentData.email,
                            style: const TextStyle(
                              fontSize: 16.0,
                              fontWeight: FontWeight.normal,
                            ),
                          ),
                        ],
                      );
                    },
                  ),
                  const SizedBox(
                    height: 30,
                  ),
                  itemList(
                    SvgPicture.asset(
                      'assets/svg/img_user.svg', // Path to your SVG asset
                      width: 20, // Set the desired width
                      height: 20, // Set the desired height
                    ),
                    "Personal Info",
                    () {
                      Navigator.pushNamed(
                          context, AppRoutes.personalInfoGetterScreen);
                    },
                  ),
                  const Divider(),
                  const SizedBox(
                    height: 15,
                  ),
                  itemList(
                    SvgPicture.asset(
                      'assets/svg/img_experience.svg', // Path to your SVG asset
                      width: 20, // Set the desired width
                      height: 20, // Set the desired height
                    ),
                    "Education Details",
                    () {
                      Navigator.pushNamed(
                          context, AppRoutes.educationGetterScreen);
                    },
                  ),
                  const Divider(),
                  const SizedBox(
                    height: 15,
                  ),
                  itemList(
                    const Icon(
                      Icons.description_outlined,
                      size: 20,
                    ),
                    "Additional Details",
                    () {
                      Navigator.pushNamed(
                          context, AppRoutes.additionalDetailsGetterScreen);
                    },
                  ),
                  const Divider(),
                  const SizedBox(
                    height: 15,
                  ),
                  itemList(
                    const Icon(
                      Icons.check_circle_outline_rounded,
                      size: 20,
                    ),
                    "Result",
                    () {
                      Navigator.pushNamed(
                          context, AppRoutes.resultOfCompanyList);
                    },
                  ),
                  const Divider(),
                  const SizedBox(
                    height: 15,
                  ),
                  itemList(
                    SvgPicture.asset(
                      'assets/svg/img_legal.svg', // Path to your SVG asset
                      width: 20, // Set the desired width
                      height: 20, // Set the desired height
                    ),
                    "Legal and Policies",
                    () {
                      Navigator.pushNamed(
                          context, AppRoutes.privacyPolicyScreen);
                    },
                  ),
                  const Divider(),
                  const SizedBox(
                    height: 15,
                  ),
                  itemList(
                    const Icon(
                      Icons.email_outlined,
                      size: 20,
                    ),
                    "Contact us",
                    () {
                      Navigator.pushNamed(context, AppRoutes.followUsScreen);
                    },
                  ),
                  const Divider(),
                  // const SizedBox(
                  //   height: 15,
                  // ),
                  // itemList(
                  //   SvgPicture.asset(
                  //     'assets/svg/img_help.svg', // Path to your SVG asset
                  //     width: 20, // Set the desired width
                  //     height: 20, // Set the desired height
                  //   ),
                  //   "Help & Feedback",
                  //   () => {},
                  // ),
                  // const Divider(),
                  const SizedBox(
                    height: 15,
                  ),
                  itemList(
                    SvgPicture.asset(
                      'assets/svg/img_about.svg', // Path to your SVG asset
                      width: 20, // Set the desired width
                      height: 20, // Set the desired height
                    ),
                    "About Us",
                    () {
                      Navigator.pushNamed(context, AppRoutes.aboutUsScreen);
                    },
                  ),
                  const Divider(),
                  const SizedBox(
                    height: 15,
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}

Widget itemList(Widget icon, String title, VoidCallback func) {
  return InkWell(
    onTap: func,
    child: Row(
      children: [
        icon,
        const SizedBox(
          width: 10,
        ),
        Text(
          title,
          style: const TextStyle(fontSize: 16),
        ),
      ],
    ),
  );
}

class OvalRightBorderClipper extends CustomClipper<Path> {
  @override
  Path getClip(Size size) {
    var path = Path();
    path.lineTo(0, 0);
    path.lineTo(size.width - 50, 0);
    path.quadraticBezierTo(
        size.width, size.height / 4, size.width, size.height / 2);
    path.quadraticBezierTo(size.width, size.height - (size.height / 4),
        size.width - 40, size.height);
    path.lineTo(0, size.height);
    return path;
  }

  @override
  bool shouldReclip(CustomClipper<Path> oldClipper) {
    return true;
  }
}
