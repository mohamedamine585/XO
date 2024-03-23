import 'dart:io';
import 'dart:typed_data';

import 'package:http/http.dart' as http;
import 'package:tictactoe_client/entities/Player.dart';

class MetaDataAccess {
  static Future<Uint8List?> getImage({required Player? player}) async {
    try {
      final headers = {'authorization': "Bearer ${player?.token}"};
      final response = await http.get(
          Uri.parse("http://192.168.1.14:8080/player/image"),
          headers: headers);
      return response.bodyBytes;
    } catch (e) {
      print(e);
    }
    return null;
  }

  static Future<void> uploadImage(
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
          'POST', Uri.parse("http://192.168.1.14:8080/player/image"));

      request.files.add(multipartFile);
      request.headers.addAll(headers);

      final response = await request.send();

      // Print the response
      print(await response.stream.bytesToString());
    } catch (e) {
      print(e);
    }
  }
}
