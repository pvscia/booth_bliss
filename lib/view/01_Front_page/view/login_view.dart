import 'package:booth_bliss/model/user_model.dart';
import 'package:booth_bliss/view/01_Front_page/controller/login_controller.dart';
import 'package:booth_bliss/view/01_Front_page/view/forgot_password.dart';
import 'package:flutter/material.dart';

import '../../Utils/view_dialog_util.dart';
import '../../bottom_nav_bar_view.dart';

class LoginPage extends StatefulWidget {
  @override
  LoginPageState createState() => LoginPageState();
}

class LoginPageState extends State<LoginPage> {
  bool _isPasswordVisible = false;
  bool _isFormFilled = false;
  String _loginError = '';
  bool isLoading = false;

  // Instantiate the controller
  final LoginController _loginController = LoginController();

  // Controllers to manage text field states
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();

  @override
  void dispose() {
    _emailController.dispose();
    _passwordController.dispose();

    super.dispose();
  }

  void _checkFormFilled() {
    setState(() {
      _isFormFilled = _emailController.text.isNotEmpty &&
          _passwordController.text.isNotEmpty;
    });
  }

  Future<void> _login() async {
    try {
      setState(() {
        isLoading = true;
      });
      UserModel? user = await _loginController.login(
        _emailController.text,
        _passwordController.text,
        context,
        setLoginError,
      );
      setState(() {
        isLoading = false;
      });

      if (user != null) {
        // Clear previous error
        setState(() {
          _loginError = '';
        });

        // Navigate to HomeView
        WidgetsBinding.instance.addPostFrameCallback((_) {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(content: Text('Login successful!')),
          );

          Navigator.of(context).pushReplacement(MaterialPageRoute(
            builder: (context) =>
                BottomNavBarMain(idx: 0), // The page you want to navigate to
          ));
        });
      }
    } catch (e) {
      setState(() {
        _loginError = 'An error occurred during login: $e';
      });
    }
  }

  void setLoginError(String str) {
    setState(() {
      _loginError = str;
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
          title: Text('Log in'),
          backgroundColor: Color(0xFFF3FDE8),
          elevation: 0,
        ),
        body: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            children: <Widget>[
              if (_loginError.isNotEmpty)
                Padding(
                  padding: const EdgeInsets.only(bottom: 8.0),
                  child: Text(
                    _loginError,
                    style: TextStyle(color: Colors.red),
                  ),
                ),
              SizedBox(height: 30),
              TextFormField(
                controller: _emailController,
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
                    )),
                onChanged: (value) => _checkFormFilled(),
              ),
              SizedBox(height: 15),
              TextFormField(
                controller: _passwordController,
                decoration: InputDecoration(
                  labelText: 'Password',
                  enabledBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(10), // Rounded corners
                    borderSide: BorderSide(
                      color:
                          Color(0xFF55CF00), // Outline color when not focused
                      width: 2, // Outline thickness
                    ),
                  ),
                  focusedBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(10), // Rounded corners
                    borderSide: BorderSide(
                      color: Color(0xFF55CF00), // Outline color when focused
                      width: 2, // Outline thickness
                    ),
                  ),
                  suffixIcon: IconButton(
                    icon: Icon(
                      _isPasswordVisible
                          ? Icons.visibility
                          : Icons.visibility_off,
                    ),
                    onPressed: () {
                      setState(() {
                        _isPasswordVisible = !_isPasswordVisible;
                      });
                    },
                  ),
                ),
                obscureText: !_isPasswordVisible,
                onChanged: (value) => _checkFormFilled(),
              ),
              Spacer(),
              TextButton(
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => ForgetPasswordPage()),
                  );
                },
                child: Text(
                  'Forgot password?',
                  style: TextStyle(color: Colors.pink),
                ),
              ),
              !isLoading
                  ? ElevatedButton(
                      onPressed: _isFormFilled
                          ? () async {
                              bool? isConnect =
                                  await ViewDialogUtil.checkConnection();
                              if (!isConnect) {
                                ViewDialogUtil()
                                    .showNoConnectionDialog(context, () {});
                                return;
                              }
                              FocusManager.instance.primaryFocus?.unfocus();
                              _login();
                            }
                          : null,
                      style: ElevatedButton.styleFrom(
                          backgroundColor:
                              _isFormFilled ? Color(0xFFFFAFCC) : Colors.grey,
                          minimumSize: Size(300, 60),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(10),
                          )),
                      child: Text(
                        'Login',
                        style: TextStyle(color: Colors.black),
                      ),
                    )
                  : Center(child: CircularProgressIndicator()),
            ],
          ),
        ),
      ),
    );
  }
}
