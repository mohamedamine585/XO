import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:tictactoe_client/data/cachedData.dart';
import 'package:tictactoe_client/views/pages/boradPage.dart';
import 'package:tictactoe_client/views/dialogs/namedialog.dart';
import 'package:tictactoe_client/views/pages/PlayRoom.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  BuildContext? dialogcontext;
  bool isBoardPage = true;
  @override
  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: (isBoardPage) ? BoardPage() : Playroom(),
        bottomNavigationBar: BottomNavigationBar(items: [
          BottomNavigationBarItem(
              icon: IconButton(
                  onPressed: () {
                    setState(() {
                      isBoardPage = true;
                    });
                  },
                  icon: const Icon(Icons.abc_rounded)),
              label: "home"),
          BottomNavigationBarItem(
              icon: Container(
                  width: 80,
                  child: IconButton(
                    onPressed: () {
                      setState(() {
                        isBoardPage = false;
                      });
                    },
                    icon: Image.asset(
                      "assets/images/logo.png",
                      width: 20,
                      fit: BoxFit.fitWidth,
                    ),
                  )),
              label: "playground"),
          BottomNavigationBarItem(
              icon: IconButton(onPressed: () {}, icon: Icon(Icons.person)),
              label: "account"),
        ]));
  }
}
