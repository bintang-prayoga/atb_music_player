import "package:atb_music_player/themes/dark.dart";
import "package:atb_music_player/themes/light.dart";
import "package:flutter/material.dart";

class ThemeProvider extends ChangeNotifier {
  // Default theme is light mode
  ThemeData _themeData = lightMode;

  // Function to change the theme
  ThemeData get themeData => _themeData;

  bool get isDarkMode => _themeData == darkMode;

  set themeData(ThemeData themeData) {
    _themeData = themeData;
    notifyListeners();
  }

  void toggleTheme() {
    _themeData = isDarkMode ? lightMode : darkMode;
    notifyListeners();
  }
}
