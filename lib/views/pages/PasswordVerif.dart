import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:tictactoe_client/entities/Player.dart';
import 'package:tictactoe_client/repositories/PlayerRepository.dart';
import 'package:tictactoe_client/views/utils.dart';

class PasswordVerif extends StatefulWidget {
  const PasswordVerif({Key? key}) : super(key: key);

  @override
  _PasswordVerifState createState() => _PasswordVerifState();
}

class _PasswordVerifState extends State<PasswordVerif> {
  TextEditingController passwordController = TextEditingController();
  bool isLoading = false;
  @override
  Widget build(BuildContext context) {
    final player = context.watch<PlayerState>().player;
    return Scaffold(
      appBar: AppBar(
        title: Text('Password Verification'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: SingleChildScrollView(
          child: Column(
            children: [
              SizedBox(
                height: SCREEN_HEIGHT * 0.2,
              ),
              Container(
                decoration: BoxDecoration(
                  border: Border.all(color: Colors.black),
                  borderRadius: BorderRadius.circular(10.0),
                ),
                padding: EdgeInsets.symmetric(horizontal: 16.0),
                child: TextField(
                  controller: passwordController,
                  decoration: InputDecoration(
                    hintText: 'Enter password',
                    border: InputBorder.none,
                  ),
                ),
              ),
              SizedBox(height: SCREEN_HEIGHT * 0.1),
              SizedBox(
                width: double.infinity,
                child: OutlinedButton(
                  onPressed: () async {
                    setState(() {
                      isLoading = true;
                    });
                    final token = await playerRepository.signIn(
                        email: player?.email ?? "",
                        password: passwordController.text);
                    print(token);

                    Navigator.of(context).pop(token != null);
                  },
                  style: ButtonStyle(
                    shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                      RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10.0),
                      ),
                    ),
                    side: MaterialStateProperty.all<BorderSide>(
                      BorderSide(color: Colors.pink),
                    ),
                  ),
                  child: Padding(
                    padding: const EdgeInsets.all(12.0),
                    child: Text(
                      'Verify',
                      style: TextStyle(
                        color: Colors.pink,
                        fontSize: 16.0,
                      ),
                    ),
                  ),
                ),
              ),
              SizedBox(
                height: SCREEN_HEIGHT * 0.05,
              ),
              (isLoading)
                  ? Container(
                      child: const CircularProgressIndicator(
                      color: Colors.pink,
                    ))
                  : const SizedBox()
            ],
          ),
        ),
      ),
    );
  }
}
