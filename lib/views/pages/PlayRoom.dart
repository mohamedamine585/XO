import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:tictactoe_client/entities/Player.dart';

import 'package:tictactoe_client/views/utils.dart';
import 'package:web_socket_channel/io.dart';
import 'package:web_socket_channel/web_socket_channel.dart';

class Playroom extends StatefulWidget {
  @override
  _PlayroomState createState() => _PlayroomState();
}

class _PlayroomState extends State<Playroom> {
  List<dynamic> board = List.filled(9, '');
  bool isconnectionclosed = false;
  bool isPlaying = false;
  IOWebSocketChannel? channel;

  @override
  Widget build(BuildContext context) {
    final token = context.watch<PlayerState>().player?.token;
    print(token);
    if (isPlaying) {
      channel = IOWebSocketChannel.connect(
        Uri.parse("wss://tictactoeserver-1.onrender.com"),
        headers: {"token": "${token}"},
      );
    }
    return Scaffold(
      appBar: AppBar(
        title: Text('Tic-Tac-Toe'),
      ),
      body: (isPlaying)
          ? StreamBuilder(
              stream: channel?.stream,
              builder: (context, snapshot) {
                if ((snapshot.connectionState != ConnectionState.none)) {
                  if (snapshot.hasData) {
                    Map<String, dynamic> data = json.decode(snapshot.data);

                    print(data["message"]);
                    board = (data["Grid"] != null)
                        ? data["Grid"]
                        : [
                            "",
                            "",
                            "",
                            "",
                            "",
                            "",
                            "",
                            "",
                            "",
                          ];
                    return Column(
                      children: [
                        Text(data["message"] ?? ""),
                        Container(
                          height: 400,
                          child: GridView.builder(
                            gridDelegate:
                                SliverGridDelegateWithFixedCrossAxisCount(
                              crossAxisCount: 3,
                            ),
                            itemCount: 9,
                            itemBuilder: (context, index) {
                              return buildGridCell(index, channel?.sink);
                            },
                          ),
                        ),
                        ElevatedButton(
                          onPressed: () async {
                            await channel?.sink.close();

                            setState(() {
                              isconnectionclosed = true;
                            });
                          },
                          child: Text("Replay"),
                        ),
                        ElevatedButton(
                          onPressed: () async {
                            await channel?.sink.close();

                            setState(() {
                              isPlaying = false;
                            });
                          },
                          child: Text("end"),
                        ),
                      ],
                    );
                  } else {
                    return Center(
                      child: Column(
                        children: [
                          SizedBox(
                            height: SCREEN_HEIGHT * 0.3,
                          ),
                          CircularProgressIndicator(),
                          ElevatedButton(
                              onPressed: () async {
                                await channel?.sink.close();
                                isconnectionclosed = false;
                                Navigator.of(context).pushNamedAndRemoveUntil(
                                    "router", (route) => false);
                              },
                              child: Text("Quit"))
                        ],
                      ),
                    );
                  }
                } else {
                  return Center(
                    child: Column(
                      children: [
                        SizedBox(
                          height: SCREEN_HEIGHT * 0.1,
                        ),
                        Center(
                          child: Text("Game ended"),
                        ),
                        SizedBox(
                          height: SCREEN_HEIGHT * 0.1,
                        ),
                        ElevatedButton(
                          onPressed: () async {
                            await channel?.sink.close();
                            isconnectionclosed = false;

                            setState(() {});
                          },
                          child: Text("Replay"),
                        ),
                      ],
                    ),
                  );
                }
              },
            )
          : Center(
              child: Container(
                width: SCREEN_WIDTH * 0.7,
                child: ElevatedButton(
                    onPressed: () {
                      setState(() {
                        isPlaying = true;
                      });
                    },
                    child: const Text("Play")),
              ),
            ),
    );
  }

  Widget buildGridCell(int index, WebSocketSink? sink) {
    return GestureDetector(
      onTap: () {
        // Handle cell tap
        if (board[index] == '') {
          sink?.add("${(index / 3).floor()} ${(index % 3)}");
        }
      },
      child: Container(
        decoration: BoxDecoration(
          border: Border.all(
            color: Colors.black,
          ),
        ),
        child: Center(
          child: Text(
            board[index],
            style: TextStyle(fontSize: 24),
          ),
        ),
      ),
    );
  }
}
