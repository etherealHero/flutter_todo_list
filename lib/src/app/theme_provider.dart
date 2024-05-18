import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class ThemeController extends ChangeNotifier {
  static const themePrefKey = 'theme';

  ThemeController(this._prefs) {
    _currentTheme = switch (_prefs.getString(themePrefKey)) {
      'system' => ThemeMode.system,
      'light' => ThemeMode.light,
      'dark' => ThemeMode.dark,
      _ => ThemeMode.system,
    };
  }

  final SharedPreferences _prefs;
  late ThemeMode _currentTheme;

  ThemeMode get currentTheme => _currentTheme;

  void setTheme(ThemeMode theme) {
    _currentTheme = theme;
    _prefs.setString(themePrefKey, theme.name);
    notifyListeners();
  }

  static ThemeController of(BuildContext context) {
    final provider = context.getInheritedWidgetOfExactType<ThemeProvider>();
    return (provider as ThemeProvider).controller;
  }
}

class ThemeProvider extends InheritedWidget {
  ThemeProvider({
    super.key,
    required this.controller,
    required Widget Function(BuildContext, Widget?) builder,
  }) : super(child: AnimatedBuilder(animation: controller, builder: builder));

  final ThemeController controller;

  @override
  bool updateShouldNotify(ThemeProvider oldWidget) =>
      controller != oldWidget.controller;
}
