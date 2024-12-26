import 'package:booth_bliss/view/01_Front_page/controller/forgot_pass_controller.dart';
import 'package:flutter/material.dart';

import '../../Utils/view_dialog_util.dart';

class ForgetPasswordPage extends StatefulWidget {
  @override
  ForgetPasswordPageState createState() => ForgetPasswordPageState();
}

class ForgetPasswordPageState extends State<ForgetPasswordPage> {
  final ForgetPasswordController _controller = ForgetPasswordController();
  bool isLoading = false;
  String statusMessage = '';

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  void _handlePasswordReset() async {
    bool? isConnect = await ViewDialogUtil.checkConnection();
    if (!isConnect) {
      ViewDialogUtil().showNoConnectionDialog(context, () {});
      return;
    }
    setState(() {
      isLoading = true;
      statusMessage = ''; // Clear previous status messages
    });

    String result = await _controller.sendPasswordResetEmail();

    setState(() {
      isLoading = false;
      if (result == 'success') {
        statusMessage =
            'An email has been sent to ${_controller.emailController.text}';
      } else {
        statusMessage = result; // Display the error message
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return PopScope(
      canPop: false,
      onPopInvokedWithResult: (bool didPop, Object? result) {
        if (didPop) {
          return;
        }
        Navigator.pop(context);
      },
      child: Scaffold(
        resizeToAvoidBottomInset: false,
        backgroundColor: Color(0xFFF3FDE8),
        appBar: AppBar(
          centerTitle: true,
          title: Text("Change Password"),
          backgroundColor: Color(0xFFF3FDE8),
          elevation: 0,
        ),
        body: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SizedBox(height: 30),
              TextFormField(
                controller: _controller.emailController,
                decoration: InputDecoration(
                    labelText: "Email",
                    errorText: _controller.emailError.isNotEmpty
                        ? _controller.emailError
                        : null,
                    enabledBorder: OutlineInputBorder(
                      borderRadius:
                          BorderRadius.circular(10), // Rounded corners
                      borderSide: BorderSide(
                        color:
                            Color(0xFF55CF00), // Outline color when not focused
                        width: 2, // Outline thickness
                      ),
                    ),
                    focusedBorder: OutlineInputBorder(
                      borderRadius:
                          BorderRadius.circular(10), // Rounded corners
                      borderSide: BorderSide(
                        color: Color(0xFF55CF00), // Outline color when focused
                        width: 2, // Outline thickness
                      ),
                    )),
                onChanged: (value) {
                  setState(() {
                    _controller.validateEmail();
                  });
                },
              ),
              SizedBox(height: 15),
              Text(
                "Enter the email address you used to register with BoothBliss. You will receive an email to define a new password.",
                style: TextStyle(fontSize: 12),
              ),
              Spacer(),
              if (statusMessage.isNotEmpty)
                Padding(
                  padding: const EdgeInsets.only(bottom: 16.0),
                  child: Text(
                    statusMessage,
                    style: TextStyle(
                        color: statusMessage.contains('success')
                            ? Colors.green
                            : Colors.red),
                  ),
                ),
              Center(
                child: ElevatedButton(
                  onPressed: _controller.isButtonEnabled && !isLoading
                      ? _handlePasswordReset
                      : null,
                  style: ElevatedButton.styleFrom(
                      backgroundColor: _controller.isButtonEnabled
                          ? Color(0xFFFFAFCC)
                          : Colors.grey,
                      minimumSize: Size(300, 60),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10),
                      )),
                  child: Text(
                    'Define New Password',
                    style: TextStyle(color: Colors.black),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
