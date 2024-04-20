import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:tictactoe_client/views/ProviderSates/PlayerState.dart';

import 'package:tictactoe_client/repositories/GamesRepository.dart';

import 'package:tictactoe_client/views/utils.dart';

Widget topPlayersWidget(BuildContext context) {
  return Container(
      width: SCREEN_WIDTH * 0.98,
      height: SCREEN_HEIGHT * 0.7,
      child: FutureBuilder<List<Map<String, dynamic>>?>(
          future: GamesRepository.getTopPlayers(
              token: context.watch<PlayerState>().player?.token ?? ""),
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.done) {
              if (snapshot.data != null && snapshot.data != []) {
                return ListView.builder(
                  itemCount: snapshot.data?.length,
                  itemBuilder: (context, index) {
                    final int playerProgress =
                        snapshot.data?.elementAt(index)["progress"] ?? 0;
                    return Container(
                        margin: const EdgeInsets.only(bottom: 2),
                        width: SCREEN_WIDTH * 0.9,
                        height: SCREEN_HEIGHT * 0.08,
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(5),
                            gradient: LinearGradient(
                                colors: [Colors.white, Colors.purple])),
                        child: ListTile(
                          subtitle: Text(
                            (snapshot.data
                                        ?.elementAt(index)["playedgames"]
                                        .toString() ??
                                    "") +
                                "  played games",
                            style: const TextStyle(
                                fontWeight: FontWeight.normal, fontSize: 12),
                          ),
                          title: Text(
                            snapshot.data?.elementAt(index)["name"] ??
                                "Unknown",
                            style: const TextStyle(fontWeight: FontWeight.bold),
                          ),
                          trailing: Container(
                            width: SCREEN_WIDTH * 0.15,
                            child: Row(
                              children: [
                                (playerProgress != 0)
                                    ? (playerProgress < 0)
                                        ? Icon(
                                            Icons.arrow_downward_rounded,
                                            color: Colors.white,
                                          )
                                        : Icon(
                                            Icons.arrow_upward,
                                            color: Colors.white,
                                          )
                                    : SizedBox(
                                        width: SCREEN_WIDTH * 0.05,
                                      ),
                                Text(
                                  (snapshot.data?.elementAt(index)["score"] !=
                                          null)
                                      ? snapshot.data
                                              ?.elementAt(index)["score"]
                                              .toString() ??
                                          "0"
                                      : "0",
                                  style: const TextStyle(
                                      color: Colors.white, fontSize: 20),
                                ),
                              ],
                            ),
                          ),
                        ));
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
