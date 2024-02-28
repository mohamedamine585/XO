import 'package:flutter/cupertino.dart';
import 'package:provider/provider.dart';
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
      await CachedData.cacheToken(token: token ?? "");
    } catch (e) {
      print(e);
    }
  }

  static Future<Map<String, dynamic>?> setName(
      {required String playername, required String token}) async {
    try {
      final setnameRes =
          await PlayerdataAcess.setName(playername: playername, token: token);
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
        final playerData = await PlayerdataAcess.getPlayerdata(token: token);
        if (playerData != null) {
          return Player(playerData["name"], playerData["email"], token,
              playerData["Playedgames"] ?? 0, playerData["Wongames"] ?? 0);
        }
      }
    } catch (e) {
      print(e);
    }
  }
}
