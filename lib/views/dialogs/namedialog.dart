import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:tictactoe_client/entities/Player.dart';
import 'package:tictactoe_client/views/utils.dart';
import 'package:tictactoe_client/repositories/PlayerRepository.dart';

class NameDialog extends StatefulWidget {
  Player? player;
  NameDialog(this.player);
  @override
  _NameDialogState createState() => _NameDialogState();
}

class _NameDialogState extends State<NameDialog> {
  TextEditingController namecontroller = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Dialog(
      child: Container(
        height: SCREEN_HEIGHT * 0.3,
        width: SCREEN_WIDTH * 0.8,
        child: Column(
          children: [
            SizedBox(
              height: SCREEN_HEIGHT * 0.05,
            ),
            Container(
              height: SCREEN_HEIGHT * 0.1,
              width: SCREEN_WIDTH * 0.75,
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(10),
                  border: Border.all(color: Colors.black)),
              child: TextField(
                controller: namecontroller,
                decoration: InputDecoration(
                  labelText: 'Your name',
                ),
              ),
            ),
            SizedBox(
              height: SCREEN_HEIGHT * 0.05,
            ),
            Container(
                width: SCREEN_WIDTH * 0.7,
                child: ElevatedButton(
                    onPressed: () async {
                      final prefs = await SharedPreferences.getInstance();
                      final token = prefs.getString("token");
                      if (token != null) {
                        final response = await playerRepository.setName(
                            player: widget.player,
                            playername: namecontroller.text);
                        if (response?.isNotEmpty ?? false) {
                          Navigator.of(context).pop(namecontroller.text);
                        }
                      } else {
                        Navigator.of(context).pop(null);
                      }
                    },
                    child: const Text("done")))
          ],
        ),
      ),
    );
  }
}
