import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:tictactoe_client/entities/Player.dart';
import 'package:tictactoe_client/views/dialogs/autherrordialog.dart';
import 'package:tictactoe_client/views/utils.dart';
import 'package:tictactoe_client/repositories/PlayerRepository.dart';

class SignupPage extends StatefulWidget {
  @override
  _SignupPageState createState() => _SignupPageState();
}

class _SignupPageState extends State<SignupPage> {
  // TextEditingController for handling text input
  TextEditingController _emailController = TextEditingController();
  TextEditingController _passwordController = TextEditingController();

  // Regular expression for email validation
  RegExp _emailRegExp = RegExp(
    r'^[a-zA-Z0-9_.+-]+@[a-zA-Z0-9-]+\.[a-zA-Z0-9-.]+$',
  );

  // Validation error message
  String? _emailErrorMessage;

  // Function to validate email
  bool _isEmailValid(String email) {
    return _emailRegExp.hasMatch(email);
  }

  // Function to handle login button press
  Future<void> _handleSignup() async {
    String email = _emailController.text;
    String password = _passwordController.text;

    // Perform email validation
    if (!_isEmailValid(email)) {
      setState(() {
        _emailErrorMessage = 'Enter a valid email address';
      });
      return;
    }

    // Clear any previous error message
    setState(() {
      _emailErrorMessage = null;
    });

    final token =
        await playerRepository.signUp(email: email, password: password);
    if (token != null) {
      Navigator.of(context).pushNamedAndRemoveUntil("router", (route) => false);
    } else {
      showAutherrorDialog(context, "Signup error", "Cannot sign you up");
    }
    // For simplicity, this example just prints the entered email and password
    print('Email: $email, Password: $password');
  }

  bool emailbred = false;

  @override
  Widget build(BuildContext context) {
    SCREEN_HEIGHT = MediaQuery.of(context).size.height;
    SCREEN_WIDTH = MediaQuery.of(context).size.width;

    return Scaffold(
      body: Padding(
        padding: EdgeInsets.all(16.0),
        child: SingleChildScrollView(
          child: Column(
            children: [
              SizedBox(
                height: SCREEN_HEIGHT * 0.1,
              ),
              Container(
                child: Image.asset("assets/images/logo.png"),
              ),
              Container(
                height: SCREEN_HEIGHT * 0.07,
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(10),
                    border: Border.all(color: Colors.black)),
                // Email TextField with error handling
                child: TextField(
                  onChanged: (text) {
                    if (!_isEmailValid(text)) {
                      setState(() {
                        emailbred = true;
                      });
                    }
                  },
                  controller: _emailController,
                  decoration: InputDecoration(
                    border: OutlineInputBorder(
                        borderSide: BorderSide(
                            color: emailbred ? Colors.red : Colors.grey)),
                    labelText: 'Email',
                    errorText: _emailErrorMessage,
                  ),
                ),
              ),
              SizedBox(height: 16.0),

              // Password TextField
              Container(
                height: SCREEN_HEIGHT * 0.07,
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(10),
                    border: Border.all(color: Colors.black)),
                child: TextField(
                  controller: _passwordController,
                  decoration: InputDecoration(
                    labelText: 'Password',
                  ),
                  obscureText: true, // Hide the entered text
                ),
              ),
              SizedBox(height: 32.0),

              // Login Button
              ElevatedButton(
                style: ButtonStyle(
                    fixedSize: MaterialStateProperty.all(
                        Size(SCREEN_WIDTH * 0.5, SCREEN_HEIGHT * 0.05))),
                onPressed: _handleSignup,
                child: Text(
                  "Let's play",
                  style: TextStyle(color: Color.fromARGB(255, 15, 5, 118)),
                ),
              ),
              SizedBox(
                height: SCREEN_HEIGHT * 0.01,
              ),
              GestureDetector(
                onTap: () {
                  Navigator.of(context)
                      .pushNamedAndRemoveUntil("signin", (route) => false);
                },
                child: Container(
                  child: Text("Already have an account ?",
                      style: Theme.of(context).textTheme.bodySmall),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
