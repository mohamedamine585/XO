import 'dart:typed_data';

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:tictactoe_client/entities/Player.dart';
import 'package:tictactoe_client/repositories/MetaDataRepository.dart';
import 'package:tictactoe_client/views/utils.dart';

FutureBuilder<Uint8List?> Function(Player?, BuildContext, double) imageWidget =
    (Player? player, BuildContext generalcontext, double radius) {
  return FutureBuilder(
      future: (player?.photoBytes == null)
          ? MetaDataRepository.getImage(id: null, token: player?.token ?? "")
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
          radius: radius,
        );
      });
};
FutureBuilder<Uint8List?> Function(String, String, double)
    imageWidgetFromBytes = (String id, String token, double radius) {
  return FutureBuilder<Uint8List?>(
      future: (existingimage == null)
          ? MetaDataRepository.getImage(id: id, token: token)
          : null,
      builder: (context, snapshot) {
        if (existingimage == null && snapshot.data != null) {
          existingimage = snapshot.data;
        }
        return CircleAvatar(
          foregroundImage: (existingimage != null)
              ? Image.memory(existingimage!).image
              : const AssetImage("assets/images/man.png"),
          radius: radius,
        );
      });
};
