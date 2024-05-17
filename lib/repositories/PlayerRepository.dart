import 'package:shared_preferences/shared_preferences.dart';
import 'package:tictactoe_client/data/PlayerdataAccess.dart';
import 'package:tictactoe_client/data/authDataAcess.dart';
import 'package:tictactoe_client/entities/Player.dart';

class playerRepository {
  static signIn({required String email, required String password}) async {
    try {
      final token =
          await AuthDataAcess.signin(email: email, password: password);

      return token;
    } catch (e) {
      print(e);
    }
  }

  static ticSignIn(
      {required String email, required List<int> tictactoe}) async {
    try {
      final token = await AuthDataAcess.tictactoeSignIn(
          tictactoe: tictactoe, email: email);

      return token;
    } catch (e) {
      print(e);
    }
  }

  static changePassword(
      {required String token, required String password}) async {
    try {
      await AuthDataAcess.changePassword(token: token, password: password);

      return token;
    } catch (e) {
      print(e);
    }
  }

  static ticSignUp(
      {required String token,
      required List<int> tictactoe,
      required String email}) async {
    try {
      final newtoken = await AuthDataAcess.setTictactoePassword(
          email: email, tictactoe: tictactoe, token: token);

      return newtoken;
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
    return null;
  }

  static Future<Map<String, dynamic>?> setEmail(
      {required String playername,
      required String email,
      required Player? player}) async {
    try {
      final setnameRes = await PlayerdataAcess.setEmail(
          playername: playername, email: email, player: player);
      if (setnameRes?.isNotEmpty ?? false) {
        return setnameRes;
      }
    } catch (e) {
      print(e);
    }
    return null;
  }

  static Future<Player?> getPlayerdata() async {
    try {
      final prefs = await SharedPreferences.getInstance();
      final token = prefs.getString("token");
      if (token != null && token != "") {
        final playerData = await PlayerdataAcess.getPlayerdata(token: token);
        if (playerData != null) {
          return Player(
              playerData["name"] ?? "",
              playerData["email"] ?? "",
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
    return null;
  }

  static Future<Player?> getPlayerById({required String id}) async {
    try {
      final prefs = await SharedPreferences.getInstance();
      final token = prefs.getString("token");
      if (token != null && token != "") {
        final playerData =
            await PlayerdataAcess.getPlayerdataById(token: token, id: id);
        if (playerData != null) {
          return Player(
              playerData["name"] ?? "",
              playerData["email"] ?? "",
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
    return null;
  }

  static Future<int?> askEmailVerification({required String token}) async {
    try {
      return await AuthDataAcess.askEmailVerification(token: token);
    } catch (e) {
      print(e);
    }
    return null;
  }

  static Future<void> verifyEmail({required String token}) async {
    try {
      return await AuthDataAcess.verifyEmail(token: token);
    } catch (e) {
      print(e);
    }
  }
}
