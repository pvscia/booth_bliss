import 'package:booth_bliss/model/user_model.dart';
import 'package:booth_bliss/view/bottom_nav_bar_controller.dart';
import 'package:flutter/material.dart';
import 'package:permission_handler/permission_handler.dart';
import '02_Home_Page/view/home_view.dart';
import '03_Custom_Page/view/custom_view.dart';
import '04_QR_Page/view/qr_view.dart';
import '05_Profile_Page/view/profile_view.dart';

class BottomNavBarMain extends StatefulWidget {
  final int idx;
  const BottomNavBarMain({super.key, required this.idx});

  @override
  BottomNavBarMainState createState() => BottomNavBarMainState();
}

class BottomNavBarMainState extends State<BottomNavBarMain> {
  int _selectedIndex = 0;
  UserModel? currUser;
  List<Widget>? _pages;

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
    if(_selectedIndex==2){
      _checkAndRequestCameraPermission();
    }
  }

  @override
  void initState() {
    super.initState();
    _selectedIndex = widget.idx;
    getUser();
  }

  Future<void> _checkAndRequestCameraPermission() async {
    PermissionStatus status = await Permission.camera.status;

    if (status.isGranted) {
      // Permission already granted
      print("Camera permission granted.");
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text("Camera permission already granted!")),
      );
    } else if (status.isDenied) {
      // Request permission
      status = await Permission.camera.request();
      if (status.isGranted) {
        print("Camera permission granted after request.");
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text("Camera permission granted.")),
        );
      } else {
        print("Camera permission denied.");
        _showSnackBarToAllow();
      }
    } else if (status.isPermanentlyDenied) {
      // Open app settings to enable permissions
      _showSnackBarToAllow();
      // openAppSettings();
    }
  }

  void _showSnackBarToAllow() {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text("Camera permission is required to proceed. Please enable it in settings. Then restart the app"),
        action: SnackBarAction(
          label: "Open Settings",
          onPressed: () {
            openAppSettings();
          },
        ),
      ),
    );
  }

  Future<void> getUser() async {
    UserModel? temp = await MainScreenController().getUser();
    if (temp != null) {
      setState(() {
        currUser = temp;
        _pages = [
          HomeView(),
          CustomView(user: currUser!),
          ScanQR(),
          ProfileView(user: currUser!),
        ];
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;
    final screenHeight = MediaQuery.of(context).size.height;

    return Scaffold(
      body: _pages == null
          ? Center(child: CircularProgressIndicator())
          : IndexedStack(
        index: _selectedIndex,
        children: _pages!,
      ),
      bottomNavigationBar: SizedBox(
        height: screenHeight * 0.08,
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
                width: screenWidth * 0.08,
                height: screenWidth * 0.08,
                child: Icon(Icons.home, size: screenWidth * 0.08),
              ),
              label: 'Home',
            ),
            BottomNavigationBarItem(
              icon: SizedBox(
                width: screenWidth * 0.08,
                height: screenWidth * 0.08,
                child: Icon(Icons.add_box, size: screenWidth * 0.08),
              ),
              label: 'Custom',
            ),
            BottomNavigationBarItem(
              icon: SizedBox(
                width: screenWidth * 0.08,
                height: screenWidth * 0.08,
                child: Icon(Icons.qr_code, size: screenWidth * 0.08),
              ),
              label: 'Scan',
            ),
            BottomNavigationBarItem(
              icon: SizedBox(
                width: screenWidth * 0.08,
                height: screenWidth * 0.08,
                child: Icon(Icons.person, size: screenWidth * 0.08),
              ),
              label: 'Profile',
            ),
          ],
          currentIndex: _selectedIndex,
          selectedItemColor: Colors.black,
          unselectedItemColor: const Color(0xff808080),
          onTap: _onItemTapped,
        ),
      ),
    );
  }
}
