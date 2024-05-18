import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'theme_provider.dart';

import '/src/models/bloc/tasks_bloc.dart';
import '/src/pages/home_page.dart';

class App extends StatelessWidget {
  const App({
    super.key,
    required ThemeController themeController,
  }) : _themeController = themeController;

  final ThemeController _themeController;

  static const _appTitle = 'ToDo List';

  @override
  Widget build(BuildContext context) {
    return ThemeProvider(
      controller: _themeController,
      builder: (context, _) => MaterialApp(
        theme: ThemeData(colorSchemeSeed: Colors.indigo),
        darkTheme: ThemeData(
          brightness: Brightness.dark,
          colorSchemeSeed: Colors.indigo,
        ),
        themeMode: _themeController.currentTheme,
        debugShowCheckedModeBanner: false,
        title: _appTitle,
        home: BlocProvider(
          create: (context) => TasksBloc(),
          child: const HomePage(),
        ),
      ),
    );
  }
}

class AppBlocObserver extends BlocObserver {
  /// {@macro app_bloc_observer}
  const AppBlocObserver();

  @override
  void onChange(BlocBase<dynamic> bloc, Change<dynamic> change) {
    super.onChange(bloc, change);
    // ignore: avoid_print
    if (bloc is Cubit) print(change);
  }

  @override
  void onTransition(
    Bloc<dynamic, dynamic> bloc,
    Transition<dynamic, dynamic> transition,
  ) {
    super.onTransition(bloc, transition);
    // ignore: avoid_print
    print(transition);
  }
}
