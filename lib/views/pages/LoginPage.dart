import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:tictactoe_client/views/Widgets/TextFieldPassword.dart';
import 'package:tictactoe_client/views/Widgets/TictactoePassword.dart';

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
  bool _isLoading = false;
  Future<void> _handleLogin(String password) async {
    String email = _emailController.text;

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
                        SizedBox(height: SCREEN_HEIGHT * 0.05),

                        // Login Button
                        ElevatedButton(
                          style: ButtonStyle(
                              backgroundColor: MaterialStateColor.resolveWith(
                                  (states) =>
                                      Color.fromARGB(255, 153, 45, 193)),
                              shape: MaterialStateProperty.all(
                                  RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(10))),
                              fixedSize: MaterialStateProperty.all(Size(
                                  SCREEN_WIDTH * 0.5, SCREEN_HEIGHT * 0.05))),
                          onPressed: () async {
                            final password = await showDialog(
                                context: context,
                                builder: (context) {
                                  return const TextFieldPassword();
                                });
                            _handleLogin(password);
                          },
                          child: const Text(
                            "SigIn with password",
                            style: TextStyle(color: Colors.white),
                          ),
                        ),
                        SizedBox(
                          height: SCREEN_HEIGHT * 0.01,
                        ),
                        ElevatedButton(
                          style: ButtonStyle(
                              backgroundColor: MaterialStateColor.resolveWith(
                                  (states) =>
                                      Color.fromARGB(255, 193, 45, 136)),
                              shape: MaterialStateProperty.all(
                                  RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(10))),
                              fixedSize: MaterialStateProperty.all(Size(
                                  SCREEN_WIDTH * 0.5, SCREEN_HEIGHT * 0.05))),
                          onPressed: () async {
                            final newtoken = await showDialog(
                                context: context,
                                builder: (context) {
                                  return TictactoePasswordDialog(
                                    token: null,
                                    email: _emailController.text,
                                    onCreate: false,
                                  );
                                });
                            if (newtoken != null) {
                              (await SharedPreferences.getInstance())
                                  .setString("token", newtoken);

                              Navigator.of(context).pushNamedAndRemoveUntil(
                                  "home", (route) => false);
                            } else {
                              showAutherrorDialog(
                                  context, "Error", "Wrong tictactoe");
                            }
                          },
                          child: const Text(
                            "Sigin with tictactoe",
                            style: TextStyle(color: Colors.white),
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
