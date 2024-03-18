import 'package:shared_preferences/shared_preferences.dart';
import 'package:tictactoe_client/data/PlayerdataAccess.dart';
import 'package:tictactoe_client/data/authDataAcess.dart';
import 'package:tictactoe_client/data/cachedData.dart';
import 'package:tictactoe_client/entities/Player.dart';

class playerRepository {
  static signIn({required String email, required String password}) async {
    try {
      final token =
          await AuthDataAcess.signin(email: email, password: password);

      await CachedData.cacheToken(token: token ?? "");

      return token;
    } catch (e) {
      print(e);
    }
  }

  static signUp({required String email, required String password}) async {
    try {
      final token =
          await AuthDataAcess.signup(email: email, password: password);
      final prefs = await SharedPreferences.getInstance();
      await prefs.setString("token", token ?? "");
      await prefs.setBool("nameIsSet", false);
      return token;
    } catch (e) {
      print(e);
    }
  }

  static Future<Map<String, dynamic>?> setName(
      {required String playername, required Player? player}) async {
    try {
      final setnameRes =
          await PlayerdataAcess.setName(playername: playername, player: player);
      if (setnameRes?.isNotEmpty ?? false) {
        return setnameRes;
      }
    } catch (e) {
      print(e);
    }
  }

  static Future<Player?> getPlayerdata() async {
    try {
      final prefs = await SharedPreferences.getInstance();
      final token = prefs.getString("token");
      if (token != null && token != "") {
        print(token);
        final playerData = await PlayerdataAcess.getPlayerdata(token: token);
        if (playerData != null) {
          return Player(
              playerData["name"],
              playerData["email"],
              token,
              playerData["playedgames"] ?? 0,
              playerData["wongames"] ?? 0,
              playerData["score"] ?? 0,
              playerData["photourl"],
              playerData["isEmailVerified"] ?? false);
        }
      }
    } catch (e) {
      print(e);
    }
  }
}
