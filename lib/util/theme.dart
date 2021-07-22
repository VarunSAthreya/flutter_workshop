import 'package:flutter/material.dart';

class Styles {
  static ThemeData themeData({
    required bool isDark,
  }) {
    return ThemeData(
      primarySwatch: Colors.red,
      primaryColor: Colors.red,
      accentColor: isDark ? const Color(0xFF161B22) : Colors.white,
      backgroundColor:
          isDark ? const Color(0xFF010409) : const Color(0xFFEEEEEE),
      brightness: isDark ? Brightness.dark : Brightness.light,
      visualDensity: VisualDensity.adaptivePlatformDensity,
    );
  }
}
