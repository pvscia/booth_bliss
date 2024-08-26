import 'package:booth_bliss/view/sign_in_up_view.dart';
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class SignUpPage extends StatefulWidget {
  @override
  _SignUpPageState createState() => _SignUpPageState();
}

class _SignUpPageState extends State<SignUpPage> {
  final _formKey = GlobalKey<FormState>();
  bool _isPasswordVisible = false;
  bool _isFormFilled = false;
  String _passwordStrength = '';

  // Controllers to manage text field states
  final TextEditingController _firstNameController = TextEditingController();
  final TextEditingController _lastNameController = TextEditingController();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();

  @override
  void dispose() {
    // Clean up controllers
    _firstNameController.dispose();
    _lastNameController.dispose();
    _emailController.dispose();
    _passwordController.dispose();
    super.dispose();
  }

  void _checkFormFilled() {
    setState(() {
      _isFormFilled = _firstNameController.text.isNotEmpty &&
          _lastNameController.text.isNotEmpty &&
          _emailController.text.isNotEmpty &&
          _passwordController.text.isNotEmpty;
    });
  }

  void _updatePasswordStrength(String password) {
    if (password.length > 8) {
      _passwordStrength = 'excellent';
    } else {
      _passwordStrength = 'weak';
    }
  }

  Future<void> _addUserDataToFirestore() async {
    try {
      await FirebaseFirestore.instance.collection('users').add({
        'first_name': _firstNameController.text,
        'last_name': _lastNameController.text,
        'email': _emailController.text,
        'password': _passwordController.text, // In a real app, never store plain text passwords
        'created_at': FieldValue.serverTimestamp(),
      });
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('User data added successfully!')),
      );
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Failed to add user: $e')),
      );
    }
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
                controller: _firstNameController,
                decoration: InputDecoration(labelText: 'First name'),
                onChanged: (value) => _checkFormFilled(),
              ),
              TextFormField(
                controller: _lastNameController,
                decoration: InputDecoration(labelText: 'Last name'),
                onChanged: (value) => _checkFormFilled(),
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
                onChanged: (value) {
                  _checkFormFilled();
                  _updatePasswordStrength(value);
                },
              ),
              if (_passwordStrength.isNotEmpty)
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
                        'Password strength: $_passwordStrength',
                        style: TextStyle(color: Colors.green),
                      ),
                    ],
                  ),
                ),
              Spacer(),
              ElevatedButton(
                onPressed: _isFormFilled
                    ? () {
                        if (_formKey.currentState!.validate()) {
                          _addUserDataToFirestore();
                          Navigator.push(
                            context,
                            MaterialPageRoute(builder: (context) => SignInUpView()),
                          );
                        }
                      }
                    : null,
                child: Text('Agree and continue'),
                style: ElevatedButton.styleFrom(
                  backgroundColor: _isFormFilled ? Colors.pink : Colors.grey,
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
