import 'package:tictactoe_client/data/gamesdata.dart';

class GamesRepository {
  static Future<List<Map<String, dynamic>>?> getGamesHistory(
      {required String token}) async {
    try {
      final games = await GamesData.getGamesHistory(token: token);
      return games;
    } catch (e) {
      print(e);
    }
  }
}
