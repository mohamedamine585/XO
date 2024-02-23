import 'package:flutter/material.dart';
import 'package:tictactoe_client/data/cachedData.dart';
import 'package:tictactoe_client/entities/User.dart';
import 'package:tictactoe_client/presentation/dialogs/autherrordialog.dart';
import 'package:tictactoe_client/presentation/pages/PlayRoom.dart';
import 'package:tictactoe_client/presentation/utils.dart';
import 'package:tictactoe_client/repositories/UserRepository.dart';

class LoginPage extends StatefulWidget {
  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  // TextEditingController for handling text input
  TextEditingController _emailController = TextEditingController();
  TextEditingController _passwordController = TextEditingController();

  Future<void> _handleLogin() async {
    String email = _emailController.text;
    String password = _passwordController.text;

    await UserRepository.signIn(email: email, password: password);
    if (user.token != null) {
      Navigator.of(context).pushNamedAndRemoveUntil("home", (route) => false);
    } else {
      showAutherrorDialog(
          context, "Signin error", "Please check your credentials");
    }
    // For simplicity, this example just prints the entered email and password
    print('Email: $email, Password: $password');
  }

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
                  controller: _emailController,
                  decoration: InputDecoration(
                    labelText: 'Email',
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
                onPressed: _handleLogin,
                child: Text(
                  "Let's Conquer",
                  style: TextStyle(color: Color.fromARGB(255, 15, 5, 118)),
                ),
              ),
              SizedBox(
                height: SCREEN_HEIGHT * 0.01,
              ),
              GestureDetector(
                onTap: () {
                  Navigator.of(context)
                      .pushNamedAndRemoveUntil("signup", (route) => false);
                },
                child: Container(
                  child: Text(
                    "Do not have an account ?",
                    style: TextStyle(color: Color.fromARGB(255, 15, 5, 118)),
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
