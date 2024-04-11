import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class ThemeController extends ChangeNotifier {
  static const themePrefKey = 'theme';

  ThemeController(this._prefs) {
    _currentTheme = _prefs.getString(themePrefKey) ?? 'light';
  }

  final SharedPreferences _prefs;
  late String _currentTheme;

  String get currentTheme => _currentTheme;

  void setTheme(String theme) {
    _currentTheme = theme;

    notifyListeners();

    _prefs.setString(themePrefKey, theme);
  }

  static ThemeController of(BuildContext context) {
    final provider =
        context.getInheritedWidgetOfExactType<ThemeControllerProvider>()
            as ThemeControllerProvider;
    return provider.controller;
  }
}

class ThemeControllerProvider extends InheritedWidget {
  const ThemeControllerProvider(
      {super.key, required this.controller, required super.child});

  final ThemeController controller;

  @override
  bool updateShouldNotify(ThemeControllerProvider oldWidget) =>
      controller != oldWidget.controller;
}
