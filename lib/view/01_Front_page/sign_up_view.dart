import 'package:booth_bliss/controller/sign_up_controller.dart';
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
    return Scaffold(
      appBar: AppBar(
        title: Text('Sign up'),
        backgroundColor: Colors.green[100],
        elevation: 0,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Form(
          key: _formKey,
          child: Column(
            children: <Widget>[
              TextFormField(
                controller: _controller.firstNameController,
                decoration: InputDecoration(labelText: 'First name'),
                onChanged: (value) {
                  setState(() {
                    _controller.checkFormFilled();
                  });
                },
              ),
              TextFormField(
                controller: _controller.lastNameController,
                decoration: InputDecoration(labelText: 'Last name'),
                onChanged: (value) {
                  setState(() {
                    _controller.checkFormFilled();
                  });
                },
              ),
              TextFormField(
                controller: _controller.emailController,
                decoration: InputDecoration(labelText: 'Email'),
                onChanged: (value) {
                  setState(() {
                    _controller.checkFormFilled();
                  });
                },
              ),
              TextFormField(
                controller: _controller.passwordController,
                decoration: InputDecoration(
                  labelText: 'Password',
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
              ElevatedButton(
                onPressed: _controller.isFormFilled
                    ? () async {
                        if (_formKey.currentState!.validate()) {
                          bool success =
                              await _controller.addUserDataToFirestore(context);
                          if (success) {
                            ScaffoldMessenger.of(context).showSnackBar(
                              SnackBar(content: Text('Successfuly Sign Up')),
                            );
                            Navigator.of(context).pop();
                          }
                        }
                      }
                    : null,
                child: Text('Agree and continue'),
                style: ElevatedButton.styleFrom(
                  backgroundColor:
                      _controller.isFormFilled ? Colors.pink : Colors.grey,
                ),
              ),
              Text(
                'By selecting Agree and continue, I agree to BoothBliss Terms of Service, Payments Terms of Service, and acknowledge the Privacy Policy.',
                textAlign: TextAlign.center,
                style: TextStyle(fontSize: 12.0),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
