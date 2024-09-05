import 'package:flutter/material.dart';
import 'package:mobile_scanner/mobile_scanner.dart';

class ScanQR extends StatefulWidget {
  @override
  State<ScanQR> createState() => _ScanQRState();
}

class _ScanQRState extends State<ScanQR> {
  bool isScanCompleted = false;

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
                onDetect: (barcode) {
                  if (!isScanCompleted) {
                    String code = barcode.toString(); // Use rawValue
                    setState(() {
                      isScanCompleted = true;
                    });
                    print(code);
                  }
                },
              ),
            ),
            Expanded(
              child: Container(
                child: Text('tes'),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
