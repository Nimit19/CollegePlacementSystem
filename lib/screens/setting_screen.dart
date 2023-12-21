import 'package:flutter/material.dart';

import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_svg/svg.dart';

import '../provider/auth_provider.dart';
import '../routes/app_routes.dart';

class SettingScreen extends ConsumerStatefulWidget {
  const SettingScreen({super.key});

  @override
  ConsumerState<SettingScreen> createState() => _SettingScreenState();
}

class _SettingScreenState extends ConsumerState<SettingScreen> {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Column(children: [
        const Align(
          alignment: Alignment.centerLeft,
          child: Padding(
            padding: EdgeInsets.only(left: 5, top: 20),
            child: Text(
              "Account",
              overflow: TextOverflow.ellipsis,
              textAlign: TextAlign.left,
              // style: AppStyle.txtPlusJakartaSansSemiBold12Bluegray400
              //     .copyWith(letterSpacing: getHorizontalSize(0.06)),
            ),
          ),
        ),
        InkWell(
          onTap: () {
            Navigator.pushNamed(context, AppRoutes.personalInfoGetterScreen);
          },
          child: Padding(
            padding: const EdgeInsets.all(16),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                SvgPicture.asset(
                  'assets/svg/img_user.svg', // Path to your SVG asset
                  width: 20, // Set the desired width
                  height: 20, // Set the desired height
                ),
                const SizedBox(
                  width: 10,
                ),
                const Text(
                  "Personal Info",
                  style: TextStyle(fontSize: 18),
                ),
                const Spacer(),
                SvgPicture.asset(
                  'assets/svg/img_arrowright.svg', // Path to your SVG asset
                  width: 20, // Set the desired width
                  height: 20, // Set the desired height
                ),
              ],
            ),
          ),
        ),
        const Divider(
          height: 1,
          thickness: 1,
          // indent: 36,
          // color: Colors.amber,
        ),
        InkWell(
          onTap: () {
            Navigator.pushNamed(context, AppRoutes.educationGetterScreen);
          },
          child: Padding(
            padding: const EdgeInsets.all(16),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                SvgPicture.asset(
                  'assets/svg/img_experience.svg', // Path to your SVG asset
                  width: 20, // Set the desired width
                  height: 20, // Set the desired height
                ),
                const SizedBox(
                  width: 10,
                ),
                const Text(
                  "Education Details",
                  style: TextStyle(fontSize: 18),
                ),
                const Spacer(),
                SvgPicture.asset(
                  'assets/svg/img_arrowright.svg', // Path to your SVG asset
                  width: 20, // Set the desired width
                  height: 20, // Set the desired height
                ),
              ],
            ),
          ),
        ),
        const Divider(
          height: 1,
          thickness: 1,
          // indent: 36,
          // color: Colors.amber,
        ),
        const Align(
            alignment: Alignment.centerLeft,
            child: Padding(
                padding: EdgeInsets.only(left: 5, top: 20),
                child: Text(
                  "General",
                  overflow: TextOverflow.ellipsis,
                  textAlign: TextAlign.left,
                  // style: AppStyle.txtPlusJakartaSansSemiBold12Bluegray400
                  //     .copyWith(letterSpacing: getHorizontalSize(0.06)),
                ))),
        InkWell(
          onTap: () {},
          child: Padding(
            padding: const EdgeInsets.all(16),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                SvgPicture.asset(
                  'assets/svg/img_notification.svg', // Path to your SVG asset
                  width: 20, // Set the desired width
                  height: 20, // Set the desired height
                ),
                const SizedBox(
                  width: 10,
                ),
                const Text(
                  "Notification",
                  style: TextStyle(fontSize: 18),
                ),
                Spacer(),
                SvgPicture.asset(
                  'assets/svg/img_arrowright.svg', // Path to your SVG asset
                  width: 20, // Set the desired width
                  height: 20, // Set the desired height
                ),
              ],
            ),
          ),
        ),
        const Divider(
          height: 1,
          thickness: 1,
          // indent: 36,
          // color: Colors.amber,
        ),
        InkWell(
          onTap: () {},
          child: Padding(
            padding: const EdgeInsets.all(16),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                SvgPicture.asset(
                  'assets/svg/img_language.svg', // Path to your SVG asset
                  width: 20, // Set the desired width
                  height: 20, // Set the desired height
                ),
                const SizedBox(
                  width: 10,
                ),
                const Text(
                  "Language",
                  style: TextStyle(fontSize: 18),
                ),
                const Spacer(),
                SvgPicture.asset(
                  'assets/svg/img_arrowright.svg', // Path to your SVG asset
                  width: 20, // Set the desired width
                  height: 20, // Set the desired height
                ),
              ],
            ),
          ),
        ),
        const Divider(
          height: 1,
          thickness: 1,
          // indent: 36,
          // color: Colors.amber,
        ),
        const Align(
            alignment: Alignment.centerLeft,
            child: Padding(
                padding: EdgeInsets.only(left: 5, top: 20),
                child: Text(
                  "About",
                  overflow: TextOverflow.ellipsis,
                  textAlign: TextAlign.left,
                  // style: AppStyle.txtPlusJakartaSansSemiBold12Bluegray400
                  //     .copyWith(letterSpacing: getHorizontalSize(0.06)),
                ))),
        InkWell(
          onTap: () {},
          child: Padding(
            padding: const EdgeInsets.all(16),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                SvgPicture.asset(
                  'assets/svg/img_legal.svg', // Path to your SVG asset
                  width: 20, // Set the desired width
                  height: 20, // Set the desired height
                ),
                const SizedBox(
                  width: 10,
                ),
                const Text(
                  "Legal and Policies",
                  style: TextStyle(fontSize: 18),
                ),
                const Spacer(),
                SvgPicture.asset(
                  'assets/svg/img_arrowright.svg', // Path to your SVG asset
                  width: 20, // Set the desired width
                  height: 20, // Set the desired height
                ),
              ],
            ),
          ),
        ),
        const Divider(
          height: 1,
          thickness: 1,
          // indent: 36,
          // color: Colors.amber,
        ),
        InkWell(
          onTap: () {},
          child: Padding(
            padding: const EdgeInsets.all(16),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                SvgPicture.asset(
                  'assets/svg/img_help.svg', // Path to your SVG asset
                  width: 20, // Set the desired width
                  height: 20, // Set the desired height
                ),
                const SizedBox(
                  width: 10,
                ),
                const Text(
                  "Help & Feedback",
                  style: TextStyle(fontSize: 18),
                ),
                const Spacer(),
                SvgPicture.asset(
                  'assets/svg/img_arrowright.svg', // Path to your SVG asset
                  width: 20, // Set the desired width
                  height: 20, // Set the desired height
                ),
              ],
            ),
          ),
        ),
        const Divider(
          height: 1,
          thickness: 1,
          // indent: 36,
          // color: Colors.amber,
        ),
        InkWell(
          onTap: () {},
          child: Padding(
            padding: const EdgeInsets.all(16),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                SvgPicture.asset(
                  'assets/svg/img_about.svg', // Path to your SVG asset
                  width: 20, // Set the desired width
                  height: 20, // Set the desired height
                ),
                const SizedBox(
                  width: 10,
                ),
                const Text(
                  "About Us",
                  style: TextStyle(fontSize: 18),
                ),
                const Spacer(),
                SvgPicture.asset(
                  'assets/svg/img_arrowright.svg', // Path to your SVG asset
                  width: 20, // Set the desired width
                  height: 20, // Set the desired height
                ),
              ],
            ),
          ),
        ),
        const Divider(
          height: 1,
          thickness: 1,
          // indent: 36,
          // color: Colors.amber,
        ),
        InkWell(
          onTap: () async {
            final _auth = ref.watch(authenticationProvider);
            await _auth.signOut();
          },
          child: Padding(
            padding: const EdgeInsets.all(16),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                SvgPicture.asset(
                  'assets/svg/img_logout.svg', // Path to your SVG asset
                  width: 20,
                  height: 20,
                ),
                const SizedBox(
                  width: 10,
                ),
                const Text(
                  "Log Out",
                  style: TextStyle(fontSize: 18),
                ),
                const Spacer(),
                SvgPicture.asset(
                  'assets/svg/img_arrowright.svg', // Path to your SVG asset
                  width: 20, // Set the desired width
                  height: 20, // Set the desired height
                ),
              ],
            ),
          ),
        ),
        const Divider(
          height: 1,
          thickness: 1,
          // indent: 36,
          // color: Colors.amber,
        ),
      ]),
    );
  }
}
