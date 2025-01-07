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

  @override
  void dispose(){
    super.dispose();
    emailController.dispose();
    _idleTimer?.cancel();
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
      _idleTimer = Timer(Duration(minutes: 5), _navigateToOtherPage);
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
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: _resetIdleTimer,
      onPanUpdate: (_) => _resetIdleTimer(),
      child: Scaffold(
        appBar: AppBar(
          backgroundColor: Color(0xFFF3FDE8),
          automaticallyImplyLeading: false,
          title: Center(child: Text('Save Photo')),
        ),
        body: Container(
          decoration: BoxDecoration(color: Color(0xFFF3FDE8)),
          padding: EdgeInsets.all(30),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              Expanded(
                flex: 1,
                child: photoUrl.isNotEmpty
                    ? Center(
                        child: Container(
                          padding: EdgeInsets.all(15),
                          decoration: BoxDecoration(
                            color: Color(0xFFFFF0F5),
                            borderRadius: BorderRadius.circular(10),
                          ),
                          child: Image.network(photoUrl),
                        ),
                      )
                    : Center(
                        child: CircularProgressIndicator(),
                      ),
              ),
              Expanded(
                flex: 1,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Row(
                      children: [
                        Text(
                          "Email: ",
                          style: TextStyle(
                              fontWeight: FontWeight.bold, fontSize: 20),
                        ),
                        SizedBox(
                          width: 10,
                        ),
                        Expanded(
                          child: TextField(
                            controller: emailController,
                            decoration: InputDecoration(
                              labelText: 'Email',
                              border: OutlineInputBorder(),
                            ),
                          ),
                        ),
                        SizedBox(
                          width: 10,
                        ),
                        ElevatedButton(
                          onPressed: () async {
                            ViewDialogUtil().showLoadingDialog(context);
                            await PhotoResultController().sendEmail(
                                emailController.text, widget.filename);
                            WidgetsBinding.instance.addPostFrameCallback((_) {
                              Navigator.of(context).pop();
                              Navigator.of(context).pop();
                              emailController.text = '';
                            });
                          },
                          style: ElevatedButton.styleFrom(
                              minimumSize: Size(300, 60),
                              backgroundColor: Color(0xFFFFF0F5),
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(10),
                              )),
                          child: Text(
                            'Send',
                            style: TextStyle(color: Colors.black, fontSize: 20),
                          ),
                        )
                      ],
                    ),
                    SizedBox(
                      height: 30,
                    ),
                    QrImageView(
                      size: MediaQuery.of(context).size.height * 0.4,
                      data: widget.filename,
                      version: QrVersions.auto,
                    ),
                    Text(
                      "Save to App?",
                      style: TextStyle(fontSize: 25),
                    ),
                    Text(
                      "Scan QR using our app!",
                      style: TextStyle(fontSize: 20),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
