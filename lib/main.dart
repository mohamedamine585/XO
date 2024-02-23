import 'package:flutter/material.dart';
import 'package:tictactoe_client/presentation/pages/HomePage.dart';
import 'package:tictactoe_client/presentation/pages/LoginPage.dart';
import 'package:tictactoe_client/presentation/pages/PlayRoom.dart';
import 'package:tictactoe_client/presentation/pages/Router.dart';
import 'package:tictactoe_client/presentation/pages/SignupPage.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      routes: {
        "playroom": (context) => Playroom(),
        "home": (context) => const HomePage(),
        "signin": (context) => LoginPage(),
        "signup": (context) => SignupPage(),
        "router": (context) => RouterPage(),
      },
      home: const RouterPage(),
    );
  }
}
