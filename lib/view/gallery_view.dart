import 'package:flutter/material.dart';
import 'package:mobile_scanner/mobile_scanner.dart';

class GalleryView extends StatelessWidget {
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
                            fontSize: 20, fontWeight: FontWeight.bold),
                      ),
                    ),
                  )
                ],
              ),
            )),
      ),
      body: Column(
        children: [
          Text('Scan QR Code to Save Photobooth Results'),
          MobileScanner()
        ],
      ),
    );
  }
}
