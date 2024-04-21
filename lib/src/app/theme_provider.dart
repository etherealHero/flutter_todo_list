import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

enum EThemeMode { light, system, dark }

class ThemeController extends ChangeNotifier {
  static const themePrefKey = 'theme';

  ThemeController(this._prefs) {
    _currentTheme = switch (_prefs.getString(themePrefKey)) {
      'system' => EThemeMode.system,
      'light' => EThemeMode.light,
      'dark' => EThemeMode.dark,
      _ => EThemeMode.system,
    };
  }

  final SharedPreferences _prefs;
  late EThemeMode _currentTheme;

  EThemeMode get currentTheme => _currentTheme;

  void setTheme(EThemeMode theme) {
    _currentTheme = theme;

    notifyListeners();

    _prefs.setString(themePrefKey, theme.name);
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
