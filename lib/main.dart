import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:tictactoe_client/entities/Player.dart';
import 'package:tictactoe_client/views/pages/HomePage.dart';
import 'package:tictactoe_client/views/pages/LoginPage.dart';
import 'package:tictactoe_client/views/pages/PlayRoom.dart';
import 'package:tictactoe_client/views/pages/Router.dart';
import 'package:tictactoe_client/views/pages/SignupPage.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [ChangeNotifierProvider(create: (context) => PlayerState())],
      child: MaterialApp(
        routes: {
          "playroom": (context) => Playroom(),
          "home": (context) => const HomePage(),
          "signin": (context) => LoginPage(),
          "signup": (context) => SignupPage(),
          "router": (context) => RouterPage(),
        },
        home: RouterPage(),
        theme: ThemeData(
            textTheme: TextTheme(
          titleMedium: TextStyle(fontWeight: FontWeight.bold, fontSize: 20),
          titleSmall: TextStyle(fontSize: 10),
        )),
      ),
    );
  }
}
