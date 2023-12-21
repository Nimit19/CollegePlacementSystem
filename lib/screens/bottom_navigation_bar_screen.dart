import 'package:flutter/material.dart';
import 'package:google_nav_bar/google_nav_bar.dart';

import 'package:placement/screens/save_jobs_screen.dart';

import '../widgets/app_drawer.dart';
import 'home_screen.dart';
import 'message_screen.dart';
import 'profile_screen.dart';

class BottomNavigationBarScreen extends StatefulWidget {
  const BottomNavigationBarScreen({Key? key}) : super(key: key);

  @override
  State<BottomNavigationBarScreen> createState() =>
      _BottomNavigationBarScreenState();
}

class _BottomNavigationBarScreenState extends State<BottomNavigationBarScreen> {
  late List<Map<String, Object>> _pages;

  @override
  void initState() {
    _pages = [
      {
        'page': const HomeScreen(),
        'title': "Clg Placement System",
      },
      {
        'page': const ChatScreen(),
        'title': "Messages",
      },
      {
        'page': const SavedJobScreen(),
        'title': "Saved Companies",
      },
      {
        'page': const ProfileScreen(),
        'title': "Profile",
      },
    ];

    super.initState();
  }

  int _selectedPageIndex = 0;
  void _selectPage(int index) {
    setState(() {
      _selectedPageIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(_pages[_selectedPageIndex]['title'] as String),
      ),
      drawer: const AppDrawer(),
      body: _pages[_selectedPageIndex]['page'] as Widget,
      bottomNavigationBar: Container(
        color: Theme.of(context).colorScheme.inversePrimary,
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: GNav(
            onTabChange: _selectPage,
            selectedIndex: _selectedPageIndex,
            // rippleColor: Colors.grey[300]!,
            // hoverColor: Colors.grey[100]!,
            gap: 8,
            activeColor: Colors.black,
            // backgroundColor: Colors.blue,
            iconSize: 24,
            padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 12),
            duration: const Duration(milliseconds: 400),
            tabBackgroundColor:
                Theme.of(context).colorScheme.primary.withOpacity(.5),
            color: Colors.black,
            tabs: const [
              GButton(
                icon: Icons.home_outlined,
                text: 'Home',
              ),
              GButton(
                icon: Icons.message_outlined,
                text: 'Message',
              ),
              GButton(
                icon: Icons.bookmark_add_outlined,
                text: 'Saved',
              ),
              GButton(
                icon: Icons.person_outlined,
                text: 'Profile',
              ),
            ],
          ),
        ),
      ),
      // bottomNavigationBar: BottomNavigationBar(
      //   onTap: _selectPage,
      //   backgroundColor: Colors.blue,
      //   unselectedItemColor: Colors.white,
      //   selectedItemColor: Colors.black,
      //   currentIndex: _selectedPageIndex,
      //   type: BottomNavigationBarType.fixed,
      //   items: [
      //     BottomNavigationBarItem(
      //       icon: SvgPicture.asset(
      //         'assets/svg/img_home.svg',
      //         colorFilter: const ColorFilter.mode(
      //           Colors.white,
      //           BlendMode.srcIn,
      //         ),
      //         width: 25,
      //       ),
      //       activeIcon: SvgPicture.asset(
      //         'assets/svg/img_home.svg',
      //         colorFilter: const ColorFilter.mode(
      //           Colors.black,
      //           BlendMode.srcIn,
      //         ),
      //         width: 25,
      //       ),
      //       label: 'Home',
      //     ),
      //     BottomNavigationBarItem(
      //       icon: SvgPicture.asset(
      //         'assets/svg/img_message.svg',
      //         // color: Colors.grey,
      //         colorFilter: const ColorFilter.mode(
      //           Colors.white,
      //           BlendMode.srcIn,
      //         ),
      //       ),
      //       activeIcon: SvgPicture.asset(
      //         'assets/svg/img_message.svg',
      //         colorFilter:
      //             const ColorFilter.mode(Colors.black, BlendMode.srcIn),
      //       ),
      //       label: 'Messages',
      //     ),
      //     BottomNavigationBarItem(
      //       icon: SvgPicture.asset(
      //         'assets/svg/img_saved.svg',
      //         colorFilter: const ColorFilter.mode(
      //           Colors.white,
      //           BlendMode.srcIn,
      //         ),
      //       ),
      //       activeIcon: SvgPicture.asset(
      //         'assets/svg/img_saved.svg',
      //         colorFilter:
      //             const ColorFilter.mode(Colors.black, BlendMode.srcIn),
      //       ),
      //       label: 'Saved',
      //     ),
      //     BottomNavigationBarItem(
      //       icon: SvgPicture.asset(
      //         'assets/svg/img_user_b.svg',
      //         colorFilter: const ColorFilter.mode(
      //           Colors.white,
      //           BlendMode.srcIn,
      //         ),
      //       ),
      //       activeIcon: SvgPicture.asset(
      //         'assets/svg/img_user_b.svg',
      //         colorFilter:
      //             const ColorFilter.mode(Colors.black, BlendMode.srcIn),
      //       ),
      //       label: 'Profile',
      //     ),
      // ],
      // ),
    );
  }
}
