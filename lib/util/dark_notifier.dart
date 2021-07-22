import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class DarkNotifier with ChangeNotifier {
  PrefsState _currentPrefs = const PrefsState();

  DarkNotifier() {
    _loadDarkPref();
  }

  Future<void> _loadDarkPref() async {
    await SharedPreferences.getInstance().then((prefs) {
      final bool darkPref = prefs.getBool('isDark') ?? false;
      _currentPrefs = PrefsState(darkMode: darkPref);
    });

    notifyListeners();
  }

  Future<void> _saveDarkPref() async {
    await SharedPreferences.getInstance().then((prefs) {
      prefs.setBool('isDark', _currentPrefs.darkMode);
    });
  }

  bool get isDark => _currentPrefs.darkMode;

  set darkMode(bool newValue) {
    if (newValue == _currentPrefs.darkMode) return;
    _currentPrefs = PrefsState(darkMode: newValue);
    notifyListeners();
    _saveDarkPref();
  }
}

class PrefsState {
  final bool darkMode;

  const PrefsState({this.darkMode = false});
}
