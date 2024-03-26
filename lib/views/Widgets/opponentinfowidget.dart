import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:tictactoe_client/entities/Player.dart';
import 'package:tictactoe_client/repositories/PlayerRepository.dart';

FutureBuilder<Player?> Function(String?, String) opponentinfoWidget =
    (String? id, String token) {
  return FutureBuilder<Player?>(
      future: (id != null) ? playerRepository.getPlayerById(id: id) : null,
      builder: (context, snapshot) {
        return Text(
            (snapshot.hasData) ? snapshot.data?.playername ?? "" : "Guess Who");
      });
};
