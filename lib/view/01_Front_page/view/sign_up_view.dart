import 'package:booth_bliss/view/01_Front_page/controller/sign_up_controller.dart';
import 'package:flutter/material.dart';

class SignUpPage extends StatefulWidget {
  @override
  _SignUpPageState createState() => _SignUpPageState();
}

class _SignUpPageState extends State<SignUpPage> {
  final SignUpController _controller = SignUpController();
  final _formKey = GlobalKey<FormState>();

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
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
        backgroundColor: Color(0xFFF3FDE8),
        appBar: AppBar(
          centerTitle: true,
          title: Text('Sign up'),
          backgroundColor: Color(0xFFF3FDE8),
          elevation: 0,
        ),
        body: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Form(
            key: _formKey,
            child: Column(
              children: <Widget>[
                SizedBox(height: 30),
                TextFormField(
                  controller: _controller.firstNameController,
                  decoration: InputDecoration(
                    labelText: 'First Name',
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
                    ),
                  ),
                  onChanged: (value) {
                    setState(() {
                      _controller.checkFormFilled();
                    });
                  },
                ),
                SizedBox(height: 15),
                TextFormField(
                  controller: _controller.lastNameController,
                  decoration: InputDecoration(
                    labelText: 'Last Name',
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
                    ),
                  ),
                  onChanged: (value) {
                    setState(() {
                      _controller.checkFormFilled();
                    });
                  },
                ),
                SizedBox(height: 15),
                TextFormField(
                  controller: _controller.emailController,
                  decoration: InputDecoration(
                    labelText: 'Email',
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
                    ),
                  ),
                  onChanged: (value) {
                    setState(() {
                      _controller.checkFormFilled();
                    });
                  },
                ),
                SizedBox(height: 15),
                TextFormField(
                  controller: _controller.passwordController,
                  decoration: InputDecoration(
                    labelText: 'Password',
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
                    ),
                    suffixIcon: IconButton(
                      icon: Icon(
                        _controller.isPasswordVisible
                            ? Icons.visibility
                            : Icons.visibility_off,
                      ),
                      onPressed: () {
                        setState(() {
                          _controller.isPasswordVisible =
                              !_controller.isPasswordVisible;
                        });
                      },
                    ),
                  ),
                  obscureText: !_controller.isPasswordVisible,
                  onChanged: (value) {
                    setState(() {
                      _controller.checkFormFilled();
                      _controller.updatePasswordStrength(value);
                    });
                  },
                ),
                if (_controller.passwordStrength.isNotEmpty)
                  Padding(
                    padding: const EdgeInsets.symmetric(vertical: 8.0),
                    child: Row(
                      children: [
                        Icon(
                          Icons.check_circle,
                          color: Colors.green,
                        ),
                        SizedBox(width: 8.0),
                        Text(
                          'Password strength: ${_controller.passwordStrength}',
                          style: TextStyle(color: Colors.green),
                        ),
                      ],
                    ),
                  ),
                Spacer(),
                Text(
                  'By selecting Agree and continue, I agree to BoothBliss Terms of Service, Payments Terms of Service, and acknowledge the Privacy Policy.',
                  textAlign: TextAlign.center,
                  style: TextStyle(fontSize: 12.0),
                ),
                SizedBox(height: 15),
                ElevatedButton(
                  onPressed: _controller.isFormFilled
                      ? () async {
                          if (_formKey.currentState!.validate()) {
                            bool success = await _controller
                                .addUserDataToFirestore(context);
                            if (success) {
                              WidgetsBinding.instance.addPostFrameCallback((_) {
                                ScaffoldMessenger.of(context).showSnackBar(
                                  SnackBar(
                                      content: Text('Successfuly Sign Up')),
                                );
                                Navigator.of(context).pop();
                              });
                            }
                          }
                        }
                      : null,
                  style: ElevatedButton.styleFrom(
                      backgroundColor: _controller.isFormFilled
                          ? Color(0xFFFFAFCC)
                          : Colors.grey,
                      minimumSize: Size(300, 60),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10),
                      )),
                  child: Text(
                    'Agree and continue',
                    style: TextStyle(color: Colors.black),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
