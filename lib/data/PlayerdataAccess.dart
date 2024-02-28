import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:tictactoe_client/entities/Player.dart';
import 'package:tictactoe_client/utils.dart';

class PlayerdataAcess {
  static Future<Map<String, dynamic>?> getPlayerdata(
      {required String token}) async {
    try {
      final response = await http.get(Uri.parse("$URL/getdoc"),
          headers: {"Authorization": "Bearer $token"});

      final responsebody = json.decode(response.body);
      return responsebody;
    } catch (e) {
      print(e);
    }
    return null;
  }

  static Future<Map<String, dynamic>?> setName(
      {required String playername, required String token}) async {
    try {
      final response = await http.put(Uri.parse("$URL/setname"),
          body: json.encode({"name": playername}),
          headers: {"Authorization": "Bearer $token"});
      final responsebody = json.decode(response.body);
      return responsebody;
    } catch (e) {
      print(e);
    }
    return null;
  }
}
