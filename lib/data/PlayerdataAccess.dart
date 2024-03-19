import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:tictactoe_client/entities/Player.dart';
import 'package:tictactoe_client/utils.dart';

class PlayerdataAcess {
  static Future<Map<String, dynamic>?> getPlayerdata(
      {required String token}) async {
    try {
      final response = await http.get(Uri.parse("http://$GAME_URL/player"),
          headers: {"Authorization": "Bearer $token"});
      final responsebody = json.decode(response.body);
      return responsebody;
    } catch (e) {
      print(e);
    }
    return null;
  }

  static Future<Map<String, dynamic>?> setName({
    required String playername,
    required Player? player,
  }) async {
    try {
      final response = await http.put(Uri.parse("http://$GAME_URL/player"),
          body: json.encode({"name": playername, "email": player?.email}),
          headers: {"Authorization": "Bearer ${player?.token}"});
      final responsebody = json.decode(response.body);
      return responsebody;
    } catch (e) {
      print(e);
    }
    return null;
  }

  static Future<Map<String, dynamic>?> setEmail({
    required String playername,
    required Player? player,
  }) async {
    try {
      final response = await http.put(Uri.parse("http://$GAME_URL/player"),
          body: json.encode({"name": playername, "email": player?.email}),
          headers: {"Authorization": "Bearer ${player?.token}"});
      final responsebody = json.decode(response.body);
      return responsebody;
    } catch (e) {
      print(e);
    }
    return null;
  }
}
