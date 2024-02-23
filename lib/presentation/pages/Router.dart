import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:tictactoe_client/data/cachedData.dart';
import 'package:tictactoe_client/entities/User.dart';
import 'package:tictactoe_client/presentation/pages/HomePage.dart';
import 'package:tictactoe_client/presentation/pages/LoginPage.dart';

class RouterPage extends StatelessWidget {
  const RouterPage({super.key});

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
        future: SharedPreferences.getInstance(),
        builder: (context, snapshot) {
          CachedData.sharedprefs = snapshot.data;
          if (snapshot.hasData) {
            final token = snapshot.data?.getString("token");
            print(token);
            if (token != null && token != "") {
              user.token = token;

              return const HomePage();
            }
          }
          return LoginPage();
        });
  }
}
