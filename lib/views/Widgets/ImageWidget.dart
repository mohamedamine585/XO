import 'dart:typed_data';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:tictactoe_client/entities/Player.dart';
import 'package:tictactoe_client/repositories/MetaDataRepository.dart';

FutureBuilder<Uint8List?> Function(Player?) imageWidget = (Player? player) {
  return FutureBuilder(
      future: (player?.token != null)
          ? MetaDataRepository.getImage(player: player)
          : null,
      builder: (context, snapshot) {
        return CircleAvatar(
          foregroundImage: (snapshot.data != null)
              ? Image.memory(snapshot.data!).image
              : null,
          radius: 70,
        );
      });
};
