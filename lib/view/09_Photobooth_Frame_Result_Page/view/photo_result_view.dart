import 'dart:async';

import 'package:booth_bliss/view/07_Photobooth_Start_Page/start_view.dart';
import 'package:booth_bliss/view/09_Photobooth_Frame_Result_Page/controller/photo_result_controller.dart';
import 'package:booth_bliss/view/Utils/view_dialog_util.dart';
import 'package:flutter/material.dart';
import 'package:qr_flutter/qr_flutter.dart';

class PhotoResult extends StatefulWidget {
  final String filename;

  const PhotoResult({super.key, required this.filename});

  @override
  PhotoResultState createState() => PhotoResultState();
}

class PhotoResultState extends State<PhotoResult> {
  Timer? _idleTimer;
  TextEditingController emailController = TextEditingController();
  String photoUrl = '';

  @override
  void initState() {
    super.initState();
    initPhoto();
    _resetIdleTimer();
  }

  Future<void> initPhoto() async {
    var temp = await PhotoResultController().fetchPhotoURl(widget.filename);
    setState(() {
      photoUrl = temp ?? '';
    });
  }

  Future<void> _resetIdleTimer() async {
    setState(() {
      _idleTimer?.cancel();
      // Create a new timer that navigates after 2 minute (60 seconds)
      _idleTimer = Timer(Duration(minutes: 2), _navigateToOtherPage);
    });
    // Cancel the existing timer if any
  }

  void _navigateToOtherPage() {
    // Navigate to another page when idle
    Navigator.of(context).pushAndRemoveUntil(
      MaterialPageRoute(
        builder: (context) =>
            PhotoboothStartView(), // The page you want to navigate to
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
            photoUrl.isNotEmpty
                ? Image.network(photoUrl)
                : CircularProgressIndicator(),
            Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  IconButton(
                    iconSize: 100,
                    icon: Icon(Icons.email),
                    onPressed: () {
                      _resetIdleTimer();
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
                                    emailController.text ='';
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
                                      emailController.text ='';
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
                      _resetIdleTimer();
                      showDialog(
                        context: context,
                        builder: (context) => AlertDialog(
                          title: Text('QR Code'),
                          content: Center(
                            child: SizedBox(
                              width: 200.0, // Define the desired width
                              height: 200.0,
                              child: QrImageView(
                                data: widget.filename,
                                version: QrVersions.auto,
                              ),
                            ),
                          ),
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
