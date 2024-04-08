import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:tictactoe_client/entities/HomePageData.dart';
import 'package:tictactoe_client/entities/Player.dart';
import 'package:tictactoe_client/views/Widgets/TictactoePassword.dart';
import 'package:tictactoe_client/views/pages/AccountPage.dart';
import 'package:tictactoe_client/views/pages/HomePage.dart';
import 'package:tictactoe_client/views/pages/LoginPage.dart';
import 'package:tictactoe_client/views/pages/PasswordVerif.dart';
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
      providers: [
        ChangeNotifierProvider(create: (context) => PlayerState()),
        ChangeNotifierProvider(create: (context) => HomePageState())
      ],
      child: MaterialApp(
        routes: {
          "playroom": (context) => Playroom(),
          "home": (context) => const HomePage(),
          "signin": (context) => LoginPage(),
          "signup": (context) => SignupPage(),
          "router": (context) => const RouterPage(),
          "account": (context) => const AccountPage(),
          "passwordverif": (context) => const PasswordVerif()
        },
        home: RouterPage(),
        theme: ThemeData(
            textTheme: TextTheme(
          titleMedium: TextStyle(
            fontWeight: FontWeight.bold,
            fontSize: 25,
            color: Colors.purple,
            fontFamily: 'Hind',
          ),
          titleSmall: TextStyle(fontSize: 10),
          bodyMedium: TextStyle(fontWeight: FontWeight.bold, fontSize: 20),
          bodySmall: TextStyle(
              color: Color.fromARGB(255, 15, 5, 118),
              fontSize: 15,
              fontWeight: FontWeight.normal),
        )),
      ),
    );
  }
}
