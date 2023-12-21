import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter/material.dart';

import '../functions/custom_alert_dialog.dart';
import '../models/auth.dart';
import '../provider/auth_provider.dart';
import '../routes/app_routes.dart';
import '../screens/introduction_app_screen.dart';

class AdminAppDrawer extends ConsumerWidget {
  const AdminAppDrawer({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final authProfile = Authentication();

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
                            color: Colors.deepPurple.shade300,
                          ),
                          // image: NetworkImage(imgUrl),
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
                  const Column(
                    children: [
                      Text(
                        "Admin",
                        style: TextStyle(
                          fontSize: 20.0,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                      Text(
                        'admin@gmail.com',
                        style: TextStyle(
                          fontSize: 16.0,
                          fontWeight: FontWeight.normal,
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(
                    height: 30,
                  ),
                  itemList(
                    const Icon(Icons.business),
                    " Add Company",
                    () {
                      Navigator.pushNamed(
                          context, AppRoutes.adminCompanyDetailsGetter);
                    },
                  ),
                  const Divider(),
                  const SizedBox(
                    height: 15,
                  ),
                  itemList(
                    const Icon(Icons.supervised_user_circle),
                    "Students List",
                    () {
                      Navigator.pushNamed(context, AppRoutes.adminStudentsList);
                    },
                  ),
                  const Divider(),
                  const SizedBox(
                    height: 15,
                  ),
                  itemList(
                    const Icon(
                      Icons.list,
                    ),
                    "Company List",
                    () {
                      Navigator.pushNamed(
                          context, AppRoutes.adminCompaniesList);
                    },
                  ),
                  const Divider(),
                  const SizedBox(
                    height: 15,
                  ),
                  itemList(
                    // SvgPicture.asset(
                    //   'assets/svg/img_notification.svg', // Path to your SVG asset
                    //   width: 20, // Set the desired width
                    //   height: 20, // Set the desired height
                    // ),
                    const Icon(
                      Icons.abc,
                    ),
                    "Application",
                    () {
                      Navigator.pushNamed(
                          context, AppRoutes.studentsApplicationListScreen);
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
