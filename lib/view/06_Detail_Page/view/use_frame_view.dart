import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:qr_flutter/qr_flutter.dart';

class UseFrameView extends StatelessWidget {
  final String filename;

  const UseFrameView({super.key, required this.filename});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Center(child: Text('Show QR to Photobooth')),
      ),
      body: Padding(
        padding: const EdgeInsets.all(50.0),
        child: Row(
          children: [
            Expanded(
              child: QrImageView(
                data: filename,
                version: QrVersions.auto,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
