import 'package:booth_bliss/view/01_Front_page/forgot_password.dart';
import 'package:flutter/material.dart';
import 'package:booth_bliss/controller/login_controller.dart';
import '../main_screen_view.dart';
import 'package:booth_bliss/model/user_model.dart';

class LoginPage extends StatefulWidget {
  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final _formKey = GlobalKey<FormState>();
  bool _isPasswordVisible = false;
  bool _isFormFilled = false;
  String _loginError = '';

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
      UserModel? user = await _loginController.login(
        _emailController.text,
        _passwordController.text,
      );

      if (user != null) {
        // Clear previous error
        setState(() {
          _loginError = '';
        });

        // Navigate to HomeView
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Login successful!')),
        );
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(builder: (context) => MainScreen(user: user)),
        );
      } else {
        setState(() {
          _loginError = 'Invalid email or password';
        });
      }
    } catch (e) {
      setState(() {
        _loginError = 'An error occurred during login: $e';
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('I have an account'),
        backgroundColor: Colors.green[100],
        elevation: 0,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Form(
          key: _formKey,
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
              TextFormField(
                controller: _emailController,
                decoration: InputDecoration(labelText: 'Email'),
                onChanged: (value) => _checkFormFilled(),
              ),
              TextFormField(
                controller: _passwordController,
                decoration: InputDecoration(
                  labelText: 'Password',
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
              ElevatedButton(
                onPressed: _isFormFilled
                    ? () {
                        if (_formKey.currentState!.validate()) {
                          _login();
                        }
                      }
                    : null,
                child: Text('Login'),
                style: ElevatedButton.styleFrom(
                  backgroundColor: _isFormFilled ? Colors.pink : Colors.grey,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
