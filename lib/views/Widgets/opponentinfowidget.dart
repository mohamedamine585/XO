import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:tictactoe_client/entities/Player.dart';
import 'package:tictactoe_client/repositories/PlayerRepository.dart';
import 'package:tictactoe_client/views/utils.dart';

FutureBuilder<Player?> Function(String?, String) opponentinfoWidget =
    (String? id, String token) {
  return FutureBuilder<Player?>(
      future: (id != null) ? playerRepository.getPlayerById(id: id) : null,
      builder: (context, snapshot) {
        return Container(
          width: SCREEN_WIDTH * 0.2,
          child: Center(
            child: Text(
              (snapshot.hasData) ? snapshot.data?.playername ?? "" : "...",
              overflow: TextOverflow.ellipsis,
              style: const TextStyle(fontSize: 15),
            ),
          ),
        );
      });
};
