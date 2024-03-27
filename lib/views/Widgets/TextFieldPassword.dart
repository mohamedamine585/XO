import 'package:flutter/material.dart';
import 'package:tictactoe_client/views/utils.dart';

class TextFieldPassword extends StatefulWidget {
  const TextFieldPassword({super.key});

  @override
  State<TextFieldPassword> createState() => _TextFieldPasswordState();
}

class _TextFieldPasswordState extends State<TextFieldPassword> {
  TextEditingController _passwordController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Dialog(
      child: Padding(
        padding: EdgeInsets.all(SCREEN_WIDTH * 0.02),
        child: Container(
          height: SCREEN_HEIGHT * 0.4,
          child: Column(
            children: [
              SizedBox(
                height: SCREEN_HEIGHT * 0.05,
              ),
              Container(
                height: SCREEN_HEIGHT * 0.08,
                width: SCREEN_WIDTH * 0.9,
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
              SizedBox(
                height: SCREEN_HEIGHT * 0.1,
              ),
              ElevatedButton(
                style: ButtonStyle(
                    backgroundColor: MaterialStateColor.resolveWith(
                        (states) => Color.fromARGB(255, 193, 45, 136)),
                    shape: MaterialStateProperty.all(RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10))),
                    fixedSize: MaterialStateProperty.all(
                        Size(SCREEN_WIDTH * 0.65, SCREEN_HEIGHT * 0.05))),
                onPressed: () async {
                  Navigator.of(context).pop(_passwordController.text);
                },
                child: const Text(
                  "SignIn",
                  style: TextStyle(color: Colors.white),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
