import 'package:booth_bliss/model/user_model.dart';
import 'package:flutter/material.dart';
import '02_Home_Page/home_view.dart';
import '03_Search_Page/search_view.dart';
import '04_Custom_Page/custom_view.dart';
import '05_QR_Page/qr_view.dart';
import '06_Profile_Page/view/profile_view.dart';

class MainScreen extends StatefulWidget {
  const MainScreen({super.key});

  @override
  _MainScreenState createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen> {
  UserModel? user;
  int _selectedIndex = 0;

  // Create widget options list dynamically, based on the user being passed in
  List<Widget> get _widgetOptions => <Widget>[
        HomeView(),
        SearchView(),
        CustomView(),
        ScanQR(),
        ProfileView(user: user!),
      ];

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    user = ModalRoute.of(context)?.settings.arguments as UserModel?;
    final screenWidth = MediaQuery.of(context).size.width;
    final screenHeight = MediaQuery.of(context).size.height;

    if (screenWidth < 800) {
      return Scaffold(
        body: _widgetOptions.elementAt(_selectedIndex),
        bottomNavigationBar: Container(
          height: screenHeight * 0.08, // Adjust the height
          child: BottomNavigationBar(
            type: BottomNavigationBarType.fixed,
            backgroundColor: Color(0xffffe5e5),
            showSelectedLabels: true,
            showUnselectedLabels: true,
            selectedLabelStyle: TextStyle(fontSize: screenWidth * 0.02),
            unselectedLabelStyle: TextStyle(fontSize: screenWidth * 0.02),
            items: [
              BottomNavigationBarItem(
                icon: Container(
                  width: screenWidth * 0.08, // Adjust the width
                  height: screenWidth * 0.08, // Adjust the height
                  child: Icon(Icons.home,
                      size: screenWidth * 0.08), // Larger home icon
                ),
                label: 'Home',
              ),
              BottomNavigationBarItem(
                icon: Container(
                  width: screenWidth * 0.08, // Adjust the width
                  height: screenWidth * 0.08, // Adjust the height
                  child: Icon(Icons.add_box,
                      size: screenWidth * 0.08), // Larger custom icon
                ),
                label: 'Custom',
              ),
              BottomNavigationBarItem(
                icon: Container(
                  width: screenWidth * 0.08, // Adjust the width
                  height: screenWidth * 0.08, // Adjust the height
                  child: Icon(Icons.qr_code,
                      size: screenWidth * 0.08), // Larger scan icon
                ),
                label: 'Scan',
              ),
              BottomNavigationBarItem(
                icon: Container(
                  width: screenWidth * 0.08, // Adjust the width
                  height: screenWidth * 0.08, // Adjust the height
                  child: Icon(Icons.person,
                      size: screenWidth * 0.08), // Larger profile icon
                ),
                label: 'Profile',
              ),
            ],
            currentIndex: _selectedIndex,
            selectedItemColor: Color(0xff595959),
            unselectedItemColor: Colors.black,
            onTap: _onItemTapped,
          ),
        ),
      );
    } else {
      return Scaffold(
        body: _widgetOptions.elementAt(_selectedIndex),
        bottomNavigationBar: Container(
          height: screenHeight * 0.08, // Adjust the height
          child: BottomNavigationBar(
            type: BottomNavigationBarType.fixed,
            backgroundColor: Color(0xffffe5e5),
            showSelectedLabels: true,
            showUnselectedLabels: true,
            selectedLabelStyle: TextStyle(fontSize: screenWidth * 0.02),
            unselectedLabelStyle: TextStyle(fontSize: screenWidth * 0.02),
            items: [
              BottomNavigationBarItem(
                icon: Container(
                  width: screenWidth * 0.07, // Adjust the width
                  height: screenWidth * 0.07, // Adjust the height
                  child: Icon(Icons.home,
                      size: screenWidth * 0.07), // Larger home icon
                ),
                label: 'Home',
              ),
              BottomNavigationBarItem(
                icon: Container(
                  width: screenWidth * 0.07, // Adjust the width
                  height: screenWidth * 0.07, // Adjust the height
                  child: Icon(Icons.add_box,
                      size: screenWidth * 0.07), // Larger custom icon
                ),
                label: 'Custom',
              ),
              BottomNavigationBarItem(
                icon: Container(
                  width: screenWidth * 0.07, // Adjust the width
                  height: screenWidth * 0.07, // Adjust the height
                  child: Icon(Icons.qr_code,
                      size: screenWidth * 0.07), // Larger scan icon
                ),
                label: 'Scan',
              ),
              BottomNavigationBarItem(
                icon: Container(
                  width: screenWidth * 0.07, // Adjust the width
                  height: screenWidth * 0.07, // Adjust the height
                  child: Icon(Icons.person,
                      size: screenWidth * 0.07), // Larger profile icon
                ),
                label: 'Profile',
              ),
            ],
            currentIndex: _selectedIndex,
            selectedItemColor: Color(0xff595959),
            unselectedItemColor: Colors.black,
            onTap: _onItemTapped,
          ),
        ),
      );
    }
  }
}
