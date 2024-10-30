import 'dart:io';

import 'package:booth_bliss/view/09_Photobooth_Frame_Result_Page/controller/photo_result_controller.dart';
import 'package:booth_bliss/view/Utils/view_dialog_util.dart';
import 'package:flutter/material.dart';

class PhotoResult extends StatelessWidget {
  final File framePng;
  final String filename;

  const PhotoResult(
      {super.key, required this.framePng, required this.filename});

  @override
  Widget build(BuildContext context) {
    TextEditingController emailController = TextEditingController();
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        title: Center(child: Text('Photo Result')),
      ),
      body: Row(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: [
          Image.file(framePng),
          Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                IconButton(
                  iconSize: 100,
                  icon: Icon(Icons.email),
                  onPressed: () {
                    showDialog(
                      context: context,
                      builder: (context) => AlertDialog(
                        title: Text('Send Email'),
                        content: Column(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            Text('Enter your email:'),
                            SizedBox(height: 10),
                            TextField(
                              controller: emailController,
                              decoration: InputDecoration(
                                labelText: 'Email',
                                border: OutlineInputBorder(),
                              ),
                            ),
                          ],
                        ),
                        actions: [
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              TextButton(
                                onPressed: () {
                                  Navigator.of(context).pop();
                                },
                                child: Text('Close'),
                              ),
                              TextButton(
                                onPressed: () async {
                                  ViewDialogUtil().showLoadingDialog(context);
                                  await PhotoResultController().sendEmail(
                                      emailController.text, filename);
                                  WidgetsBinding.instance
                                      .addPostFrameCallback((_) {
                                    Navigator.of(context).pop();
                                    Navigator.of(context).pop();
                                  });
                                },
                                child: Text('Send'),
                              ),
                            ],
                          ),
                        ],
                      ),
                    );
                  },
                ),
                SizedBox(height: 20),
                IconButton(
                  iconSize: 100,
                  icon: Icon(Icons.qr_code),
                  onPressed: () {
                    showDialog(
                      context: context,
                      builder: (context) => AlertDialog(
                        title: Text('QR Code'),
                        content: Image.asset('assets/img.png'),
                        actions: [
                          TextButton(
                            onPressed: () {
                              Navigator.of(context).pop();
                            },
                            child: Text('Close'),
                          ),
                        ],
                      ),
                    );
                  },
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
