import 'package:flutter/cupertino.dart';

class HomePageState extends ChangeNotifier {
  bool _isGameHistory = true;
  bool get isGameHistory => _isGameHistory;
  void setIsGameHistory(bool value) {
    _isGameHistory = value;
    notifyListeners();
  }
}
