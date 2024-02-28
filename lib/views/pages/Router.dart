import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'package:tictactoe_client/views/pages/HomePage.dart';
import 'package:tictactoe_client/views/pages/LoginPage.dart';
import 'package:tictactoe_client/views/utils.dart';

class RouterPage extends StatelessWidget {
  const RouterPage({super.key});

  @override
  @override
  Widget build(BuildContext context) {
    SCREEN_WIDTH = MediaQuery.of(context).size.width;
    SCREEN_HEIGHT = MediaQuery.of(context).size.height;
    return FutureBuilder(
      future: SharedPreferences.getInstance(),
      builder: (context, snapshot) {
        if (snapshot.connectionState != ConnectionState.none) {
          final token = snapshot.data?.getString("token");

          if (token != null && token != "") {
            return const HomePage();
          } else {
            return LoginPage();
          }
        }

        return const Scaffold(
          body: Center(
            child: CircularProgressIndicator(),
          ),
        );
      },
    );
  }
}
