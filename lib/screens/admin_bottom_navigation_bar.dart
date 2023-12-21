import 'package:flutter/material.dart';
import 'package:placement/screens/admin_home_screen.dart';
import 'package:placement/widgets/admin_drawer.dart';

import 'message_screen.dart';

class AdminBottomNavigationBar extends StatefulWidget {
  const AdminBottomNavigationBar({super.key});

  @override
  State<AdminBottomNavigationBar> createState() =>
      _AdminBottomNavigationBarState();
}

class _AdminBottomNavigationBarState extends State<AdminBottomNavigationBar> {
  late List<Map<String, Object>> _pages;

  @override
  void initState() {
    _pages = [
      {
        'page': const AdminHomeScreen(),
        'title': "Admin Dashboard",
      },
      {
        'page': const ChatScreen(),
        'title': "Messages",
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
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
      ),
      drawer: const AdminAppDrawer(),
      body: _pages[_selectedPageIndex]['page'] as Widget,
      bottomNavigationBar: Container(
        color: Theme.of(context).colorScheme.inversePrimary,
        child: Padding(
          padding: const EdgeInsets.all(4),
          child: BottomNavigationBar(
            onTap: _selectPage,
            backgroundColor: Theme.of(context).colorScheme.inversePrimary,
            unselectedItemColor: Colors.black,
            selectedItemColor: Theme.of(context).colorScheme.primary,
            currentIndex: _selectedPageIndex,
            elevation: 0,
            // type: BottomNavigationBarType.shifting,
            items: const [
              BottomNavigationBarItem(
                icon: Icon(Icons.dashboard_customize_outlined),
                label: "Dashboard",
              ),
              BottomNavigationBarItem(
                icon: Icon(Icons.messenger_outline_rounded),
                label: "Message",
              ),
            ],
          ),
        ),
      ),
    );
  }
}
