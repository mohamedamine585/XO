import 'dart:io';
import 'dart:typed_data';
import 'package:tictactoe_client/data/metaDataAcess.dart';
import 'package:tictactoe_client/entities/Player.dart';

class MetaDataRepository {
  static Future<bool?> uploadImage(
      {required File image, required String token}) async {
    return await MetaDataAccess.uploadImage(image: image, token: token);
  }

  static Future<Uint8List?> getImage({required Player? player}) async {
    return await MetaDataAccess.getImage(player: player);
  }
}
