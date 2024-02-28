import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:tictactoe_client/utils.dart';

class AuthDataAcess {
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
