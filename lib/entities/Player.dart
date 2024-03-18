import 'package:flutter/cupertino.dart';

class Player {
  String? playername;
  String email;
  String? token;
  int? score;
  int Wongames = 0;
  int Playedgames = 0;
  String? photurl;
  bool isEmailVerified = false;

  Player(this.playername, this.email, this.token, this.Playedgames,
      this.Wongames, this.score, this.photurl, this.isEmailVerified);
  factory Player.fromemail(email) {
    return Player(null, email, null, 0, 0, 0, "", false);
  }
}

class PlayerState extends ChangeNotifier {
  Player? _player;

  Player? get player => _player;
  void setEmail(String email) {
    _player?.email = email;
    notifyListeners();
  }

  void setToken(String token) {
    _player?.token = token;

    notifyListeners();
  }

  void setisEmailVerified(bool isemailv) {
    _player?.isEmailVerified = isemailv;

    notifyListeners();
  }

  void setPlayer(Player? player) {
    _player = player;
    notifyListeners();
  }

  void setName(String playername) {
    _player?.playername = playername;

    notifyListeners();
  }

  void setPhotoUrl(String photurl) {
    _player?.photurl = photurl;

    notifyListeners();
  }
}
