import 'package:flutter/material.dart';

import 'theme_provider.dart';
import '/src/pages/home_page.dart';

class App extends StatelessWidget {
  const App({super.key, required this.themeController});

  final ThemeController themeController;

  static const _appTitle = 'ToDo List';

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
      animation: themeController,
      builder: (context, _) {
        return ThemeControllerProvider(
          controller: themeController,
          child: MaterialApp(
            theme: ThemeData(
              useMaterial3: true,
              colorSchemeSeed: Colors.indigo,
            ),
            darkTheme: ThemeData(
              useMaterial3: true,
              brightness: Brightness.dark,
              colorSchemeSeed: Colors.indigo,
            ),
            themeMode: _buildCurrentTheme(),
            debugShowCheckedModeBanner: false,
            title: _appTitle,
            home: const HomePage(),
          ),
        );
      },
    );
  }

  ThemeMode _buildCurrentTheme() {
    switch (themeController.currentTheme) {
      case EThemeMode.dark:
        return ThemeMode.dark;
      case EThemeMode.light:
        return ThemeMode.light;
      case EThemeMode.system:
      default:
        return ThemeMode.system;
    }
  }
}
