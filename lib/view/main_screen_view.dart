import 'package:booth_bliss/model/user_model.dart';
import 'package:booth_bliss/view/MainScreenController.dart';
import 'package:flutter/material.dart';
import '02_Home_Page/home_view.dart';
import '04_Custom_Page/view/custom_view.dart';
import '05_QR_Page/qr_view.dart';
import '06_Profile_Page/view/profile_view.dart';

class MainScreen extends StatefulWidget {
  final int idx;
  final UserModel user;
  const MainScreen({super.key, required this.idx, required this.user});

  @override
  _MainScreenState createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen> {
  int _selectedIndex = 0;
  late UserModel currUser;

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
    getUser();
  }

  @override
  void initState() {
    super.initState();
    _selectedIndex = widget.idx;
    getUser();
  }

  Future<void> getUser() async{
    UserModel? temp = await MainScreenController().getUser();
    setState(() {
      currUser = temp!;
    });
  }


  // Instead of storing widgets in a list, dynamically create them in build method
  Widget _getSelectedPage(int index) {
    switch (index) {
      case 0:
        return HomeView();
      case 1:
        return CustomView(user: currUser);
      case 2:
        return ScanQR();
      case 3:
        return ProfileView(user: currUser);  // ProfileView will refresh
      default:
        return HomeView();
    }
  }

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;
    final screenHeight = MediaQuery.of(context).size.height;

    return Scaffold(
      body: _getSelectedPage(_selectedIndex),  // Dynamically get selected page
      bottomNavigationBar: Container(
        height: screenHeight * 0.08, // Adjust the height
        child: BottomNavigationBar(
          type: BottomNavigationBarType.fixed,
          backgroundColor: const Color(0xffffe5e5),
          showSelectedLabels: true,
          showUnselectedLabels: true,
          selectedLabelStyle: TextStyle(fontSize: screenWidth * 0.02),
          unselectedLabelStyle: TextStyle(fontSize: screenWidth * 0.02),
          items: [
            BottomNavigationBarItem(
              icon: Container(
                width: screenWidth * 0.08, // Adjust the width
                height: screenWidth * 0.08, // Adjust the height
                child: Icon(Icons.home, size: screenWidth * 0.08), // Larger home icon
              ),
              label: 'Home',
            ),
            BottomNavigationBarItem(
              icon: Container(
                width: screenWidth * 0.08, // Adjust the width
                height: screenWidth * 0.08, // Adjust the height
                child: Icon(Icons.add_box, size: screenWidth * 0.08), // Larger custom icon
              ),
              label: 'Custom',
            ),
            BottomNavigationBarItem(
              icon: Container(
                width: screenWidth * 0.08, // Adjust the width
                height: screenWidth * 0.08, // Adjust the height
                child: Icon(Icons.qr_code, size: screenWidth * 0.08), // Larger scan icon
              ),
              label: 'Scan',
            ),
            BottomNavigationBarItem(
              icon: Container(
                width: screenWidth * 0.08, // Adjust the width
                height: screenWidth * 0.08, // Adjust the height
                child: Icon(Icons.person, size: screenWidth * 0.08), // Larger profile icon
              ),
              label: 'Profile',
            ),
          ],
          currentIndex: _selectedIndex,
          selectedItemColor: const Color(0xff595959),
          unselectedItemColor: Colors.black,
          onTap: _onItemTapped,
        ),
      ),
    );
  }
}
