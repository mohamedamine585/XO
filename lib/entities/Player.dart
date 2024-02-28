import 'package:flutter/cupertino.dart';

class Player {
  String? playername;
  String email;
  String? token;
  int Wongames = 0;
  int Playedgames = 0;

  Player(
      this.playername, this.email, this.token, this.Playedgames, this.Wongames);
  factory Player.fromemail(email) {
    return Player(null, email, null, 0, 0);
  }
}

class PlayerState extends ChangeNotifier {
  Player? _player;

  Player? get player => _player;
  void setEmail(String email) {
    if (_player != null) {
      _player?.email = email;
    } else {
      _player = Player("", email, null, 0, 0);
    }
  }

  void setToken(String token) {
    if (_player != null) {
      _player?.token = token;
    } else {
      _player = Player("", "", token, 0, 0);
    }
    notifyListeners();
  }

  void setPlayer(Player? player) {
    _player = player;
    notifyListeners();
  }

  void setName(String playername) {
    if (_player != null) {
      _player?.playername = playername;
    } else {
      _player = Player(playername, "", null, 0, 0);
    }

    notifyListeners();
  }
}
