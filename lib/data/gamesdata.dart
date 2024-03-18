import 'dart:convert';

import 'package:http/http.dart';
import 'package:tictactoe_client/utils.dart';

class GamesData {
  static Future<String?> getPlayroomid({required String token}) async {
    try {
      final headers = {'authorization': "Bearer $token"};
      final response =
          await get(Uri.parse("http://$GAME_URL"), headers: headers);
      if (response.statusCode == 200) {
        final roomid = json.decode(response.body)["roomid"] as String?;
        return roomid;
      }
    } catch (e) {
      print(e);
    }
    return null;
  }

  static Future<List<Map<String, dynamic>>?> getGamesHistory(
      {required String token}) async {
    try {
      final headers = {'authorization': "Bearer $token"};
      final response =
          await get(Uri.parse("http://$GAME_URL/history"), headers: headers);
      final games = json.decode(response.body)["history"] as List<dynamic>;
      List<Map<String, dynamic>> gamesresult = [];
      games.forEach((element) {
        gamesresult.add(element);
      });
      return gamesresult;
    } catch (e) {
      print(e);
    }
  }
}
