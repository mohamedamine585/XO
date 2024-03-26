import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'package:tictactoe_client/views/dialogs/autherrordialog.dart';
import 'package:tictactoe_client/views/utils.dart';
import 'package:tictactoe_client/repositories/PlayerRepository.dart';

class LoginPage extends StatefulWidget {
  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  // TextEditingController for handling text input
  TextEditingController _emailController = TextEditingController();
  TextEditingController _passwordController = TextEditingController();
  bool _isLoading = false;
  Future<void> _handleLogin() async {
    String email = _emailController.text;
    String password = _passwordController.text;

    setState(() {
      _isLoading = true;
    });

    final token =
        await playerRepository.signIn(email: email, password: password);
    setState(() {
      _isLoading = false;
    });

    if (token != null) {
      (await SharedPreferences.getInstance()).setString("token", token);

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
      body: (_isLoading)
          ? Center(child: CircularProgressIndicator())
          : Padding(
              padding: EdgeInsets.all(16.0),
              child: SingleChildScrollView(
                child: Column(
                  children: [
                    SizedBox(
                      height: SCREEN_HEIGHT * 0.1,
                    ),
                    Container(
                      height: SCREEN_HEIGHT * 0.2,
                      width: SCREEN_WIDTH * 0.3,
                      margin: (_isLoading)
                          ? EdgeInsets.only(left: SCREEN_WIDTH * 0.2)
                          : EdgeInsets.only(bottom: SCREEN_HEIGHT * 0.1),
                      child: Image.asset("assets/images/logo.png"),
                    ),
                    Column(
                      children: [
                        Container(
                          height: SCREEN_HEIGHT * 0.08,
                          decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(10),
                              border: Border.all(color: Colors.black)),
                          child: TextField(
                            controller: _emailController,
                            decoration: InputDecoration(
                              labelText: 'Email',
                            ),
                          ),
                        ),
                        SizedBox(height: 16.0),

                        Container(
                          height: SCREEN_HEIGHT * 0.08,
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
                              fixedSize: MaterialStateProperty.all(Size(
                                  SCREEN_WIDTH * 0.5, SCREEN_HEIGHT * 0.05))),
                          onPressed: _handleLogin,
                          child: Text(
                            "Let's Conquer",
                            style: TextStyle(
                                color: Color.fromARGB(255, 15, 5, 118)),
                          ),
                        ),
                        SizedBox(
                          height: SCREEN_HEIGHT * 0.01,
                        ),
                        GestureDetector(
                          onTap: () {
                            setState(() {
                              _isLoading = true;
                            });
                            Navigator.of(context).pushNamedAndRemoveUntil(
                                "signup", (route) => false);
                          },
                          child: Container(
                            child: Text("Don't have an account",
                                style: Theme.of(context).textTheme.bodySmall),
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ),
    );
  }
}
