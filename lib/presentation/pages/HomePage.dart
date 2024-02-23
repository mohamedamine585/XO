import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:tictactoe_client/data/PlayXOData.dart';
import 'package:tictactoe_client/presentation/utils.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  Widget build(BuildContext context) {
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
      body: SingleChildScrollView(
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
              width: SCREEN_WIDTH * 0.3,
              child: ElevatedButton(
                  onPressed: () {
                    Navigator.of(context)
                        .pushNamedAndRemoveUntil("playroom", (route) => false);
                  },
                  child: const Text("Play")),
            ),
            Container()
          ],
        ),
      ),
    );
  }
}
