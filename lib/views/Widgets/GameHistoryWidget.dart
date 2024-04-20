import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:provider/provider.dart';

import 'package:tictactoe_client/repositories/GamesRepository.dart';
import 'package:tictactoe_client/views/ProviderSates/PlayerState.dart';

import 'package:tictactoe_client/views/utils.dart';

Widget gameHistoryWidget(BuildContext context) {
  return Container(
      width: SCREEN_WIDTH * 0.98,
      height: SCREEN_HEIGHT * 0.6,
      child: FutureBuilder<List<Map<String, dynamic>>?>(
          future: GamesRepository.getGamesHistory(
              token: context.watch<PlayerState>().player?.token ?? ""),
          builder: (context, snapshot0) {
            if (snapshot0.connectionState == ConnectionState.done) {
              if (snapshot0.data != null && snapshot0.data != []) {
                return ListView.builder(
                  itemCount: snapshot0.data?.length,
                  itemBuilder: (context, index) {
                    return Container(
                      margin: const EdgeInsets.only(bottom: 2),
                      width: SCREEN_WIDTH * 0.9,
                      height: SCREEN_HEIGHT * 0.08,
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(5),
                          gradient: LinearGradient(colors: [
                            Colors.white,
                            (snapshot0.data?.elementAt(index)["winner"] == 1)
                                ? Color.fromARGB(255, 241, 19, 123)
                                : Color.fromARGB(255, 159, 7, 236),
                          ])),
                      child: ListTile(
                        title: Text((snapshot0.data
                                    ?.elementAt(index)["creatorname"] ==
                                context.watch<PlayerState>().player?.playername)
                            ? snapshot0.data?.elementAt(index)["joinername"] ??
                                "Unkonwn"
                            : snapshot0.data?.elementAt(index)["creatername"] ??
                                "Unkonwn"),
                        trailing:
                            (snapshot0.data?.elementAt(index)["winner"] == 1)
                                ? Text(
                                    "Lost",
                                    style: TextStyle(
                                        color: Colors.white,
                                        fontWeight: FontWeight.bold,
                                        fontSize: 15),
                                  )
                                : Text(
                                    "Won",
                                    style: TextStyle(
                                        color: Colors.white,
                                        fontWeight: FontWeight.bold,
                                        fontSize: 15),
                                  ),
                      ),
                    );
                  },
                );
              } else {
                return const Center(
                  child: Text(
                    "No games played yet",
                    style: TextStyle(color: Colors.black),
                  ),
                );
              }
            }
            return Container(
                height: SCREEN_HEIGHT * 0.01, child: LinearProgressIndicator());
          }));
}
