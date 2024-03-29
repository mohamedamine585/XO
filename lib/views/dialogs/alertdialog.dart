import 'package:flutter/material.dart';
import 'package:tictactoe_client/views/utils.dart';

AlertDialog Function(BuildContext) alertdialog =
    (BuildContext context) => AlertDialog(
          content: Container(
            height: SCREEN_HEIGHT * 0.2,
            child: Column(
              children: [
                SizedBox(
                  height: SCREEN_HEIGHT * 0.1,
                ),
                Text("Wanna delete account ?"),
              ],
            ),
          ),
          actions: [
            Container(
                margin: EdgeInsets.only(right: SCREEN_WIDTH * 0.2),
                child: TextButton(
                    onPressed: () {
                      Navigator.of(context).pop(true);
                    },
                    child: const Text("yes"))),
            TextButton(
                onPressed: () {
                  Navigator.of(context).pop(true);
                },
                child: const Text("no"))
          ],
        );
