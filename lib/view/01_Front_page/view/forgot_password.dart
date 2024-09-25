import 'package:booth_bliss/controller/forgot_pass_controller.dart';
import 'package:flutter/material.dart';

class ForgetPasswordPage extends StatefulWidget {
  @override
  _ForgetPasswordPageState createState() => _ForgetPasswordPageState();
}

class _ForgetPasswordPageState extends State<ForgetPasswordPage> {
  final ForgetPasswordController _controller = ForgetPasswordController();
  bool isLoading = false;
  String statusMessage = '';

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  void _handlePasswordReset() async {
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
    return Scaffold(
      appBar: AppBar(
        title: Text("I have an account"),
        backgroundColor: Colors.green[100],
        elevation: 0,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            TextFormField(
              controller: _controller.emailController,
              decoration: InputDecoration(
                labelText: "Email",
                errorText: _controller.emailError.isNotEmpty
                    ? _controller.emailError
                    : null,
              ),
              onChanged: (value) {
                setState(() {
                  _controller.validateEmail();
                });
              },
            ),
            SizedBox(height: 8),
            Text(
              "Enter the email address you used to register with BoothBliss. You will receive an email to define a new password.",
              style: TextStyle(fontSize: 12),
            ),
            SizedBox(height: 24),
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
            ElevatedButton(
              onPressed: _controller.isButtonEnabled && !isLoading
                  ? _handlePasswordReset
                  : null,
              style: ElevatedButton.styleFrom(
                backgroundColor:
                    _controller.isButtonEnabled ? Colors.pink : Colors.grey,
              ),
              child: isLoading
                  ? CircularProgressIndicator(
                      valueColor: AlwaysStoppedAnimation<Color>(Colors.white),
                    )
                  : Text("Define new password"),
            ),
          ],
        ),
      ),
    );
  }
}
