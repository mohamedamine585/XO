import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:tictactoe_client/entities/HomePageData.dart';
import 'package:tictactoe_client/repositories/GamesRepository.dart';
import 'package:tictactoe_client/repositories/PlayerRepository.dart';
import 'package:tictactoe_client/views/Widgets/GameHistoryWidget.dart';
import 'package:tictactoe_client/views/Widgets/ImageWidget.dart';
import 'package:tictactoe_client/views/dialogs/namedialog.dart';
import 'package:tictactoe_client/views/utils.dart';

import '../../entities/Player.dart';

class BoardPage extends StatefulWidget {
  const BoardPage({super.key});

  @override
  State<BoardPage> createState() => _BoardPageState();
}

class _BoardPageState extends State<BoardPage> {
  Player? player;
  @override
  void didChangeDependencies() {
    player = context.watch<PlayerState>().player;
    super.didChangeDependencies();
  }

  Future<String?> _showDialog(BuildContext context) async {
    return await showDialog(
      context: context,
      builder: (context) {
        return NameDialog(player);
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: FutureBuilder(
            future: playerRepository.getPlayerdata(),
            builder: (context, snapshot) {
              bool isGameHistory = context.watch<HomePageState>().isGameHistory;

              if (snapshot.connectionState == ConnectionState.done) {
                if (snapshot.hasData) {
                  final int won = snapshot.data?.Wongames ?? 0;
                  final int playedg = snapshot.data?.Playedgames ?? 0;
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
                            Row(children: [
                              Container(
                                margin: EdgeInsets.only(
                                    left: SCREEN_WIDTH * 0.85,
                                    top: SCREEN_HEIGHT * 0.02),
                                child: IconButton(
                                    onPressed: () async {
                                      (await SharedPreferences.getInstance())
                                          .setString("token", "");
                                      Navigator.of(context)
                                          .pushNamedAndRemoveUntil(
                                              "router", (route) => false);
                                    },
                                    icon: Icon(Icons.logout)),
                              )
                            ]),
                            SizedBox(
                              height: SCREEN_HEIGHT * 0.2,
                            ),
                            Container(
                              decoration: BoxDecoration(
                                shape: BoxShape.circle,
                                color: Colors.purple,
                              ),
                              child: Padding(
                                  padding: const EdgeInsets.all(8.0),
                                  child: imageWidget(player, context, 100)),
                            ),
                            SizedBox(
                              height: SCREEN_HEIGHT * 0.02,
                            ),
                            Container(
                              width: SCREEN_WIDTH * 0.7,
                              child: Center(
                                child: Text(
                                  context
                                          .watch<PlayerState>()
                                          .player
                                          ?.playername ??
                                      "",
                                  style:
                                      Theme.of(context).textTheme.titleMedium,
                                  overflow: TextOverflow.ellipsis,
                                ),
                              ),
                            ),
                            SizedBox(
                              height: SCREEN_HEIGHT * 0.05,
                            ),
                            Container(
                              height: SCREEN_HEIGHT * 0.17,
                              width: SCREEN_WIDTH * 0.35,
                              decoration: BoxDecoration(
                                color: Colors.purple,
                                shape: BoxShape.circle,
                                border: Border.all(
                                    color: Colors
                                        .white), // Added border for separation
                              ),
                              child: Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: Container(
                                  decoration: BoxDecoration(
                                    color: Colors.purple,
                                    shape: BoxShape.circle,
                                    border: Border.all(
                                        color: Colors
                                            .white), // Added border for separation
                                  ),
                                  child: Column(
                                    children: [
                                      SizedBox(
                                        height: SCREEN_HEIGHT * 0.02,
                                      ),
                                      Text(
                                        "Score",
                                        style: TextStyle(color: Colors.white),
                                      ),
                                      SizedBox(
                                        height: SCREEN_HEIGHT * 0.01,
                                      ),
                                      Text(
                                        "${snapshot.data?.score}",
                                        style: TextStyle(
                                            color: Colors.white, fontSize: 30),
                                      )
                                    ],
                                  ),
                                ),
                              ),
                            ),
                            SizedBox(
                              height: SCREEN_HEIGHT * 0.25,
                            ),
                            Container(
                              width: SCREEN_WIDTH * 1,
                              child: Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceAround,
                                children: [
                                  GestureDetector(
                                    onTap: () {
                                      context
                                          .read<HomePageState>()
                                          .setIsGameHistory(true);
                                    },
                                    child: Text(
                                      "Game History",
                                      style: TextStyle(
                                          color: isGameHistory
                                              ? Colors.purple
                                              : Colors.black),
                                    ),
                                  ),
                                  GestureDetector(
                                    onTap: () {
                                      context
                                          .read<HomePageState>()
                                          .setIsGameHistory(false);
                                    },
                                    child: Text(
                                      "Score Board",
                                      style: TextStyle(
                                          color: !isGameHistory
                                              ? Colors.purple
                                              : Colors.black),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                            Container(
                                width: SCREEN_WIDTH * 0.9, child: Divider()),
                            SizedBox(
                              height: SCREEN_HEIGHT * 0.01,
                            ),
                            isGameHistory
                                ? Container(
                                    decoration: BoxDecoration(
                                        borderRadius: BorderRadius.circular(10),
                                        gradient: LinearGradient(colors: [
                                          Colors.green,
                                          Colors.red,
                                        ], stops: [
                                          won / playedg,
                                          1 - won / playedg
                                        ])),
                                    height: SCREEN_HEIGHT * 0.06,
                                    width: SCREEN_WIDTH * 0.8,
                                    child: (playedg - won > 0)
                                        ? Row(
                                            mainAxisAlignment:
                                                MainAxisAlignment.spaceBetween,
                                            children: [
                                              Container(
                                                margin: EdgeInsets.only(
                                                    left: SCREEN_WIDTH * 0.01),
                                                child: Text(
                                                  "$won",
                                                  style: const TextStyle(
                                                      color: Colors.white),
                                                ),
                                              ),
                                              Container(
                                                margin: EdgeInsets.only(
                                                    right: SCREEN_WIDTH * 0.01),
                                                child: Text(
                                                  "${playedg - won}",
                                                  style: const TextStyle(
                                                      color: Colors.white),
                                                ),
                                              ),
                                            ],
                                          )
                                        : (won == 0)
                                            ? Center(
                                                child: Text(
                                                  "${playedg - won}",
                                                  style: const TextStyle(
                                                      color: Colors.white),
                                                ),
                                              )
                                            : Center(
                                                child: Text(
                                                  "$won",
                                                  style: const TextStyle(
                                                      color: Colors.white),
                                                ),
                                              ),
                                  )
                                : const SizedBox(),
                            SizedBox(
                              height: SCREEN_HEIGHT * 0.01,
                            ),
                            isGameHistory
                                ? gameHistoryWidget(context)
                                : SizedBox(
                                    height: SCREEN_HEIGHT * 0.8,
                                  ),
                          ],
                        ),
                      ));
                }
              }
              return Center(child: CircularProgressIndicator());
            }));
  }
}
