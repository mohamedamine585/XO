import 'dart:ffi';

import 'package:flutter/material.dart';
import 'package:tictactoe_client/views/utils.dart';

class VerifyEmailDialog extends StatefulWidget {
  const VerifyEmailDialog({super.key});

  @override
  State<VerifyEmailDialog> createState() => _VerifyEmailDialogState();
}

class _VerifyEmailDialogState extends State<VerifyEmailDialog> {
  TextEditingController codeController = TextEditingController();
  bool codeIn = false;
  @override
  Widget build(BuildContext context) {
    return Dialog(
      child: Container(
        height: SCREEN_HEIGHT * 0.5,
        width: SCREEN_WIDTH * 0.8,
        child: Column(
          children: [
            SizedBox(
              height: SCREEN_HEIGHT * 0.05,
            ),
            Container(
              width: SCREEN_WIDTH * 0.7,
              child:
                  Text("We sent to you a six digit code.\n Get it to confirm."),
            ),
            SizedBox(
              height: SCREEN_HEIGHT * 0.05,
            ),
            Container(
              width: SCREEN_WIDTH * 0.2,
              child: TextField(
                onChanged: (newValue) {
                  setState(() {
                    setState(() {
                      codeIn = codeController.text.length == 6;
                    });
                  });
                },
                controller: codeController,
                keyboardType: TextInputType.number,
                style: TextStyle(),
              ),
            ),
            SizedBox(
              height: SCREEN_HEIGHT * 0.1,
            ),
            Container(
              height: SCREEN_HEIGHT * 0.05,
              width: SCREEN_WIDTH * 0.5,
              child: OutlinedButton(
                statesController:
                    MaterialStatesController({MaterialState.disabled}),
                onPressed: (codeIn)
                    ? () async {
                        Navigator.of(context)
                            .pop(int.parse(codeController.text));
                      }
                    : null,
                child: Text(
                  "Verify Email",
                  style: TextStyle(color: Colors.white),
                ),
                style: OutlinedButton.styleFrom(
                    backgroundColor: (codeIn)
                        ? Color.fromARGB(255, 143, 25, 227)
                        : Color.fromARGB(255, 225, 186, 231),
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(5))),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
