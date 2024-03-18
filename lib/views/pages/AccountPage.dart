import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:provider/provider.dart';
import 'package:tictactoe_client/entities/Player.dart';
import 'package:tictactoe_client/views/utils.dart';

class AccountPage extends StatefulWidget {
  const AccountPage({super.key});

  @override
  State<AccountPage> createState() => _AccountPageState();
}

class _AccountPageState extends State<AccountPage> {
  @override
  Widget build(BuildContext context) {
    final photourl = context.watch<PlayerState>().player?.photurl;
    final isEmailVerified =
        context.watch<PlayerState>().player?.isEmailVerified;
    return Scaffold(
        body: Center(
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
        context.watch<PlayerState>().player?.playername ?? "",
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
        height: SCREEN_HEIGHT * 0.005,
      ),
      Container(
        height: SCREEN_HEIGHT * 0.06,
        width: SCREEN_WIDTH,
        child: OutlinedButton(
          onPressed: () {},
          child: Text("Change Email"),
          style: OutlinedButton.styleFrom(
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(5))),
        ),
      ),
      SizedBox(
        height: SCREEN_HEIGHT * 0.005,
      ),
      Container(
        height: SCREEN_HEIGHT * 0.06,
        width: SCREEN_WIDTH,
        child: OutlinedButton(
          onPressed: () {},
          child: Text("Change Name"),
          style: OutlinedButton.styleFrom(
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(5))),
        ),
      )
    ])));
  }
}
