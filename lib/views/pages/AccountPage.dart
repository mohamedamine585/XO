import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:provider/provider.dart';
import 'package:tictactoe_client/entities/Player.dart';
import 'package:tictactoe_client/repositories/PlayerRepository.dart';
import 'package:tictactoe_client/views/utils.dart';

class AccountPage extends StatefulWidget {
  const AccountPage({super.key});

  @override
  State<AccountPage> createState() => _AccountPageState();
}

class _AccountPageState extends State<AccountPage> {
  TextEditingController emailcontroller = TextEditingController(),
      namecontroller = TextEditingController();
  bool namechanged = false, emailchanged = false;
  Player? player;
  @override
  void didChangeDependencies() {
    player = context.watch<PlayerState>().player;
    emailcontroller.text = player?.email ?? "";
    namecontroller.text = player?.playername ?? "";
    super.didChangeDependencies();
  }

  @override
  Widget build(BuildContext context) {
    final photourl = player?.photurl;

    final isEmailVerified = player?.isEmailVerified;
    return Scaffold(
        body: Center(
            child: SingleChildScrollView(
      child: Column(children: [
        Container(
          margin: EdgeInsets.only(top: SCREEN_HEIGHT * 0.1),
          child: Stack(
            children: [
              CircleAvatar(
                foregroundImage: (photourl != null)
                    ? Image.network(photourl).image
                    : const AssetImage("assets/images/man.png"),
                radius: 70,
              ),
              Positioned(
                  top: SCREEN_HEIGHT * 0.145,
                  left: SCREEN_WIDTH * 0.26,
                  child: Container(
                      height: SCREEN_HEIGHT * 0.03,
                      width: SCREEN_WIDTH * 0.07,
                      child: FloatingActionButton(
                        child: Icon(
                          Icons.camera,
                          color: Colors.white,
                        ),
                        onPressed: () {},
                        backgroundColor: Color.fromARGB(255, 112, 3, 163),
                      )))
            ],
          ),
        ),
        SizedBox(
          height: SCREEN_HEIGHT * 0.02,
        ),
        Text(
          player?.playername ?? "",
          style: Theme.of(context).textTheme.titleMedium,
        ),
        SizedBox(
          height: SCREEN_HEIGHT * 0.1,
        ),
        (isEmailVerified == false)
            ? Container(
                height: SCREEN_HEIGHT * 0.06,
                width: SCREEN_WIDTH,
                child: OutlinedButton(
                  onPressed: () {},
                  child: Text(
                    "Verify Email",
                    style: TextStyle(color: Colors.white),
                  ),
                  style: OutlinedButton.styleFrom(
                      backgroundColor: Color.fromARGB(255, 143, 25, 227),
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(5))),
                ),
              )
            : const SizedBox(),
        SizedBox(
          height: SCREEN_HEIGHT * 0.05,
        ),
        Row(
          children: [
            Container(
                margin: EdgeInsets.only(left: SCREEN_WIDTH * 0.01),
                width: SCREEN_WIDTH * 0.70,
                height: SCREEN_HEIGHT * 0.09,
                child: TextField(
                  decoration: InputDecoration(
                    border: OutlineInputBorder(),
                    labelText: 'Email',
                  ),
                  controller: emailcontroller,
                  onChanged: (value) {
                    setState(() {
                      emailchanged = player?.email != value;
                    });
                  },
                )),
            Container(
              width: SCREEN_WIDTH * 0.23,
              margin: EdgeInsets.only(left: SCREEN_WIDTH * 0.05),
              child: TextButton(
                style: TextButton.styleFrom(
                    disabledBackgroundColor: Color.fromARGB(186, 158, 72, 233),
                    shape: const RoundedRectangleBorder(
                        borderRadius: BorderRadius.all(Radius.circular(5))),
                    backgroundColor: MaterialStateColor.resolveWith(
                        (states) => Color.fromARGB(255, 87, 10, 160))),
                onPressed: (emailchanged) ? () async {} : null,
                child: const Text(
                  "Confirm",
                  style: TextStyle(color: Colors.white),
                ),
              ),
            )
          ],
        ),
        SizedBox(
          height: SCREEN_HEIGHT * 0.05,
        ),
        Row(
          children: [
            Container(
                margin: EdgeInsets.only(left: SCREEN_WIDTH * 0.01),
                width: SCREEN_WIDTH * 0.70,
                height: SCREEN_HEIGHT * 0.09,
                child: TextField(
                  decoration: InputDecoration(
                    border: OutlineInputBorder(),
                    labelText: 'Name',
                  ),
                  controller: namecontroller,
                  onChanged: (value) {
                    setState(() {
                      namechanged = player?.email != value;
                    });
                  },
                )),
            Container(
              width: SCREEN_WIDTH * 0.23,
              margin: EdgeInsets.only(left: SCREEN_WIDTH * 0.05),
              child: TextButton(
                style: TextButton.styleFrom(
                    disabledBackgroundColor: Color.fromARGB(186, 158, 72, 233),
                    shape: const RoundedRectangleBorder(
                        borderRadius: BorderRadius.all(Radius.circular(5))),
                    backgroundColor: MaterialStateColor.resolveWith(
                        (states) => Color.fromARGB(255, 87, 10, 160))),
                onPressed: (namechanged)
                    ? () async {
                        final playerdoc = await playerRepository.setName(
                            playername: namecontroller.text, player: player);
                        if (playerdoc?.isNotEmpty ?? false) {
                          context
                              .read<PlayerState>()
                              .setName(namecontroller.text);
                        }
                      }
                    : null,
                child: const Text(
                  "Confirm",
                  style: TextStyle(color: Colors.white),
                ),
              ),
            )
          ],
        ),
        SizedBox(
          height: SCREEN_HEIGHT * 0.1,
        ),
        Container(
          height: SCREEN_HEIGHT * 0.06,
          width: SCREEN_WIDTH,
          child: OutlinedButton(
            onPressed: () {},
            child: Text(
              "Delete Account",
              style: TextStyle(color: Colors.white),
            ),
            style: OutlinedButton.styleFrom(
                backgroundColor: Color.fromARGB(255, 227, 25, 35),
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(5))),
          ),
        )
      ]),
    )));
  }
}
