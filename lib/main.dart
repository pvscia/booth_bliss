import 'package:booth_bliss/firebase_options.dart';
import 'package:booth_bliss/view/01_Front_page/view/login_view.dart';
import 'package:booth_bliss/view/01_Front_page/view/sign_in_up_view.dart';
import 'package:booth_bliss/view/01_Front_page/view/sign_up_view.dart';
import 'package:booth_bliss/view/main_screen_view.dart';
import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'view/01_Front_page/view/splash_screen.dart';
import 'package:get/get.dart';

void main() async {
  WidgetsFlutterBinding
      .ensureInitialized(); //ensure that the Flutter engine is properly initialized before you run any code that depends on it
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  runApp(MyApp());
}

final routes = {
  '/': (BuildContext context) => SplashScreen(),
  '/login': (BuildContext context) => LoginPage(),
  '/register': (BuildContext context) => SignUpPage(),
  '/front_page': (BuildContext context) => SignInUpView(),
  '/home': (BuildContext context) => const MainScreen(),
};

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData(fontFamily: 'MontserratRegular'),
      routes: routes,
    );
  }
}

// import 'dart:ui' as ui;
// import 'package:flutter/material.dart';
// import 'package:flutter/rendering.dart';
// import 'package:flutter/services.dart';
// import 'package:image_gallery_saver/image_gallery_saver.dart';
//
// void main() {
//   runApp(MaterialApp(
//     home: TransparentPhotoGrid(),
//   ));
// }
//
// class TransparentPhotoGrid extends StatefulWidget {
//   @override
//   _TransparentPhotoGridState createState() => _TransparentPhotoGridState();
// }
//
// class _TransparentPhotoGridState extends State<TransparentPhotoGrid> {
//   final GlobalKey _globalKey = GlobalKey();
//   List<Uint8List?> imageList = List.filled(6, null);
//
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         title: Text("Transparent Photo Grid"),
//         actions: [
//           IconButton(
//             icon: Icon(Icons.save),
//             onPressed: _capturePng,
//           ),
//         ],
//       ),
//       body: Column(
//         children: [
//           Expanded(
//             child: Center(
//               child: RepaintBoundary(
//                 key: _globalKey,
//                 child: Container(
//                   padding: EdgeInsets.all(10),
//                   color: Colors.red, // Set the overall container background to visible (e.g., white)
//                   child: GridView.builder(
//                     shrinkWrap: true,
//                     gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
//                       crossAxisCount: 2,
//                       crossAxisSpacing: 10,
//                       mainAxisSpacing: 10,
//                     ),
//                     itemCount: 6,
//                     itemBuilder: (context, index) {
//                       return GestureDetector(
//                         onTap: () async {
//                           // Example: Load an image from assets on tap
//                           ByteData bytes = await rootBundle.load('assets/img.png');
//                           setState(() {
//                             imageList[index] = bytes.buffer.asUint8List();
//                           });
//                         },
//                         child: ColorFiltered(
//                           colorFilter: ColorFilter.mode(
//                             Colors.transparent,
//                             BlendMode.xor
//                           ),
//                           child: Container(
//                             decoration: BoxDecoration(
//                               border: Border.all(color: Colors.black, width: 2),
//                               color: Colors.transparent, // Make the box visible (e.g., white frame background)
//                             ),
//                             child: imageList[index] != null
//                                 ? Image.memory(imageList[index]!, fit: BoxFit.cover)
//                                 : Container(
//                               color: Colors.transparent, // Only the unfilled boxes will be transparent
//                             ),
//                           ),
//                         ),
//                       );
//                     },
//                   ),
//                 ),
//               ),
//             ),
//           ),
//           Padding(
//             padding: const EdgeInsets.all(8.0),
//             child: Text(
//               "Tap on any square to add a photo. When you save, unfilled squares will be transparent.",
//               textAlign: TextAlign.center,
//             ),
//           ),
//         ],
//       ),
//     );
//   }
//
//   Future<void> _capturePng() async {
//     try {
//       RenderRepaintBoundary boundary = _globalKey.currentContext!.findRenderObject() as RenderRepaintBoundary;
//       var image = await boundary.toImage(pixelRatio: 3.0);
//       ByteData? byteData = await image.toByteData(format: ui.ImageByteFormat.png);
//       if (byteData != null) {
//         final pngBytes = byteData.buffer.asUint8List();
//
//         // Save to the gallery using ImageGallerySaver
//         final result = await ImageGallerySaver.saveImage(pngBytes, quality: 100, name: "photo_grid");
//         print("Image saved to gallery: $result");
//       }
//     } catch (e) {
//       print("Error during export: $e");
//     }
//   }
// }

// import 'dart:ui' as ui;
// import 'package:flutter/material.dart';
// import 'package:flutter/rendering.dart';
// import 'package:flutter/services.dart';
// import 'package:image_gallery_saver/image_gallery_saver.dart';
//
// void main() {
//   runApp(MaterialApp(
//     home: TransparentPhotoGrid(),
//   ));
// }
//
// class TransparentPhotoGrid extends StatefulWidget {
//   @override
//   _TransparentPhotoGridState createState() => _TransparentPhotoGridState();
// }
//
// class _TransparentPhotoGridState extends State<TransparentPhotoGrid> {
//   final GlobalKey _globalKey = GlobalKey();
//   List<Uint8List?> imageList = List.filled(6, null);
//
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         title: Text("Transparent Photo Grid"),
//         actions: [
//           IconButton(
//             icon: Icon(Icons.save),
//             onPressed: _capturePng,
//           ),
//         ],
//       ),
//       body: Column(
//         children: [
//           Expanded(
//             child: Center(
//               child: RepaintBoundary(
//                 key: _globalKey,
//                 child: Stack(
//                   children: [
//                     // The transparent container will be rendered fully transparent
//                     Container(
//                       color: Colors.transparent, // Keep the background fully transparent
//                     ),
//                     // Photo Cutout Layout
//                     ClipPath(
//                       clipper: PhotoGridClipper(),
//                       child: Container(
//                         color: Colors.transparent, // Maintain transparency in the clip path
//                       ),
//                     ),
//                     // Photo Grid
//                     GridView.builder(
//                       shrinkWrap: true,
//                       physics: NeverScrollableScrollPhysics(),
//                       gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
//                         crossAxisCount: 2,
//                         crossAxisSpacing: 10,
//                         mainAxisSpacing: 10,
//                       ),
//                       itemCount: 6,
//                       itemBuilder: (context, index) {
//                         return GestureDetector(
//                           onTap: () async {
//                             // Load an image from assets on tap
//                             ByteData bytes = await rootBundle.load('assets/img.png');
//                             setState(() {
//                               imageList[index] = bytes.buffer.asUint8List();
//                             });
//                           },
//                           child: Container(
//                             decoration: BoxDecoration(
//                               border: Border.all(color: Colors.black, width: 2),
//                               color: Colors.transparent, // Keep the box itself transparent
//                             ),
//                             child: Stack(
//                               children: [
//                                 // Display the photo if available
//                                 if (imageList[index] != null)
//                                   Image.memory(
//                                     imageList[index]!,
//                                     fit: BoxFit.cover,
//                                   ),
//                                 // Create a transparent overlay for unfilled boxes
//                                 if (imageList[index] == null)
//                                   Container(
//                                     color: Colors.transparent, // Maintain transparency for unfilled
//                                   ),
//                               ],
//                             ),
//                           ),
//                         );
//                       },
//                     ),
//                   ],
//                 ),
//               ),
//             ),
//           ),
//           Padding(
//             padding: const EdgeInsets.all(8.0),
//             child: Text(
//               "Tap on any square to add a photo. When you save, unfilled squares will be transparent.",
//               textAlign: TextAlign.center,
//             ),
//           ),
//         ],
//       ),
//     );
//   }
//
//   Future<void> _capturePng() async {
//     try {
//       RenderRepaintBoundary boundary = _globalKey.currentContext!.findRenderObject() as RenderRepaintBoundary;
//       var image = await boundary.toImage(pixelRatio: 3.0);
//       ByteData? byteData = await image.toByteData(format: ui.ImageByteFormat.png);
//       if (byteData != null) {
//         final pngBytes = byteData.buffer.asUint8List();
//
//         // Save to the gallery using ImageGallerySaver
//         final result = await ImageGallerySaver.saveImage(pngBytes, quality: 100, name: "photo_grid");
//         print("Image saved to gallery: $result");
//       }
//     } catch (e) {
//       print("Error during export: $e");
//     }
//   }
// }
//
// class PhotoGridClipper extends CustomClipper<Path> {
//   @override
//   Path getClip(Size size) {
//     Path path = Path();
//     double boxWidth = size.width / 2;
//     double boxHeight = size.height / 3;
//
//     // Draw the outer rectangle
//     path.addRect(Rect.fromLTWH(0, 0, size.width, size.height));
//
//     // Create cutouts for the images
//     path.addRect(Rect.fromLTWH(0, 0, boxWidth, boxHeight)); // Top left
//     path.addRect(Rect.fromLTWH(boxWidth, 0, boxWidth, boxHeight)); // Top right
//     path.addRect(Rect.fromLTWH(0, boxHeight, boxWidth, boxHeight)); // Middle left
//     path.addRect(Rect.fromLTWH(boxWidth, boxHeight, boxWidth, boxHeight)); // Middle right
//     path.addRect(Rect.fromLTWH(0, boxHeight * 2, boxWidth, boxHeight)); // Bottom left
//     path.addRect(Rect.fromLTWH(boxWidth, boxHeight * 2, boxWidth, boxHeight)); // Bottom right
//
//     return Path.combine(PathOperation.difference, path, path);
//   }
//
//   @override
//   bool shouldReclip(CustomClipper<Path> oldClipper) => true;
// }

