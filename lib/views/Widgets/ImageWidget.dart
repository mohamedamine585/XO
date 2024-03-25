import 'dart:typed_data';

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:tictactoe_client/entities/Player.dart';
import 'package:tictactoe_client/repositories/MetaDataRepository.dart';

FutureBuilder<Uint8List?> Function(Player?, BuildContext) imageWidget =
    (Player? player, BuildContext generalcontext) {
  return FutureBuilder(
      future: (player?.photoBytes == null)
          ? MetaDataRepository.getImage(player: player)
          : null,
      builder: (context, snapshot) {
        if (snapshot.data != player?.photoBytes && snapshot.data != null) {
          generalcontext.read<PlayerState>().setPhoto(snapshot.data!);
        }
        return CircleAvatar(
          foregroundImage: (snapshot.connectionState == ConnectionState.done)
              ? (snapshot.data != player?.photoBytes && snapshot.data != null)
                  ? Image.memory(snapshot.data!).image
                  : const AssetImage("assets/images/man.png")
              : (player?.photoBytes != null)
                  ? Image.memory(player?.photoBytes ?? Uint8List(0)).image
                  : null,
          radius: 70,
        );
      });
};
