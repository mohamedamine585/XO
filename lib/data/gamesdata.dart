import 'dart:convert';
import 'dart:math';

import 'package:http/http.dart';
import 'package:tictactoe_client/utils.dart';

class GamesData {
  static Future<List<Map<String, dynamic>>?> getGamesHistory(
      {required String token}) async {
    try {
      final headers = {'authorization': "Bearer $token"};
      final response = await get(Uri.parse("$URL/games"), headers: headers);
      final games = json.decode(response.body)["playedgames"] as List<dynamic>;
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
