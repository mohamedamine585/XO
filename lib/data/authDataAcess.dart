import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:tictactoe_client/utils.dart';

class AuthDataAcess {
  static Future<String?> setTictactoePassword(
      {required List<int> tictactoe,
      required String token,
      required String email}) async {
    try {
      final response = await http.post(Uri.parse("$URL/tictactoe"),
          body: json.encode({"tictactoe": tictactoe, "email": email}),
          headers: {
            "Authorization": "Bearer $token",
          });
      print(response.body);
      if (response.statusCode == 200) {
        return json.decode(response.body)["message"];
      }
    } catch (e) {
      print(e);
    }
    return null;
  }

  static Future<String?> tictactoeSignIn({
    required List<int> tictactoe,
    required String email,
  }) async {
    try {
      final response = await http.post(
        Uri.parse("$URL/tictactoein"),
        body: json.encode({"tictactoe": tictactoe, "email": email}),
      );
      if (response.statusCode == 200) {
        final token = response.headers["authorization"]?.split(" ")[1];
        return token;
      }
    } catch (e) {
      print(e);
    }
    return null;
  }

  static signin({required String email, required String password}) async {
    try {
      final resonse = await http.post(Uri.parse("$URL/signin"),
          body: json.encode({"email": email, "password": password}));
      if (resonse.statusCode != 200) {
        return null;
      }
      final token = resonse.headers["authorization"]?.split(" ")[1];
      return token;
    } catch (e) {
      print(e);
    }
  }

  static signup({required String email, required String password}) async {
    try {
      final resonse = await http.post(Uri.parse("$URL/signup"),
          body: json.encode({"email": email, "password": password}));
      if (resonse.statusCode != 200) {
        print(resonse.statusCode);
        return null;
      }
      print(resonse.headers);
      final token = resonse.headers["authorization"]?.split(" ")[1];
      return token;
    } catch (e) {
      print(e);
    }
  }
}
