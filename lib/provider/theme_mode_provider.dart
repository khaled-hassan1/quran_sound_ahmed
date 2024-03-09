import 'package:flutter/material.dart';

class ThemeModeProvider extends ChangeNotifier {
  bool _isDark = false;

  bool get isDark => _isDark;

  void toggleDarkMode() {
    _isDark = !_isDark;
    notifyListeners();
  }


}
