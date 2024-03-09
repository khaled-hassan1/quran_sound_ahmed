import 'package:flutter/material.dart';

class LangProvider extends ChangeNotifier {
  bool _isArabic = false;

  bool get isArabic => _isArabic;

  void toggleLan() {
    _isArabic = !_isArabic;
    notifyListeners();
  }
}
