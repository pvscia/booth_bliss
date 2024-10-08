import 'package:flutter/material.dart';
import 'package:qr_flutter/qr_flutter.dart';

class ScanResult extends StatelessWidget {
  final String code;
  final Function() closeScreen;

  const ScanResult({super.key, required this.closeScreen, required this.code});

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
      body: Center(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            children: [
              Text(
                'Scanned Result',
                style: TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                ),
              ),
              SizedBox(
                height: 10,
              ),
              QrImageView(
                data: code,
                size: 150,
                version: QrVersions.auto,
              ),
              Image.network('https://qr.me-qr.com/data/image-pack/ZjPDvg7X'),
              Text(code),
              IconButton(
                  onPressed: () {
                    closeScreen();
                    Navigator.pop(context);
                  },
                  icon: Icon(Icons.settings))
            ],
          ),
        ),
      ),
    );
  }
}
