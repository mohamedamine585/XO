import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:tictactoe_client/data/cachedData.dart';
import 'package:tictactoe_client/entities/Player.dart';
import 'package:tictactoe_client/presentation/pages/HomePage.dart';
import 'package:tictactoe_client/presentation/pages/LoginPage.dart';
import 'package:tictactoe_client/repositories/PlayerRepository.dart';

class RouterPage extends StatelessWidget {
  const RouterPage({super.key});

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
        future: playerRepository.getPlayerdata(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.done) {
            return (player.token != null && player.token != "")
                ? const HomePage()
                : LoginPage();
          } else {
            return Scaffold(
              body: Center(
                child: CircularProgressIndicator(),
              ),
            );
          }
        });
  }
}
