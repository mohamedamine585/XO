import 'package:flutter/material.dart';

showAutherrorDialog(BuildContext context, String title, String text) {
  showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: Text(title),
          content: Text(text),
          actions: [
            TextButton(
                onPressed: () {
                  Navigator.of(context).pop();
                },
                child: const Text("Got it"))
          ],
        );
      });
}
