import 'package:tictactoe_client/data/PlayerdataAccess.dart';
import 'package:tictactoe_client/data/authDataAcess.dart';
import 'package:tictactoe_client/data/cachedData.dart';
import 'package:tictactoe_client/entities/Player.dart';

class playerRepository {
  static signIn({required String email, required String password}) async {
    try {
      final token =
          await AuthDataAcess.signin(email: email, password: password);

      player.token = token;
      await CachedData.cacheToken(token: player.token ?? "");
    } catch (e) {
      print(e);
    }
  }

  static signUp({required String email, required String password}) async {
    try {
      final token =
          await AuthDataAcess.signup(email: email, password: password);
      player.token = token;
      await CachedData.cacheToken(token: player.token ?? "");
    } catch (e) {
      print(e);
    }
  }

  static setName({required String playername}) async {
    try {
      final setnameRes = await PlayerdataAcess.setName(playername: playername);
      if (setnameRes?.isNotEmpty ?? false) {
        player.playername = playername;
      }
    } catch (e) {
      print(e);
    }
  }

  static Future<void> getPlayerdata() async {
    try {
      await CachedData.init();
      player.token = CachedData.sharedprefs?.getString("token");
      if (player.token != null && player.token != "") {
        final playerData = await PlayerdataAcess.getPlayerdata();
        if (playerData != null) {
          player.email = (playerData["email"] as String?) ?? "";
          player.playername = (playerData["playername"] as String?) ?? "";
        }
      }
    } catch (e) {
      print(e);
    }
  }
}
