import 'package:booth_bliss/model/user_model.dart';
import 'package:booth_bliss/view/bottom_nav_bar_controller.dart';
import 'package:flutter/material.dart';
import '02_Home_Page/view/home_view.dart';
import '03_Custom_Page/view/custom_view.dart';
import '04_QR_Page/view/qr_view.dart';
import '05_Profile_Page/view/profile_view.dart';

class BottomNavBarMain extends StatefulWidget {
  final int idx;
  const BottomNavBarMain({super.key, required this.idx});

  @override
  _BottomNavBarMainState createState() => _BottomNavBarMainState();
}

class _BottomNavBarMainState extends State<BottomNavBarMain> {
  int _selectedIndex = 0;
  UserModel? currUser;

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

  Future<void> getUser() async {
    UserModel? temp = await MainScreenController().getUser();
    if (temp != null) {
      setState(() {
        currUser = temp;
      });
    }
  }


  // Instead of storing widgets in a list, dynamically create them in build method
  Widget _getSelectedPage(int index) {
    if (currUser != null) {
      switch (index) {
        case 0:
          return HomeView();
        case 1:
          return CustomView(user: currUser!);
        case 2:
          return ScanQR();
        case 3:
          return ProfileView(user: currUser!);
        default:
          return HomeView();
      }
    }
    return HomeView();
  }

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;
    final screenHeight = MediaQuery.of(context).size.height;

    return Scaffold(
      body: _getSelectedPage(_selectedIndex), // Dynamically get selected page
      bottomNavigationBar: SizedBox(
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
              icon: SizedBox(
                width: screenWidth * 0.08, // Adjust the width
                height: screenWidth * 0.08, // Adjust the height
                child: Icon(Icons.home,
                    size: screenWidth * 0.08), // Larger home icon
              ),
              label: 'Home',
            ),
            BottomNavigationBarItem(
              icon: SizedBox(
                width: screenWidth * 0.08, // Adjust the width
                height: screenWidth * 0.08, // Adjust the height
                child: Icon(Icons.add_box,
                    size: screenWidth * 0.08), // Larger custom icon
              ),
              label: 'Custom',
            ),
            BottomNavigationBarItem(
              icon: SizedBox(
                width: screenWidth * 0.08, // Adjust the width
                height: screenWidth * 0.08, // Adjust the height
                child: Icon(Icons.qr_code,
                    size: screenWidth * 0.08), // Larger scan icon
              ),
              label: 'Scan',
            ),
            BottomNavigationBarItem(
              icon: SizedBox(
                width: screenWidth * 0.08, // Adjust the width
                height: screenWidth * 0.08, // Adjust the height
                child: Icon(Icons.person,
                    size: screenWidth * 0.08), // Larger profile icon
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
