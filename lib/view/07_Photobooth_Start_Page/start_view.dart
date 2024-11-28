import 'package:flutter/material.dart';

import '../08_Photobooth_Frame_Page/view/select_frame_view.dart';

class PhotoboothStartView extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xFFF3FDE8),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Image.asset(
              'assets/logo.png',
              width: 400,
              height: 400,
            ),
            ElevatedButton(
              onPressed: () {
                // Navigate to the Login Page
                Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => PhotoboothFrameSelectionPage()));
              },
              style: ElevatedButton.styleFrom(
                  backgroundColor: Color(0xFFA8DF8E), // Background color
                  foregroundColor: Colors.white, // Text color
                  minimumSize: Size(300, 60),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10),
                  )),
              child: Text(
                'START',
                style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
