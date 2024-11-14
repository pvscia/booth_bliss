
// class UseFrameView extends StatelessWidget {
//   final String filename;

//   const UseFrameView({super.key, required this.filename});

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         title: Center(child: Text('Show QR to Photobooth')),
//       ),
//       body: Padding(
//         padding: const EdgeInsets.all(50.0),
//         child: Row(
//           children: [
//             Expanded(
//               child: QrImageView(
//                 data: filename,
//                 version: QrVersions.auto,
//               ),
//             ),
//           ],
//         ),
//       ),
//     );
//   }
// }


import 'package:flutter/material.dart';
import 'package:qr_flutter/qr_flutter.dart';


class UseFrameView extends StatelessWidget {
  final String filename;

  const UseFrameView({super.key, required this.filename});

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;
    final screenHeight = MediaQuery.of(context).size.height;

    return Scaffold(
      backgroundColor: Color(0xffffe5e5), 
      appBar: PreferredSize(
        preferredSize: Size.fromHeight(70.0), // Set the height of the app bar
        child: AppBar(
          centerTitle: true,
          backgroundColor: Color(0xffffe5e5), // Set the app bar color
          elevation: 0, // Remove the shadow
          title: Text(
              'SHOW QR',
              style: TextStyle(
                color: Colors.black,
                fontWeight: FontWeight.bold,
                fontSize: screenWidth * 0.055,
              ),
            ),
        ),
      ),

      body: Container(
        color: Colors.white, 
        child: Column(
          children: [
            Expanded(
              child: Center(
                child: Padding( // Add Padding here
                  padding: EdgeInsets.all(screenWidth * 0.055), // Set your desired padding
                  child: QrImageView(
                    data: filename,
                    version: QrVersions.auto,
                  ),
                ),
              ),
            ),
            
            Container(
              height: screenHeight * 0.18,
              width: double.infinity,
              color: Color(0xffffe5e5), // Set the background color to green
              padding: EdgeInsets.all(screenWidth * 0.05),
              child: Column(
                 mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    "Show QR code to the QR scanner",
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: screenWidth * 0.05,
                      color: Colors.black, // White text color
                    ),
                    textAlign: TextAlign.center,
                  ),
                  SizedBox(height: 8), // Space between texts
                  Text(
                    "Show QR to use the template",
                    style: TextStyle(
                      color: Colors.black,
                      fontSize: screenWidth * 0.035 // White text color
                    ),
                    textAlign: TextAlign.center,
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

