import 'package:flutter/material.dart';

class BottomNavBar extends StatefulWidget {
  final int currentIndex;
  final Function(int) onTap;

  const BottomNavBar(
      {required this.currentIndex, required this.onTap, super.key});

  @override
  _BottomNavBarState createState() => _BottomNavBarState();
}

class _BottomNavBarState extends State<BottomNavBar> {
  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;
    final screenHeight = MediaQuery.of(context).size.height;

    return Container(
      height: screenWidth < 800 ? screenHeight * 0.08 : screenHeight * 0.081,
      child: BottomNavigationBar(
        type: BottomNavigationBarType.fixed,
        backgroundColor: Color(0xffffe5e5),
        showSelectedLabels: true,
        showUnselectedLabels: true,
        selectedLabelStyle: TextStyle(fontSize: screenWidth * 0.02),
        unselectedLabelStyle: TextStyle(fontSize: screenWidth * 0.02),
        items: _buildNavigationBarItems(screenWidth),
        currentIndex: widget.currentIndex,
        selectedItemColor: Color(0xff595959),
        unselectedItemColor: Colors.black,
        onTap: widget.onTap,
      ),
    );
  }

  List<BottomNavigationBarItem> _buildNavigationBarItems(double screenWidth) {
    return [
      _buildNavigationBarItem(Icons.home, 'Home', screenWidth),
      _buildNavigationBarItem(Icons.add_box, 'Custom', screenWidth),
      _buildNavigationBarItem(Icons.qr_code, 'Scan', screenWidth),
      _buildNavigationBarItem(Icons.person, 'Profile', screenWidth),
    ];
  }

  BottomNavigationBarItem _buildNavigationBarItem(
      IconData icon, String label, double screenWidth) {
    return BottomNavigationBarItem(
      icon: Container(
        width: screenWidth < 800 ? screenWidth * 0.08 : screenWidth * 0.07,
        height: screenWidth < 800 ? screenWidth * 0.08 : screenWidth * 0.07,
        child: Icon(icon,
            size: screenWidth < 800 ? screenWidth * 0.08 : screenWidth * 0.07),
      ),
      label: label,
    );
  }
}
