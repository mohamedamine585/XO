import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:tictactoe_client/entities/Player.dart';

class PlayerdataAcess {
  static Future<Map<String, dynamic>?> getPlayerdata() async {
    try {
      final response = await http.get(
          Uri.parse("https://authservice-s4ww.onrender.com/getdata"),
          headers: {"Authorization": "Bearer ${player.token}"});
      final responsebody = json.decode(response.body);
      return responsebody;
    } catch (e) {
      print(e);
    }
    return null;
  }
}
