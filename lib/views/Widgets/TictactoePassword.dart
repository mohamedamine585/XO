import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:tictactoe_client/repositories/PlayerRepository.dart';
import 'package:tictactoe_client/views/dialogs/alertdialog.dart';
import 'package:tictactoe_client/views/dialogs/generaldialgo.dart';
import 'package:tictactoe_client/views/utils.dart';

class TictactoePasswordDialog extends StatefulWidget {
  String email;
  bool onCreate;
  String? token;
  TictactoePasswordDialog(
      {super.key,
      required this.email,
      required this.onCreate,
      required this.token});

  @override
  State<TictactoePasswordDialog> createState() =>
      _TictactoePasswordDialogState();
}

class _TictactoePasswordDialogState extends State<TictactoePasswordDialog> {
  List<int> tictactoe = [];
  bool isloading = false;

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Column(
        children: [
          Container(
            margin: EdgeInsets.only(top: SCREEN_HEIGHT * 0.05),
            width: SCREEN_HEIGHT * 0.9,
            height: SCREEN_HEIGHT * 0.43,
            child: Dialog(
              child: GridView.builder(
                gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 3, childAspectRatio: 1),
                itemCount: 9,
                itemBuilder: (context, index) {
                  return Container(
                    child: GestureDetector(
                        onTap: () async {
                          if (!tictactoe.contains(index)) {
                            setState(() {
                              tictactoe.add(index);
                            });
                            if (tictactoe.length >= 4) {
                              setState(() {
                                isloading = true;
                              });
                              final newtoken = (widget.onCreate)
                                  ? null
                                  : await playerRepository.ticSignIn(
                                      email: widget.email,
                                      tictactoe: tictactoe);
                              print(newtoken);
                              setState(() {
                                isloading = false;
                              });
                              if (newtoken != null && newtoken != "") {
                                Navigator.of(context).pop(newtoken);
                              }
                            }
                          }
                        },
                        child: Container(
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.only(
                              topLeft: Radius.circular((index == 0) ? 25 : 0),
                              topRight: Radius.circular((index == 2) ? 25 : 0),
                              bottomLeft:
                                  Radius.circular((index == 6) ? 25 : 0),
                              bottomRight:
                                  Radius.circular((index == 8) ? 25 : 0),
                            ),
                            border: Border.all(
                              color: Color.fromARGB(255, 92, 4, 114),
                            ),
                          ),
                          child: Center(
                            child: Text(
                              (tictactoe.contains(index)) ? "X" : "",
                              style: const TextStyle(
                                color: Colors.pink,
                                fontSize: 40,
                              ),
                            ),
                          ),
                        )),
                  );
                },
              ),
            ),
          ),
          ElevatedButton(
            style: ButtonStyle(
                backgroundColor: MaterialStateColor.resolveWith(
                    (states) => Color.fromARGB(255, 193, 45, 136)),
                shape: MaterialStateProperty.all(RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10))),
                fixedSize: MaterialStateProperty.all(
                    Size(SCREEN_WIDTH * 0.3, SCREEN_HEIGHT * 0.05))),
            onPressed: () async {
              setState(() {
                tictactoe.removeLast();
              });
            },
            child: const Text(
              "< Back",
              style: TextStyle(color: Colors.white),
            ),
          ),
          SizedBox(
            height: SCREEN_HEIGHT * 0.05,
          ),
          (widget.onCreate)
              ? ElevatedButton(
                  style: ButtonStyle(
                      backgroundColor: MaterialStateColor.resolveWith(
                          (states) => Color.fromARGB(255, 193, 45, 136)),
                      shape: MaterialStateProperty.all(RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(10))),
                      fixedSize: MaterialStateProperty.all(
                          Size(SCREEN_WIDTH * 0.65, SCREEN_HEIGHT * 0.05))),
                  onPressed: () async {
                    if (tictactoe.length >= 4) {
                      setState(() {
                        isloading = true;
                      });
                      final newtoken = await playerRepository.ticSignUp(
                          email: widget.email,
                          token: widget.token ?? "",
                          tictactoe: tictactoe);

                      setState(() {
                        isloading = false;
                      });
                      Navigator.of(context).pop(newtoken);
                    } else {
                      await showDialog(
                          context: context,
                          builder: (context) {
                            return generaldialog(
                                context,
                                "Error",
                                "Tictactoe must be at least 4 tics",
                                "OK",
                                "Cancel",
                                SizedBox());
                          });
                    }
                  },
                  child: const Text(
                    "Set Tictactoe Password",
                    style: TextStyle(color: Colors.white),
                  ),
                )
              : const SizedBox(),
          (isloading && !widget.onCreate)
              ? Container(
                  child: CircularProgressIndicator(),
                )
              : const SizedBox()
        ],
      ),
    );
  }
}
