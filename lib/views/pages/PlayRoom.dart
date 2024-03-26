import 'dart:convert';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:provider/provider.dart';
import 'package:qr_code_scanner/qr_code_scanner.dart';
import 'package:qr_flutter/qr_flutter.dart';
import 'package:tictactoe_client/data/gamesdata.dart';
import 'package:tictactoe_client/entities/Player.dart';
import 'package:tictactoe_client/utils.dart';
import 'package:tictactoe_client/views/Widgets/ImageWidget.dart';
import 'package:tictactoe_client/views/Widgets/opponentinfowidget.dart';

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
  String? opponentid;
  final GlobalKey _qrKey = GlobalKey(debugLabel: 'QR');

  @override
  void dispose() async {
    await channel?.sink.close();
    super.dispose();
  }

  @override
  void initState() {
    existingimage = null;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final player = context.watch<PlayerState>().player;
    final token = player?.token;

    if (isPlaying && roomid != null && token != null) {
      channel = IOWebSocketChannel.connect(
        Uri.parse("wss://$GAME_URL"),
        headers: {"Authorization": "Bearer $token", "roomid": roomid},
      );
      roomid = null;
    }
    return Scaffold(
      body: (isPlaying)
          ? SingleChildScrollView(
              child: StreamBuilder(
                stream: channel?.stream,
                builder: (context, snapshot) {
                  if ((snapshot.connectionState != ConnectionState.none)) {
                    if (snapshot.hasData) {
                      Map<String, dynamic> data = json.decode(snapshot.data);
                      opponentid = (data["oppoenentid"] != null)
                          ? data["oppoenentid"]
                          : opponentid;

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
                            Center(
                              child: Container(
                                  width: SCREEN_WIDTH * 0.8,
                                  child: Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: [
                                      Container(
                                        child: Column(children: [
                                          imageWidget(player, context, 30),
                                          Text(player?.playername ?? "Unknown")
                                        ]),
                                      ),
                                      Container(
                                        width: SCREEN_WIDTH * 0.3,
                                        child: Row(
                                          children: [
                                            SizedBox(
                                              width: SCREEN_WIDTH * 0.1,
                                            ),
                                            const Text("VS."),
                                          ],
                                        ),
                                      ),
                                      Container(
                                        child: Column(children: [
                                          imageWidgetFromBytes(
                                            opponentid ?? "",
                                            player?.token ?? "",
                                            30,
                                          ),
                                          opponentinfoWidget(
                                              opponentid, player?.token ?? "")
                                        ]),
                                      ),
                                    ],
                                  )),
                            ),
                            SizedBox(height: SCREEN_HEIGHT * 0.05),
                            Text(data["message"] ?? ""),
                            Container(
                              height: SCREEN_HEIGHT * 0.55,
                              child: GridView.builder(
                                gridDelegate:
                                    const SliverGridDelegateWithFixedCrossAxisCount(
                                  crossAxisCount: 3,
                                ),
                                itemCount: 9,
                                itemBuilder: (context, index) {
                                  return buildGridCell(index, channel?.sink);
                                },
                              ),
                            ),
                            SizedBox(
                              height: SCREEN_HEIGHT * 0.01,
                            ),
                            Container(
                              width: SCREEN_WIDTH * 0.7,
                              child: ElevatedButton(
                                style: ElevatedButton.styleFrom(
                                    backgroundColor: Colors.purple),
                                onPressed: () async {
                                  await channel?.sink.close();
                                  existingimage = null;

                                  setState(() {
                                    opponentid = null;
                                    isPlaying = false;
                                  });
                                },
                                child: const Text(
                                  "End game",
                                  style: TextStyle(color: Colors.white),
                                ),
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
                                roomid = await GamesData.getPlayroomid(
                                    token: token, withAFriend: false);
                              }
                            },
                            child: Text("Replay"),
                          ),
                        ],
                      ),
                    );
                  }
                },
              ),
            )
          : Center(
              child: SingleChildScrollView(
                child: Column(
                  children: [
                    SizedBox(
                      height: SCREEN_HEIGHT * 0.1,
                    ),
                    Container(
                      width: SCREEN_WIDTH * 0.7,
                      child: ElevatedButton(
                          style: ButtonStyle(
                            elevation: MaterialStateProperty.all(10),
                          ),
                          onPressed: () async {
                            if (token != null) {
                              roomid = await GamesData.getPlayroomid(
                                  token: token, withAFriend: false);
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
                              roomid = await GamesData.getPlayroomid(
                                  token: token, withAFriend: true);
                            }
                            if (roomid != null) {
                              showDialog(
                                  context: context,
                                  builder: (context) {
                                    return Dialog(
                                      child: QrImageView(data: roomid ?? ""),
                                    );
                                  });
                              setState(() {
                                isPlaying = true;
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
                                    backgroundColor: Colors.transparent,
                                    child: QRView(
                                        key: _qrKey,
                                        onQRViewCreated: _onQRViewCreated),
                                  );
                                });
                          },
                          icon: Image.asset("assets/images/qrcode.png"),
                        )),
                    Container(
                      child: const Text(
                        "Scan And Join",
                        style: TextStyle(color: Colors.purple),
                      ),
                    )
                  ],
                ),
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
      print(scanData.code);
      setState(() {
        roomid = scanData.code;
        isPlaying = true;
      });
    });
  }
}
