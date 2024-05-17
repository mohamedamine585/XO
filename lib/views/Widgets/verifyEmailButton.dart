import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:tictactoe_client/entities/Player.dart';
import 'package:tictactoe_client/repositories/PlayerRepository.dart';
import 'package:tictactoe_client/views/ProviderSates/PlayerState.dart';
import 'package:tictactoe_client/views/dialogs/verifyemailDialog.dart';
import 'package:tictactoe_client/views/utils.dart';

final verifyemailWidget = (BuildContext context, Player? player) => Container(
      height: SCREEN_HEIGHT * 0.35,
      width: SCREEN_WIDTH * 0.95,
      child: Card(
        color: Color.fromARGB(255, 239, 238, 238),
        child: Column(
          children: [
            Container(
              height: SCREEN_HEIGHT * 0.2,
              margin: EdgeInsets.only(
                  left: SCREEN_WIDTH * 0.05, top: SCREEN_HEIGHT * 0.02),
              child: const Text(
                  "Verify email to recover your account when you forget your password"),
            ),
            SizedBox(
              height: SCREEN_HEIGHT * 0.05,
            ),
            Container(
              height: SCREEN_HEIGHT * 0.06,
              width: SCREEN_WIDTH * 0.9,
              child: OutlinedButton(
                onPressed: () async {
                  final sentCode = await playerRepository.askEmailVerification(
                      token: player?.token ?? "");
                  print(sentCode);
                  final typedCode = await showDialog(
                      context: context,
                      builder: (context) {
                        return VerifyEmailDialog();
                      }) as int?;
                  if (sentCode == typedCode) {
                    await playerRepository.verifyEmail(
                        token: player?.token ?? "");
                    context
                        .read<PlayerState>()
                        .setisEmailVerified(player, true);
                  }
                },
                child: Text(
                  "Verify Email",
                  style: TextStyle(color: Colors.white),
                ),
                style: OutlinedButton.styleFrom(
                    backgroundColor: Color.fromARGB(255, 156, 35, 196),
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(5))),
              ),
            ),
          ],
        ),
      ),
    );
