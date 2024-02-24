import 'package:shared_preferences/shared_preferences.dart';

class CachedData {
  static SharedPreferences? sharedprefs;

  static init() async {
    try {
      sharedprefs = await SharedPreferences.getInstance();
    } catch (e) {
      print(e);
    }
  }

  static Future<void> cacheToken({required String token}) async {
    try {
      await sharedprefs?.setString("token", token);
    } catch (e) {
      print(e);
    }
  }
}
