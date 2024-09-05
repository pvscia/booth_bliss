import 'package:booth_bliss/model/user_model.dart';
import 'package:flutter/material.dart';
import '02_Home_Page/home_view.dart';
import '03_Search_Page/search_view.dart';
import '04_Custom_Page/custom_view.dart';
import '05_QR_Page/qr_view.dart';
import '06_Profile_Page/profile_view.dart';

class MainScreen extends StatefulWidget {
  final UserModel user;
  const MainScreen({super.key, required this.user});

  @override
  _MainScreenState createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen> {
  int _selectedIndex = 0;

  // Passing user data to views that require it
  late final List<Widget> _widgetOptions = <Widget>[
    HomeView(user: widget.user),
    SearchView(),
    CustomView(),
    ScanQR(),
    ProfileView(),
  ];

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: _widgetOptions.elementAt(_selectedIndex),
      bottomNavigationBar: BottomNavigationBar(
        items: const <BottomNavigationBarItem>[
          BottomNavigationBarItem(
            icon: Icon(Icons.home),
            label: 'Home',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.search),
            label: 'Search',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.add_box),
            label: 'Custom',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.qr_code),
            label: 'Scan',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.person),
            label: 'Profile',
          ),
        ],
        currentIndex: _selectedIndex,
        selectedItemColor: Colors.amber[800],
        unselectedItemColor: Colors.grey,
        onTap: _onItemTapped,
      ),
    );
  }
}
