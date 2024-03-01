import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:tictactoe_client/repositories/GamesRepository.dart';
import 'package:tictactoe_client/repositories/PlayerRepository.dart';
import 'package:tictactoe_client/views/dialogs/namedialog.dart';
import 'package:tictactoe_client/views/utils.dart';

import '../../entities/Player.dart';

class BoardPage extends StatefulWidget {
  const BoardPage({super.key});

  @override
  State<BoardPage> createState() => _BoardPageState();
}

class _BoardPageState extends State<BoardPage> {
  Future<String?> _showDialog(BuildContext context) async {
    return await showDialog(
      context: context,
      builder: (context) {
        return NameDialog();
      },
    );
  }

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
                  if (snapshot.data?.playername == null) {
                    WidgetsBinding.instance
                        .addPostFrameCallback((timeStamp) async {
                      final playername = await _showDialog(context);
                      if (playername != null) {
                        context.read<PlayerState>().setName(playername);
                      }
                    });
                  }

                  return Container(
                      margin: EdgeInsets.only(left: SCREEN_WIDTH * 0.02),
                      child: SingleChildScrollView(
                        child: Column(
                          children: [
                            SizedBox(
                              height: SCREEN_HEIGHT * 0.05,
                            ),
                            CircleAvatar(
                              foregroundImage:
                                  AssetImage("assets/images/man.png"),
                              radius: 70,
                            ),
                            SizedBox(
                              height: SCREEN_HEIGHT * 0.02,
                            ),
                            Container(
                              child: Text(
                                context
                                        .watch<PlayerState>()
                                        .player
                                        ?.playername ??
                                    "",
                                style: Theme.of(context).textTheme.titleMedium,
                              ),
                            ),
                            SizedBox(
                              height: SCREEN_HEIGHT * 0.05,
                            ),
                            Container(
                              margin: EdgeInsets.only(
                                  left: SCREEN_WIDTH * 0.335,
                                  top: SCREEN_HEIGHT * 0.01),
                              width: SCREEN_WIDTH * 0.9,
                              child: Row(
                                children: [
                                  Column(
                                    children: [
                                      Text(
                                        "Wins",
                                        style: TextStyle(
                                            fontWeight: Theme.of(context)
                                                .textTheme
                                                .titleMedium
                                                ?.fontWeight,
                                            fontSize: Theme.of(context)
                                                .textTheme
                                                .titleMedium
                                                ?.fontSize,
                                            color: Colors.green),
                                      ),
                                      Text(
                                        "$won",
                                        style: TextStyle(
                                            fontWeight: Theme.of(context)
                                                .textTheme
                                                .titleMedium
                                                ?.fontWeight,
                                            fontSize: Theme.of(context)
                                                .textTheme
                                                .titleMedium
                                                ?.fontSize,
                                            color: Colors.green),
                                      )
                                    ],
                                  ),
                                  SizedBox(
                                    width: SCREEN_WIDTH * 0.02,
                                  ),
                                  Container(
                                    height: SCREEN_HEIGHT * 0.05,
                                    child: VerticalDivider(
                                      color: Color.fromARGB(255, 186, 186, 186),
                                    ),
                                  ),
                                  SizedBox(
                                    width: SCREEN_WIDTH * 0.02,
                                  ),
                                  Column(
                                    children: [
                                      Text(
                                        "Losses",
                                        style: TextStyle(
                                            fontWeight: Theme.of(context)
                                                .textTheme
                                                .titleMedium
                                                ?.fontWeight,
                                            fontSize: Theme.of(context)
                                                .textTheme
                                                .titleMedium
                                                ?.fontSize,
                                            color: Colors.red),
                                      ),
                                      Text(
                                        "${(snapshot.data?.Playedgames)! - won}",
                                        style: TextStyle(
                                            fontWeight: Theme.of(context)
                                                .textTheme
                                                .titleMedium
                                                ?.fontWeight,
                                            fontSize: Theme.of(context)
                                                .textTheme
                                                .titleMedium
                                                ?.fontSize,
                                            color: Colors.red),
                                      )
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
                                  elevation: 10,
                                  color: Color.fromARGB(255, 241, 240, 241),
                                  child: FutureBuilder<
                                          List<Map<String, dynamic>>?>(
                                      future: GamesRepository.getGamesHistory(
                                          token: context
                                                  .watch<PlayerState>()
                                                  .player
                                                  ?.token ??
                                              ""),
                                      builder: (context, snapshot0) {
                                        if (snapshot0.connectionState ==
                                            ConnectionState.done) {
                                          return ListView.builder(
                                            itemCount: snapshot0.data?.length,
                                            itemBuilder: (context, index) {
                                              return Card(
                                                color: Color.fromARGB(
                                                    255, 216, 194, 220),
                                                child: ListTile(
                                                  title: Text((snapshot0.data
                                                                  ?.elementAt(
                                                                      index)[
                                                              "creatorname"] ==
                                                          context
                                                              .watch<
                                                                  PlayerState>()
                                                              .player
                                                              ?.playername)
                                                      ? snapshot0.data
                                                                  ?.elementAt(
                                                                      index)[
                                                              "joinername"] ??
                                                          "Unkonwn"
                                                      : snapshot0.data
                                                                  ?.elementAt(
                                                                      index)[
                                                              "creatername"] ??
                                                          "Unkonwn"),
                                                  trailing: ((snapshot0.data?.elementAt(
                                                                          index)[
                                                                      "joinername"] ==
                                                                  context
                                                                      .watch<
                                                                          PlayerState>()
                                                                      .player
                                                                      ?.playername &&
                                                              snapshot0.data?.elementAt(
                                                                          index)[
                                                                      "winner"] ==
                                                                  0) ||
                                                          (snapshot0.data?.elementAt(
                                                                          index)[
                                                                      "creatername"] ==
                                                                  context
                                                                      .watch<
                                                                          PlayerState>()
                                                                      .player
                                                                      ?.playername &&
                                                              snapshot0.data?.elementAt(
                                                                          index)[
                                                                      "winner"] ==
                                                                  1))
                                                      ? Text(
                                                          "Lost",
                                                          style: TextStyle(
                                                              color: Colors.red,
                                                              fontWeight:
                                                                  FontWeight
                                                                      .bold,
                                                              fontSize: 15),
                                                        )
                                                      : Text(
                                                          "Won",
                                                          style: TextStyle(
                                                              color:
                                                                  Colors.green,
                                                              fontWeight:
                                                                  FontWeight
                                                                      .bold,
                                                              fontSize: 15),
                                                        ),
                                                ),
                                              );
                                            },
                                          );
                                        }
                                        return Container(
                                            height: SCREEN_HEIGHT * 0.01,
                                            child: LinearProgressIndicator());
                                      })),
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
