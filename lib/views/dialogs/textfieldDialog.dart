import 'package:flutter/material.dart';
import 'package:tictactoe_client/views/utils.dart';

final textFieldDialog = (BuildContext context) => showDialog(
    context: context,
    builder: (context) {
      final controller = TextEditingController();
      return Dialog(
        child: Container(
          width: SCREEN_WIDTH * 0.95,
          height: SCREEN_HEIGHT * 0.4,
          child: Column(
            children: [
              SizedBox(
                height: SCREEN_HEIGHT * 0.1,
              ),
              Container(
                width: SCREEN_WIDTH * 0.8,
                child: TextField(
                  controller: controller,
                ),
              ),
              SizedBox(
                height: SCREEN_HEIGHT * 0.1,
              ),
              TextButton(
                  onPressed: () async {
                    Navigator.of(context).pop(controller.text);
                  },
                  child: const Text("Confirm"))
            ],
          ),
        ),
      );
    });
