import 'package:flutter/material.dart';

class ThemeController extends ChangeNotifier {
  bool isDark = false;
  void changeTheme() {
    isDark = !isDark;
    notifyListeners();
  }
}
