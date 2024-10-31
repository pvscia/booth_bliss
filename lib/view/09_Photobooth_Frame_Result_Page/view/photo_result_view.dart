import 'dart:async';
import 'dart:io';

import 'package:booth_bliss/view/07_Photobooth_Start_Page/start_view.dart';
import 'package:booth_bliss/view/09_Photobooth_Frame_Result_Page/controller/photo_result_controller.dart';
import 'package:booth_bliss/view/Utils/view_dialog_util.dart';
import 'package:flutter/material.dart';

class PhotoResult extends StatefulWidget {
  final File framePng;
  final String filename;

  const PhotoResult(
      {super.key, required this.framePng, required this.filename});

  @override
  PhotoResultState createState() => PhotoResultState();
}

class PhotoResultState extends State<PhotoResult> {
  Timer? _idleTimer;
  TextEditingController emailController = TextEditingController();
  @override
  void initState() {
    super.initState();
    _resetIdleTimer();
  }

  void _resetIdleTimer() {
    setState(() {
      _idleTimer?.cancel();
      // Create a new timer that navigates after 1 minute (60 seconds)
      _idleTimer = Timer(Duration(minutes: 1), _navigateToOtherPage);
    });
    // Cancel the existing timer if any
  }

  void _navigateToOtherPage() {
    // Navigate to another page when idle
    Navigator.of(context).pushAndRemoveUntil(
      MaterialPageRoute(
        builder: (context) => PhotoboothStartView(), // The page you want to navigate to
      ),
          (Route<dynamic> route) => false, // This removes all the previous routes
    );
  }
  
  @override
  void dispose() {
    _idleTimer?.cancel(); // Cancel the timer when the page is disposed
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: _resetIdleTimer,
      onPanUpdate: (_) => _resetIdleTimer(),
      child: Scaffold(
        appBar: AppBar(
          automaticallyImplyLeading: false,
          title: Center(child: Text('Photo Result')),
        ),
        body: Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            Image.file(widget.framePng),
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
                                        emailController.text, widget.filename);
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
      ),
    );
  }
}
