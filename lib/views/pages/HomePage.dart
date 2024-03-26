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
        bottomNavigationBar: BottomNavigationBar(
            selectedLabelStyle: TextStyle(color: Colors.grey),
            items: [
              BottomNavigationBarItem(
                  icon: IconButton(
                      color: (page == 0) ? Colors.purple : null,
                      onPressed: () {
                        setState(() {
                          page = 0;
                        });
                      },
                      icon: const Icon(Icons.home)),
                  label: "home"),
              BottomNavigationBarItem(
                  icon: IconButton(
                      color: (page == 1) ? Colors.purple : null,
                      onPressed: () {
                        setState(() {
                          page = 1;
                        });
                      },
                      icon: const Icon(
                        Icons.grid_3x3,
                        size: 30,
                      )),
                  label: "playground"),
              BottomNavigationBarItem(
                  icon: IconButton(
                      color: (page == 2) ? Colors.purple : null,
                      onPressed: () {
                        setState(() {
                          page = 2;
                        });
                      },
                      icon: Icon(Icons.person)),
                  label: "account"),
            ]));
  }
}
