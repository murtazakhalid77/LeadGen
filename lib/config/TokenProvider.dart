import 'package:flutter/material.dart';

class TokenProvider extends ChangeNotifier {
  late String _token;

  String get token => _token;

  void setToken(String newToken) {
    _token = newToken;
    notifyListeners();
  }
}
