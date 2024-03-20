import 'package:flutter/material.dart';
import 'package:tictactoe_client/views/utils.dart';

Dialog generalD = Dialog(
    child: Container(
  height: SCREEN_HEIGHT * 0.5,
  width: SCREEN_WIDTH * 0.8,
  decoration:
      BoxDecoration(borderRadius: BorderRadius.all(Radius.circular(50))),
  child: Scaffold(
    backgroundColor: Color.fromARGB(255, 249, 240, 253),
    body: Column(
      children: [
        Container(
            margin: EdgeInsets.only(
                right: SCREEN_WIDTH * 0.45, top: SCREEN_HEIGHT * 0.05),
            child: const Text("Message")),
        Divider(
          color: Colors.black,
          thickness: 0.5,
        ),
      ],
    ),
  ),
));
