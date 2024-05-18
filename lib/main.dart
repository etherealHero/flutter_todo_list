import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'src/app/repository.dart';
import 'src/app/theme_provider.dart';
import 'src/app/app.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  final prefs = await SharedPreferences.getInstance();

  await Repository().performMigrationIfNeeded(prefs);

  Bloc.observer = const AppBlocObserver();

  runApp(App(
    themeController: ThemeController(prefs),
  ));
}
