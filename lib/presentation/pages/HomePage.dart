import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:tictactoe_client/entities/Player.dart';
import 'package:tictactoe_client/presentation/dialogs/namedialog.dart';
import 'package:tictactoe_client/presentation/utils.dart';

bool _dialogShown = false;

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  BuildContext? dialogcontext;

  @override
  @override
  void dispose() {
    super.dispose();
  }

  void _showDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (context) {
        return NameDialog();
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    if (!_dialogShown) {
      WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
        _showDialog(context);
      });
      setState(() {
        _dialogShown = true;
      });
    }
    print(player.playername);

    return Scaffold(
      appBar: AppBar(actions: [
        IconButton(
            onPressed: () async {
              (await SharedPreferences.getInstance()).setString("token", "");
              Navigator.of(context)
                  .pushNamedAndRemoveUntil("router", (route) => false);
            },
            icon: Icon(Icons.logout))
      ]),
      body: Container(
        margin: EdgeInsets.only(left: SCREEN_WIDTH * 0.3),
        child: SingleChildScrollView(
          child: Column(
            children: [
              SizedBox(
                height: SCREEN_HEIGHT * 0.1,
              ),
              CircleAvatar(
                radius: 70,
              ),
              SizedBox(
                height: SCREEN_HEIGHT * 0.05,
              ),
              Container(
                child: Text(player.playername ?? ""),
              ),
              Container(
                width: SCREEN_WIDTH * 0.3,
                child: ElevatedButton(
                    onPressed: () {
                      Navigator.of(context).pushNamedAndRemoveUntil(
                          "playroom", (route) => false);
                    },
                    child: const Text("Play")),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
