import 'dart:io';
import 'package:booth_bliss/view/04_QR_Page/controller/qr_controller.dart';
import 'package:booth_bliss/view/04_QR_Page/view/scan_result.dart';
import 'package:booth_bliss/view/Utils/view_dialog_util.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:image_picker/image_picker.dart';
import 'package:mobile_scanner/mobile_scanner.dart';
import 'package:google_mlkit_barcode_scanning/google_mlkit_barcode_scanning.dart';

class ScanQR extends StatefulWidget {
  const ScanQR({super.key});

  @override
  State<ScanQR> createState() => _ScanQRState();
}


class _ScanQRState extends State<ScanQR> {
  bool isScanCompleted = false;
  File? selectedImage;


  void closeScreen() {
    isScanCompleted = false;
  }

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;
    final screenHeight = MediaQuery.of(context).size.height;

    return Scaffold(
      backgroundColor: Color(0xffffe5e5), 
      appBar: PreferredSize(
        preferredSize: Size.fromHeight(120.0),
        child: SafeArea(
          child: LayoutBuilder(
            builder: (context, constraints) {
              return Container(
                  height: screenHeight * 0.1,
                  color: Color(0xffffe5e5),
                  child: Stack(
                    children: [
                      Center(
                        child: Text(
                          'SCAN QR',
                          style: TextStyle(
                            color: Colors.black,
                            fontWeight: FontWeight.bold,
                            fontSize: 20,
                          ),
                        ),
                      ),
                    ],
                  ),
              );
              },
            ),
          ),
      ),
      body: Container(
        color: Color(0xffffe5e5), 
        child: Column(
          children: [
            Expanded(
              flex: 4,
              child: Stack(
                children: [
                  SizedBox(
                    child: MobileScanner(
                      allowDuplicates: false,
                      onDetect: (barcode, args) async {
                        // if (!isScanCompleted) {
                        print(barcode.rawValue);
                          String code = barcode.rawValue ?? '---';
                          ViewDialogUtil().showLoadingDialog(context);
                          bool isSuccess =
                              await QRController().addPhotoToAccount(code);
                          WidgetsBinding.instance.addPostFrameCallback((_) {
                            Navigator.of(context).pop();
                            if (isSuccess) {
                              ViewDialogUtil().showOneButtonActionDialog(
                                  'Sucessfully save photo to your account',
                                  'Ok',
                                  'success.gif',
                                  context,
                                  () {});
                            }
                      });
                      },
                    ),
                  ),
                  CustomPaint(
                    size: Size.infinite,
                    painter: LShapePainter(),
                  ),

                  Align(
                    alignment: Alignment.bottomCenter,
                    child: Padding(
                      padding: const EdgeInsets.all(16.0), // Add padding as needed
                      child: Column(
                        mainAxisSize: MainAxisSize.min,
                        children: [ 
                          Container(
                            height: screenHeight * 0.06,
                            width: screenWidth * 0.5, // Set the desired width for the button
                            child: OutlinedButton(
                              onPressed: pickImageFromGallery,
                              style: OutlinedButton.styleFrom(
                                foregroundColor: Colors.black, 
                                backgroundColor: Color(0xffb7ed9e), // Text and icon color
                                side: BorderSide(color: Color(0xff50c400), width: 3), // Border color and width
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(10),
                                ),
                              ),
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.center, // Center content
                                mainAxisSize: MainAxisSize.min, // Minimize button width
                                children: [
                                  Icon(Icons.do_not_disturb_on_total_silence_sharp),
                                  SizedBox(width: screenWidth * 0.01), // Add some space between icon and text
                                  Text(
                                    'Take From Library',
                                    style: TextStyle(
                                      fontWeight: FontWeight.bold,
                                      fontSize: screenWidth * 0.03 // Make the text bold
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ),
                          selectedImage != null
                              ? Image.file(selectedImage!)
                              : Text(' ')
                      ],
                      )
                    ),
                  ),



                ],
              )
                      // Navigator.push(
                      //     context,
                      //     MaterialPageRoute(
                      //         builder: (context) => ScanResult(
                      //             closeScreen: closeScreen, code: code)));
                      // setState(() {
                      //   isScanCompleted = true;
                      // });
                    
                  // },

            ),
            
            Container(
              width: double.infinity,
              color: Color(0xffffe5e5), // Set the background color to green
              padding: EdgeInsets.all(screenWidth * 0.05),
              margin: EdgeInsets.symmetric(vertical: screenWidth * 0.03),
              child: Column(
                children: [
                  Text(
                    "Scan QR Code to save image",
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 18,
                      color: Colors.black, // White text color
                    ),
                  ),
                  SizedBox(height: 8), // Space between texts
                  Text(
                    "Place QR Code in the Area",
                    style: TextStyle(
                      color: Colors.black, // White text color
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Future pickImageFromGallery() async {
    final returnedImage =
        await ImagePicker().pickImage(source: ImageSource.gallery);

    if (returnedImage == null) return;

    setState(() {
      selectedImage = File(returnedImage.path);
    });

    final inputImage = InputImage.fromFilePath(returnedImage.path);
    final barcodeScanner =
        BarcodeScanner(); // Correct barcode scanner initialization

    try {
      final List barcodes =
          await barcodeScanner.processImage(inputImage); // Corrected processing

      if (barcodes.isNotEmpty) {
        final qrData = barcodes.first.rawValue;
        if (qrData != null) {
          setState(() {
            isScanCompleted = true;
          });

          Navigator.push(
              context,
              MaterialPageRoute(
                  builder: (context) =>
                      ScanResult(closeScreen: closeScreen, code: qrData)));
        } else {
          ScaffoldMessenger.of(context)
              .showSnackBar(SnackBar(content: Text('No QR Found')));
        }
      }
    } catch (e) {
      print("error decoding QR Code: $e");
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Failed to decode QR code from the image')),
      );
    } finally {
      barcodeScanner.close(); // Properly closing the barcode scanner
    }
  }
}

class LShapePainter extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()
      ..color = Colors.black
      ..style = PaintingStyle.stroke
      ..strokeWidth = 5;

    // Define the size and position of the "L" shapes
    double cornerSize = size.width * 0.1;
    double cornerSizeSmall = size.width * 0.05;
    double lineThickness = 5;

    if (size.width < 400) {
      // Top left corner
      //horizontal
      canvas.drawRect(Rect.fromLTWH(cornerSizeSmall * 3, cornerSizeSmall * 2, cornerSizeSmall * 1.5, lineThickness), paint);
      //vertical
      canvas.drawRect(Rect.fromLTWH(cornerSizeSmall * 3, cornerSizeSmall * 2.2, lineThickness, cornerSizeSmall * 1.5), paint);
    
      // Top right corner
      //horizontal
      canvas.drawRect(Rect.fromLTWH(size.width - (cornerSizeSmall * 4.5), cornerSizeSmall * 2, cornerSizeSmall * 1.5, lineThickness), paint);
      //vertical
      canvas.drawRect(Rect.fromLTWH(size.width - (cornerSizeSmall * 3.3), cornerSizeSmall * 2.2, lineThickness, cornerSizeSmall * 1.5), paint);

      // Bottom left corner
      //horizontal
      canvas.drawRect(Rect.fromLTWH(cornerSizeSmall * 3, cornerSizeSmall * 15, cornerSizeSmall * 1.5, lineThickness), paint);
      //vertical
      canvas.drawRect(Rect.fromLTWH(cornerSizeSmall * 3, cornerSizeSmall * 13.8, lineThickness, cornerSizeSmall * 1.5), paint);

      // Bottom right corner
      //horizontal
      canvas.drawRect(Rect.fromLTWH(cornerSizeSmall * 15.5, cornerSizeSmall * 15, cornerSizeSmall * 1.5, lineThickness), paint);
      //vertical
      canvas.drawRect(Rect.fromLTWH(cornerSizeSmall * 16.7, cornerSizeSmall * 13.8, lineThickness, cornerSizeSmall * 1.5), paint);
    }
    else {
    // Top left corner
    //horizontal
    canvas.drawRect(Rect.fromLTWH(cornerSize, cornerSize *2, cornerSize * 1.5, lineThickness), paint);
    //vertical
    canvas.drawRect(Rect.fromLTWH(cornerSize, cornerSize * 2.2, lineThickness, cornerSize * 1.5), paint);

    // Top right corner
    //horizontal
    canvas.drawRect(Rect.fromLTWH(size.width - (cornerSize * 2.49), cornerSize * 2, cornerSize * 1.5, lineThickness), paint);
    //vertical
    canvas.drawRect(Rect.fromLTWH(size.width - (cornerSize * 1.1), cornerSize * 2.2, lineThickness, cornerSize * 1.5), paint);

    // Bottom left corner
    //horizontal
    canvas.drawRect(Rect.fromLTWH(cornerSize, cornerSize * 10, cornerSize * 1.5, lineThickness), paint);
    //vertical
    canvas.drawRect(Rect.fromLTWH(cornerSize, cornerSize * 8.5, lineThickness, cornerSize * 1.5), paint);

    // Bottom right corner
    //horizontal
    canvas.drawRect(Rect.fromLTWH(cornerSize * 7.5, cornerSize * 10, cornerSize * 1.5, lineThickness), paint);
    //vertical
    canvas.drawRect(Rect.fromLTWH(cornerSize * 8.9, cornerSize * 8.5, lineThickness, cornerSize * 1.5), paint);
    }
  }

  @override
  bool shouldRepaint(CustomPainter oldDelegate) {
    return false; // No need to repaint unless the size changes
  }
}
