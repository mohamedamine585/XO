import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:qr_code_scanner/qr_code_scanner.dart';
import 'package:qr_flutter/qr_flutter.dart';
import 'package:tictactoe_client/data/gamesdata.dart';
import 'package:tictactoe_client/entities/Player.dart';
import 'package:tictactoe_client/utils.dart';

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
  String? roomid;
  QRViewController? _controller;
  final GlobalKey _qrKey = GlobalKey(debugLabel: 'QR');
  @override
  Widget build(BuildContext context) {
    final token = context.watch<PlayerState>().player?.token;
    if (isPlaying) {
      channel = IOWebSocketChannel.connect(
        Uri.parse("ws://$GAME_URL"),
        headers: {"Authorization": "Bearer ${token}", "roomid": roomid},
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
                    board = (data["grid"] != null)
                        ? data["grid"]
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
                    return Container(
                      margin: EdgeInsets.only(top: 50),
                      child: Column(
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
                          Container(
                            width: SCREEN_WIDTH * 0.7,
                            child: ElevatedButton(
                              onPressed: () async {
                                await channel?.sink.close();

                                setState(() {
                                  isPlaying = false;
                                });
                              },
                              child: Text("End game"),
                            ),
                          ),
                        ],
                      ),
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
                            if (token != null) {
                              roomid =
                                  await GamesData.getPlayroomid(token: token);
                            }
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
              child: Column(
                children: [
                  SizedBox(
                    height: SCREEN_HEIGHT * 0.3,
                  ),
                  Container(
                    width: SCREEN_WIDTH * 0.7,
                    child: ElevatedButton(
                        style: ButtonStyle(
                          elevation: MaterialStateProperty.all(10),
                        ),
                        onPressed: () async {
                          if (token != null) {
                            roomid =
                                await GamesData.getPlayroomid(token: token);
                          }

                          setState(() {
                            isPlaying = true;
                          });
                        },
                        child: const Text("Play")),
                  ),
                  Container(
                    width: SCREEN_WIDTH * 0.7,
                    child: ElevatedButton(
                        style: ButtonStyle(
                            elevation: MaterialStateProperty.all(10),
                            backgroundColor: MaterialStateProperty.all(
                                Color.fromARGB(239, 98, 7, 121))),
                        onPressed: () async {
                          if (token != null) {
                            roomid =
                                await GamesData.getPlayroomid(token: token);
                          }
                          if (roomid != null) {
                            await showDialog(
                                context: context,
                                builder: (context) {
                                  return Dialog(
                                    child: QrImageView(data: roomid ?? ""),
                                  );
                                });
                          }
                        },
                        child: const Text(
                          "Play With A Friend",
                          style: TextStyle(color: Colors.white),
                        )),
                  ),
                  SizedBox(
                    height: SCREEN_HEIGHT * 0.05,
                  ),
                  Container(
                      width: SCREEN_HEIGHT * 0.3,
                      height: SCREEN_WIDTH * 0.3,
                      child: IconButton(
                        onPressed: () async {
                          showDialog(
                              context: context,
                              builder: (context) {
                                return Dialog(
                                  child: QRView(
                                      key: _qrKey,
                                      onQRViewCreated: _onQRViewCreated),
                                );
                              });
                        },
                        icon: Image.asset("assets/images/qrcode.png"),
                      ))
                ],
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

  void _onQRViewCreated(QRViewController controller) {
    setState(() {
      _controller = controller;
    });

    controller.scannedDataStream.listen((scanData) {
      setState(() {
        roomid = scanData.code;
      });
    });
  }
}
