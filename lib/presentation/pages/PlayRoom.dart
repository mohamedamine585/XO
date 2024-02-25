import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:tictactoe_client/data/PlayXOData.dart';
import 'package:tictactoe_client/entities/Player.dart';
import 'package:tictactoe_client/presentation/utils.dart';
import 'package:web_socket_channel/io.dart';
import 'package:web_socket_channel/io.dart';
import 'package:web_socket_channel/web_socket_channel.dart';

class Playroom extends StatefulWidget {
  @override
  _PlayroomState createState() => _PlayroomState();
}

class _PlayroomState extends State<Playroom> {
  List<dynamic> board = List.filled(9, '');
  bool isconnectionclosed = false;
  @override
  Widget build(BuildContext context) {
    IOWebSocketChannel channel = IOWebSocketChannel.connect(
        Uri.parse("wss://tictactoeserver-1.onrender.com"),
        headers: {"token": player.token});

    return Scaffold(
      appBar: AppBar(
        title: Text('Tic-Tac-Toe'),
      ),
      body: StreamBuilder(
        stream: channel.stream,
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
                  Text(data?["message"] ?? ""),
                  Container(
                    height: 400,
                    child: GridView.builder(
                      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                        crossAxisCount: 3,
                      ),
                      itemCount: 9,
                      itemBuilder: (context, index) {
                        return buildGridCell(index, channel.sink);
                      },
                    ),
                  ),
                  ElevatedButton(
                    onPressed: () async {
                      await channel.sink.close();

                      setState(() {
                        isconnectionclosed = true;
                      });
                    },
                    child: Text("Replay"),
                  ),
                  ElevatedButton(
                    onPressed: () async {
                      await channel.sink.close();

                      Navigator.of(context)
                          .pushNamedAndRemoveUntil("home", (route) => false);
                    },
                    child: Text("end"),
                  ),
                ],
              );
            } else {
              return Center(
                child: Column(
                  children: [
                    Text("no Connection"),
                    ElevatedButton(
                        onPressed: () async {
                          await channel.sink.close();
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
                      await channel.sink.close();
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
      ),
    );
  }

  Widget buildGridCell(int index, WebSocketSink sink) {
    return GestureDetector(
      onTap: () {
        // Handle cell tap
        if (board[index] == '') {
          sink.add("${(index / 3).floor()} ${(index % 3)}");
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
