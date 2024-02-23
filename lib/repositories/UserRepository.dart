import 'package:tictactoe_client/data/authDataAcess.dart';
import 'package:tictactoe_client/data/cachedData.dart';
import 'package:tictactoe_client/entities/User.dart';

class UserRepository {
  static signIn({required String email, required String password}) async {
    try {
      final token =
          await AuthDataAcess.signin(email: email, password: password);

      user.token = token;
      await CachedData.cacheToken(token: user.token ?? "");

      print(user.token);
    } catch (e) {
      print(e);
    }
  }

  static signUp({required String email, required String password}) async {
    try {
      final token =
          await AuthDataAcess.signup(email: email, password: password);
      user.token = token;
      await CachedData.cacheToken(token: user.token ?? "");
    } catch (e) {
      print(e);
    }
  }
}
