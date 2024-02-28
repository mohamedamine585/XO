import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:tictactoe_client/repositories/PlayerRepository.dart';
import 'package:tictactoe_client/views/pages/PlayRoom.dart';
import 'package:tictactoe_client/views/utils.dart';

import '../entities/Player.dart';

class BoardPage extends StatefulWidget {
  const BoardPage({super.key});

  @override
  State<BoardPage> createState() => _BoardPageState();
}

class _BoardPageState extends State<BoardPage> {
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
        body: FutureBuilder(
            future: playerRepository.getPlayerdata(),
            builder: (context, snapshot) {
              if (snapshot.connectionState == ConnectionState.done) {
                if (snapshot.hasData) {
                  final int won = snapshot.data?.Wongames ?? 0;
                  context.read<PlayerState>().setPlayer(snapshot.data);

                  return Container(
                      margin: EdgeInsets.only(left: SCREEN_WIDTH * 0.02),
                      child: SingleChildScrollView(
                        child: Column(
                          children: [
                            SizedBox(
                              height: SCREEN_HEIGHT * 0.05,
                            ),
                            CircleAvatar(
                              radius: 70,
                            ),
                            SizedBox(
                              height: SCREEN_HEIGHT * 0.02,
                            ),
                            Container(
                              child: Text(
                                snapshot.data?.playername ?? "",
                                style: Theme.of(context).textTheme.titleMedium,
                              ),
                            ),
                            SizedBox(
                              height: SCREEN_HEIGHT * 0.05,
                            ),
                            Container(
                              margin: EdgeInsets.only(
                                  left: SCREEN_WIDTH * 0.38,
                                  top: SCREEN_HEIGHT * 0.01),
                              width: SCREEN_WIDTH * 0.9,
                              child: Row(
                                children: [
                                  Column(
                                    children: [Text("Wins"), Text("$won")],
                                  ),
                                  Container(
                                    height: SCREEN_HEIGHT * 0.05,
                                    child: VerticalDivider(
                                      color: Color.fromARGB(255, 186, 186, 186),
                                    ),
                                  ),
                                  Column(
                                    children: [
                                      Text("Losses"),
                                      Text(
                                          "${(snapshot.data?.Playedgames)! - won}")
                                    ],
                                  ),
                                ],
                              ),
                            ),
                            SizedBox(
                              height: SCREEN_HEIGHT * 0.05,
                            ),
                            Container(
                              child: Text(
                                "Game History",
                                style: TextStyle(
                                    fontWeight: FontWeight.bold, fontSize: 20),
                              ),
                            ),
                            Container(
                              width: SCREEN_WIDTH * 0.9,
                              height: SCREEN_HEIGHT * 0.2,
                              child: Card(
                                  color: Color.fromARGB(255, 234, 225, 245),
                                  child: ListView.builder(
                                    itemBuilder: (context, index) {
                                      return ListTile();
                                    },
                                    itemCount: 0,
                                  )),
                            )
                          ],
                        ),
                      ));
                }
              }
              return Center(child: CircularProgressIndicator());
            }));
  }
}
