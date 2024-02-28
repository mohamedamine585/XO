import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:tictactoe_client/data/cachedData.dart';
import 'package:tictactoe_client/entities/Player.dart';
import 'package:tictactoe_client/views/boradPage.dart';
import 'package:tictactoe_client/views/dialogs/namedialog.dart';
import 'package:tictactoe_client/views/pages/PlayRoom.dart';
import 'package:tictactoe_client/views/utils.dart';
import 'package:tictactoe_client/repositories/PlayerRepository.dart';

bool _dialogShown = false;

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

  _showDialog(BuildContext context) async {
    final prefs = await SharedPreferences.getInstance();
    final nameIsSet = prefs.getBool("nameIsSet");
    if (!(nameIsSet ?? false)) {
      await showDialog(
        context: context,
        builder: (context) {
          return NameDialog();
        },
      );
    }
    await CachedData.sharedprefs?.setBool("nameSet", false);
  }

  @override
  void initState() {
    if (!_dialogShown) {
      WidgetsBinding.instance.addPostFrameCallback((timeStamp) async {
        final dialog = await _showDialog(context);
        setState(() {});
      });
    }
    super.initState();
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
