import 'dart:io';
import 'dart:typed_data';

import 'package:http/http.dart' as http;
import 'package:tictactoe_client/entities/Player.dart';
import 'package:tictactoe_client/utils.dart';

class MetaDataAccess {
  static Future<Uint8List?> getImage({required Player? player}) async {
    try {
      final headers = {'authorization': "Bearer ${player?.token}"};
      final response = await http
          .get(Uri.parse("https://$GAME_URL/player/image"), headers: headers);
      if (response.statusCode == 200) {
        return response.bodyBytes;
      }
    } catch (e) {
      print(e);
    }
    return null;
  }

  static Future<bool?> uploadImage(
      {required File image, required String token}) async {
    try {
      // Prepare headers with authorization token
      final headers = {'authorization': "Bearer $token", 'update': 'image'};

      // Create a multipart file from the image
      final multipartFile = http.MultipartFile.fromBytes(
        'image',
        await image.readAsBytes(),
        filename: 'image.jpg', // Specify the filename for the server
      );

      // Attach the multipart file to the request
      final request = http.MultipartRequest(
          'POST', Uri.parse("https://$GAME_URL/player/image"));

      request.files.add(multipartFile);
      request.headers.addAll(headers);

      final response = await request.send();
      return response.statusCode == 200;
    } catch (e) {
      print(e);
    }
  }
}
