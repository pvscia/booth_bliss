import 'dart:io';
import 'package:booth_bliss/view/05_QR_Page/scan_result.dart';
import 'package:flutter/material.dart';
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
    return Scaffold(
      appBar: PreferredSize(
        preferredSize: Size.fromHeight(120.0),
        child: Container(
          color: Colors.green[100],
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16),
            child: Column(
              children: [
                Padding(
                  padding: const EdgeInsets.symmetric(vertical: 30),
                  child: Align(
                    alignment: Alignment.centerLeft,
                    child: Text(
                      'Scan QR',
                      style: TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                )
              ],
            ),
          ),
        ),
      ),
      body: Container(
        padding: EdgeInsets.all(16),
        child: Column(
          children: [
            Expanded(
              child: Column(
                children: [
                  SizedBox(height: 19),
                  Text(
                    "Scan QR Code to save image",
                    style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18),
                  ),
                  Text("Place QR Code in the Area")
                ],
              ),
            ),
            Expanded(
              flex: 4,
              child: MobileScanner(
                allowDuplicates: false,
                onDetect: (barcode, args) {
                  if (!isScanCompleted) {
                    String code = barcode.rawValue ?? '---';

                    isScanCompleted = true;

                    Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => ScanResult(
                                closeScreen: closeScreen, code: code)));
                  }
                },
              ),
            ),
            Expanded(
              child: Container(
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    SizedBox(
                      width: 200,
                      child: ElevatedButton(
                        onPressed: pickImageFromGallery,
                        child: Row(children: [
                          Icon(Icons.do_not_disturb_on_total_silence_sharp),
                          Text('Take From Library')
                        ]),
                      ),
                    ),
                    selectedImage != null
                        ? Image.file(selectedImage!)
                        : Text(' ')
                  ],
                ),
              ),
            )
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
