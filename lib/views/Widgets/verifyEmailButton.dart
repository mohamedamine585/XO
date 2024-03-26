import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:tictactoe_client/views/utils.dart';

final verifyemailWidget = Container(
  height: SCREEN_HEIGHT * 0.25,
  width: SCREEN_WIDTH * 0.95,
  child: Card(
    color: Color.fromARGB(255, 239, 238, 238),
    child: Column(
      children: [
        Container(
          margin: EdgeInsets.only(
              left: SCREEN_WIDTH * 0.05, top: SCREEN_HEIGHT * 0.02),
          child: const Text(
              "Verify email to recover your account when you forget your password"),
        ),
        SizedBox(
          height: SCREEN_HEIGHT * 0.05,
        ),
        Container(
          width: SCREEN_WIDTH * 0.9,
          child: OutlinedButton(
            onPressed: () {},
            child: Text(
              "Verify Email",
              style: TextStyle(color: Colors.white),
            ),
            style: OutlinedButton.styleFrom(
                backgroundColor: Color.fromARGB(255, 143, 25, 227),
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(5))),
          ),
        ),
      ],
    ),
  ),
);
