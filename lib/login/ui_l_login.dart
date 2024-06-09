import 'package:todo_app/login/c_login.dart';
import 'package:flutter/material.dart';

class UILoginLogin extends ChangeNotifier {
  String? id;

  bool buttonEnable = true;

  final userName = TextEditingController();
  final password = TextEditingController();
  final controller = LoginController();

  UILoginLogin() {
    userName.addListener(_updateButtonState);
    password.addListener(_updateButtonState);
  }

  void _updateButtonState() {
    notifyListeners();
  }

  Future<void> fetchData() async {
    buttonEnable = false;
    notifyListeners();
    id = await controller.loginUser(userName.text, password.text);
    buttonEnable = true;
    notifyListeners();
  }
}
