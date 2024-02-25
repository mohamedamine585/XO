import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:tictactoe_client/entities/Player.dart';

class PlayerdataAcess {
  static Future<Map<String, dynamic>?> getPlayerdata() async {
    try {
      final response = await http.get(
          Uri.parse("https://authservice-s4ww.onrender.com/getdoc"),
          headers: {"Authorization": "Bearer ${player.token}"});
      final responsebody = json.decode(response.body);
      return responsebody;
    } catch (e) {
      print(e);
    }
    return null;
  }

  static Future<Map<String, dynamic>?> setName(
      {required String playername}) async {
    try {
      final response = await http.put(
          Uri.parse("https://authservice-s4ww.onrender.com/setname"),
          body: json.encode({"playername": playername}),
          headers: {"Authorization": "Bearer ${player.token}"});
      final responsebody = json.decode(response.body);
      return responsebody;
    } catch (e) {
      print(e);
    }
    return null;
  }
}
