import 'package:flutter/material.dart';
import 'package:act_steel_frontend/services/storage.dart';

class LoginInfo extends ChangeNotifier {
  String get token => Storage().token;
  bool get loggedIn => Storage().token.isNotEmpty;

  void logout() {
    Storage().clearToken();
    notifyListeners();
  }
}
