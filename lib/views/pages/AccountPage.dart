import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:tictactoe_client/views/ProviderSates/PlayerState.dart';
import 'package:image_picker/image_picker.dart';
import 'package:provider/provider.dart';
import 'package:tictactoe_client/entities/Player.dart';
import 'package:tictactoe_client/repositories/MetaDataRepository.dart';
import 'package:tictactoe_client/repositories/PlayerRepository.dart';
import 'package:tictactoe_client/views/Widgets/ImageWidget.dart';
import 'package:tictactoe_client/views/Widgets/TictactoePassword.dart';
import 'package:tictactoe_client/views/Widgets/verifyEmailButton.dart';
import 'package:tictactoe_client/views/dialogs/alertdialog.dart';
import 'package:tictactoe_client/views/dialogs/generaldialgo.dart';
import 'package:tictactoe_client/views/dialogs/namedialog.dart';
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
    final isEmailVerified = player?.isEmailVerified;
    return Scaffold(
        body: Center(
            child: SingleChildScrollView(
      child: Column(children: [
        Container(
          margin: EdgeInsets.only(top: SCREEN_HEIGHT * 0.1),
          width: 160,
          height: 160,
          child: Stack(
            children: [
              imageWidget(player, context, 80),
              Positioned(
                  top: 120,
                  left: 120,
                  child: Container(
                      height: SCREEN_HEIGHT * 0.05,
                      width: SCREEN_WIDTH * 0.1,
                      child: FloatingActionButton(
                        child: Icon(
                          Icons.camera,
                          color: Colors.white,
                        ),
                        onPressed: () async {
                          final image = await ImagePicker()
                              .pickImage(source: ImageSource.gallery);
                          if (image != null) {
                            final response = await showAdaptiveDialog(
                                barrierDismissible: false,
                                context: context,
                                builder: (context) => generaldialog(
                                    context,
                                    "Confirm Image",
                                    "Do you confirm using this photo as a profile photo",
                                    "yes",
                                    "no",
                                    CircleAvatar(
                                      foregroundImage:
                                          Image.file(File(image.path)).image,
                                    )));
                            if (response != null && response) {
                              final uploaded =
                                  await MetaDataRepository.uploadImage(
                                      image: File(image.path),
                                      token: player?.token ?? "");
                              (uploaded ?? false)
                                  ? context.read<PlayerState>().setPhoto(
                                      await File(image.path).readAsBytes())
                                  : null;

                              setState(() {});
                            }
                          }
                        },
                        backgroundColor: Color.fromARGB(255, 112, 3, 163),
                      )))
            ],
          ),
        ),
        SizedBox(
          height: SCREEN_HEIGHT * 0.02,
        ),
        Container(
          width: SCREEN_WIDTH * 0.7,
          child: Center(
            child: Text(
              context.watch<PlayerState>().player?.playername ?? "",
              style: Theme.of(context).textTheme.titleMedium,
              overflow: TextOverflow.ellipsis,
            ),
          ),
        ),
        SizedBox(
          height: SCREEN_HEIGHT * 0.1,
        ),
        !(isEmailVerified ?? false)
            ? verifyemailWidget(context, player?.token ?? "")
            : SizedBox(),
        SizedBox(
          height: SCREEN_HEIGHT * 0.05,
        ),
        Container(
          margin: EdgeInsets.only(left: SCREEN_WIDTH * 0.01),
          child: Row(
            children: [
              Container(
                  width: SCREEN_WIDTH * 0.70,
                  height: SCREEN_HEIGHT * 0.1,
                  child: Expanded(
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
                    ),
                  )),
              Container(
                width: SCREEN_WIDTH * 0.23,
                margin: EdgeInsets.only(left: SCREEN_WIDTH * 0.05),
                child: TextButton(
                  style: TextButton.styleFrom(
                      disabledBackgroundColor:
                          Color.fromARGB(186, 158, 72, 233),
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
        ),
        SizedBox(
          height: SCREEN_HEIGHT * 0.05,
        ),
        Container(
          margin: EdgeInsets.only(left: SCREEN_WIDTH * 0.01),
          child: Row(
            children: [
              Container(
                  width: SCREEN_WIDTH * 0.70,
                  height: SCREEN_HEIGHT * 0.1,
                  child: Expanded(
                    child: TextField(
                      decoration: InputDecoration(
                        border: OutlineInputBorder(),
                        labelText: 'Name',
                      ),
                      controller: namecontroller,
                      onChanged: (value) {
                        setState(() {
                          namechanged = player?.playername != value;
                        });
                      },
                    ),
                  )),
              Container(
                width: SCREEN_WIDTH * 0.23,
                margin: EdgeInsets.only(left: SCREEN_WIDTH * 0.05),
                child: TextButton(
                  style: TextButton.styleFrom(
                      disabledBackgroundColor:
                          Color.fromARGB(186, 158, 72, 233),
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
        ),
        SizedBox(
          height: SCREEN_HEIGHT * 0.15,
        ),
        Container(
            height: SCREEN_HEIGHT * 0.1,
            width: SCREEN_WIDTH * 0.95,
            child: OutlinedButton(
              style: OutlinedButton.styleFrom(
                backgroundColor: Color.fromARGB(255, 244, 244, 244),
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(5)),
              ),
              onPressed: () async {
                final passwordverif = await Navigator.of(context)
                    .pushNamed("passwordverif") as bool?;
                if (passwordverif ?? false) {
                  final password = await showDialog(
                      context: context,
                      builder: (context) =>
                          NameDialog(player, "your new password"));

                  await playerRepository.changePassword(
                      token: player?.token ?? "", password: password);
                }
              },
              child: const Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Icon(Icons.password),
                  Text("Change Password"),
                  Text(
                    ">",
                    style: TextStyle(fontSize: 30),
                  ),
                ],
              ),
            )),
        SizedBox(
          height: SCREEN_HEIGHT * 0.02,
        ),
        Container(
            height: SCREEN_HEIGHT * 0.1,
            width: SCREEN_WIDTH * 0.95,
            child: OutlinedButton(
              style: OutlinedButton.styleFrom(
                backgroundColor: Color.fromARGB(255, 244, 244, 244),
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(5)),
              ),
              onPressed: () async {
                final passwordverif = await Navigator.of(context)
                    .pushNamed("passwordverif") as bool?;
                if (passwordverif ?? false) {
                  await showDialog(
                      context: context,
                      builder: (context) {
                        return TictactoePasswordDialog(
                            token: player?.token,
                            email: player?.email ?? "",
                            onCreate: true);
                      });
                } else {
                  await showDialog(
                      context: context,
                      builder: (context) {
                        return generaldialog(context, "Error", "Wrong Password",
                            "OK", "Cancel", SizedBox());
                      });
                }
              },
              child: const Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Icon(Icons.grid_3x3),
                  Text("Use Tictactoe Password"),
                  Text(
                    ">",
                    style: TextStyle(fontSize: 30),
                  ),
                ],
              ),
            )),
        SizedBox(
          height: SCREEN_HEIGHT * 0.1,
        ),
        Container(
          height: SCREEN_HEIGHT * 0.08,
          width: SCREEN_WIDTH * 0.95,
          child: OutlinedButton(
            onPressed: () async {
              final confirmation = await showDialog(
                  context: context,
                  builder: (context) {
                    return alertdialog(context, "Do you want to logout");
                  });
              if (confirmation) {
                (await SharedPreferences.getInstance()).setString("token", "");
                Navigator.of(context)
                    .pushNamedAndRemoveUntil("router", (route) => false);
              }
            },
            child: Text(
              "Log out",
              style: TextStyle(color: Colors.white),
            ),
            style: OutlinedButton.styleFrom(
                backgroundColor: Color.fromARGB(255, 227, 25, 35),
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(5))),
          ),
        ),
        SizedBox(
          height: SCREEN_HEIGHT * 0.02,
        ),
        Container(
          height: SCREEN_HEIGHT * 0.08,
          width: SCREEN_WIDTH * 0.95,
          child: OutlinedButton(
            onPressed: () async {
              await showDialog(
                  context: context,
                  builder: (context) {
                    return alertdialog(
                        context, "do you want to delete account ?");
                  });
            },
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
