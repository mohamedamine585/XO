import 'dart:typed_data';

class Player {
  String? playername;
  String email;
  String? token;
  int? score;
  int Wongames = 0;
  int Playedgames = 0;
  Uint8List? photoBytes;
  bool isEmailVerified = false;

  Player(this.playername, this.email, this.token, this.Playedgames,
      this.Wongames, this.score, this.photoBytes, this.isEmailVerified);
  factory Player.fromemail(email) {
    return Player(null, email, null, 0, 0, 0, null, false);
  }
}
