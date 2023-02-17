// ignore_for_file: file_names

import 'package:aashray/Classes/dashboard.dart';
import 'package:aashray/Classes/my_aashray.dart';
import 'package:aashray/Classes/notifications.dart';
import 'package:aashray/Classes/profile.dart';
import 'package:aashray/Classes/settings.dart';
import 'package:floating_bottom_navigation_bar/floating_bottom_navigation_bar.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class MainScreen extends StatefulWidget {
  const MainScreen({super.key});

  @override
  State<MainScreen> createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen> {
  int _selectedIndex = 0;

  @override
  void initState() {
    super.initState();

    // Customisation
    SystemChrome.setSystemUIOverlayStyle(
      const SystemUiOverlayStyle(
        statusBarColor: Colors.transparent,
        systemNavigationBarColor: Colors.white,
        statusBarIconBrightness: Brightness.light,
      ),
    );
  }

  Future<bool> onBackPress() {
    if (_selectedIndex > 0) {
      setState(() {
        _selectedIndex = 0;
      });
      return Future.value(false);
    } else {
      return Future.value(true);
    }
  }

  final List<Widget> _widgetOptions = const <Widget>[
    Dashboard(),
    MyAashray(),
    Notifications(),
  ];

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () => onBackPress(),
      child: Scaffold(
        appBar: AppBar(
          elevation: 1,
          title: const Text(
            "Aashray",
            style: TextStyle(
              fontSize: 22.0,
            ),
          ),
          actions: <Widget>[
            // profile
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 8.0),
              child: GestureDetector(
                child: const Tooltip(
                  triggerMode: TooltipTriggerMode.longPress,
                  message: "Profile",
                  child: Icon(
                    Icons.account_circle_outlined,
                    size: 25.0,
                  ),
                ),
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      // Login
                      builder: (context) => const Profile(),
                    ),
                  );
                },
              ),
            ),

            // settings
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 18.0),
              child: GestureDetector(
                child: const Tooltip(
                  triggerMode: TooltipTriggerMode.longPress,
                  message: "Settings",
                  child: Icon(
                    Icons.settings,
                    size: 25.0,
                  ),
                ),
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      // Login
                      builder: (context) => const Settings(),
                    ),
                  );
                },
              ),
            ),
          ],
        ),

        // Bottom nav bar
        bottomNavigationBar: SizedBox(
          height: 85.0,
          child: Scaffold(
            backgroundColor: Colors.white,
            body: FloatingNavbar(
              onTap: (int val) {
                setState(() {
                  _selectedIndex = val;
                });
              },
              currentIndex: _selectedIndex,
              backgroundColor: Colors.green,
              borderRadius: 10.0,
              itemBorderRadius: 50.0,
              iconSize: 28.0,
              unselectedItemColor: Colors.white,
              selectedItemColor: Colors.black87,
              selectedBackgroundColor: Colors.white,
              items: [
                FloatingNavbarItem(
                  icon: Icons.dashboard_rounded,
                  title: 'Dashboard',
                ),
                FloatingNavbarItem(
                  icon: Icons.home_filled,
                  title: 'My Aashray',
                ),
                FloatingNavbarItem(
                  icon: Icons.notifications,
                  title: 'Notification',
                ),
              ],
            ),
          ),
        ),
        body: _widgetOptions.elementAt(_selectedIndex),
      ),
    );
  }
}
