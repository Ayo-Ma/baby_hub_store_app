import 'package:baby_hub_store_app/Views/category_screens.dart';
import 'package:flutter/material.dart';
import 'package:iconsax/iconsax.dart';
import 'package:baby_hub_store_app/Views/app_home_screen.dart'; // Import your screens

class AppMainScreen extends StatefulWidget {
  const AppMainScreen({super.key});

  @override
  State<AppMainScreen> createState() => _AppMainScreenState();
}

class _AppMainScreenState extends State<AppMainScreen> {
  int _selectedIndex = 0;

  static const List<Widget> pages = <Widget>[
    AppHomeScreen(),
    Scaffold(),
    CategoryScreen(),
    Scaffold(),
    Scaffold()
  ];

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: pages[_selectedIndex],
      bottomNavigationBar: BottomNavigationBar(
        unselectedItemColor: Colors.black38,
        selectedItemColor: Colors.amber[800],
        type: BottomNavigationBarType.fixed,
        currentIndex: _selectedIndex,
        onTap: _onItemTapped,
        elevation: 0,
        backgroundColor: Colors.white,
        items: const [
          BottomNavigationBarItem(icon: Icon(Iconsax.home), label: "Home"),
          BottomNavigationBarItem(
              icon: Icon(Iconsax.search_normal), label: "Search"),
          BottomNavigationBarItem(
              icon: Icon(Iconsax.category),
              label: "Category"), // Added Category item
          BottomNavigationBarItem(
              icon: Icon(Iconsax.notification), label: "Notification"),
          BottomNavigationBarItem(
              icon: Icon(Icons.person_outline), label: "Profile"),
        ],
      ),
    );
  }
}
