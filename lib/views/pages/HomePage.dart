import 'package:flutter/material.dart';
import 'package:tictactoe_client/views/pages/AccountPage.dart';

import 'package:tictactoe_client/views/pages/boradPage.dart';
import 'package:tictactoe_client/views/pages/PlayRoom.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  BuildContext? dialogcontext;
  int page = 0;
  @override
  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: (page == 0)
            ? BoardPage()
            : (page == 1)
                ? Playroom()
                : const AccountPage(),
        bottomNavigationBar: BottomNavigationBar(items: [
          BottomNavigationBarItem(
              icon: IconButton(
                  onPressed: () {
                    setState(() {
                      page = 0;
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
                        page = 1;
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
              icon: IconButton(
                  onPressed: () {
                    setState(() {
                      page = 3;
                    });
                  },
                  icon: Icon(Icons.person)),
              label: "account"),
        ]));
  }
}
