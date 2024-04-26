import 'package:flutter/material.dart';

class KeyboardController extends ChangeNotifier {
  bool isKeyboardVisible = false;
  void toggleKeyboard(bool value) {
    isKeyboardVisible = value;
    notifyListeners();
  }
}
