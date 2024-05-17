import 'dart:typed_data';

import 'package:flutter/cupertino.dart';
import 'package:tictactoe_client/entities/Player.dart';

class PlayerState extends ChangeNotifier {
  static Player? _player;

  Player? get player => _player;
  void setEmail(Player? player, String email) {
    if (_player == null) {
      _player = Player("null", email, "", 0, 0, null, null, false);
    } else {
      _player = player;
      _player?.email = email;
    }
    notifyListeners();
  }

  void setToken(Player? player, String token) {
    if (_player == null) {
      _player = Player(null, "", token, 0, 0, null, null, false);
    } else {
      _player = player;
      _player?.token = token;
    }

    notifyListeners();
  }

  void setisEmailVerified(Player? player, bool isemailv) {
    if (_player == null) {
      _player = Player(null, "", "", 0, 0, null, Uint8List(8), isemailv);
    } else {
      _player = player;
      _player?.isEmailVerified = isemailv;
    }
    notifyListeners();
  }

  void setPlayer(Player? player) {
    final token = _player?.token;
    final photoBytes = _player?.photoBytes;
    _player = player;

    (_player?.token == null) ? _player?.token = token : null;
    (_player?.photoBytes == null) ? _player?.photoBytes = photoBytes : null;
    notifyListeners();
  }

  void setName(Player? player, String playername) {
    if (_player == null) {
      _player = Player(playername, "", "", 0, 0, null, Uint8List(0), false);
    } else {
      _player = player;
      _player?.playername = playername;
    }

    notifyListeners();
  }

  void setPhoto(Player? player, Uint8List photoBytes) {
    if (_player == null) {
      _player = Player("", "", "", 0, 0, null, photoBytes, false);
    } else {
      _player = player;
      _player?.photoBytes = photoBytes;
    }

    notifyListeners();
  }
}
