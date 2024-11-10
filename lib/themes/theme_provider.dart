import "package:atb_music_player/themes/dark.dart";
import "package:atb_music_player/themes/light.dart";
import "package:flutter/material.dart";

class ThemeProvider extends ChangeNotifier {
  // Default theme is light mode
  ThemeData _themeData = lightMode;

  // Function to change the theme
  ThemeData get themeData => _themeData;

  // function to check the current page on bottom navigation bar
  int _currentPageIndex = 0;

  int get currentPageIndex => _currentPageIndex;

  set currentPageIndex(int index) {
    _currentPageIndex = index;
    notifyListeners();
    print("Current Page Index: $index");
  }

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
