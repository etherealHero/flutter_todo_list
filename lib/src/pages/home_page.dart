import 'package:flutter/material.dart';

import '/src/app/layout.dart';
import '/src/app/repository.dart';
import '/src/pages/settings_page.dart';
import '/src/screens/archive_screen.dart';
import '/src/screens/tasks_screen.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => HomePageState();
}

class HomePageState extends State<HomePage> {
  String _selectedScreen = Screens.tasks.title;
  static final Map<String, ScreenLayout> _screens = {
    Screens.tasks.title: tasksScreen,
    // "Categories": Text('Categories'),
    Screens.archive.title: archiveScreen,
    // "Trash": const Text('Trash'),
  };

  void changeHomeScreen(Screens screen) {
    setState(() {
      _selectedScreen = screen.title;
    });
  }

  final repository = Repository();

  @override
  Widget build(BuildContext context) {
    var drawer = Drawer(
      child: Padding(
        padding: EdgeInsets.zero,
        child: Column(
          children: [
            DrawerHeader(
              decoration: BoxDecoration(
                color: Theme.of(context).primaryColor,
              ),
              child: const Align(
                alignment: Alignment.centerLeft,
                child: FlutterLogo(
                  size: 60,
                ),
              ),
            ),
            ListTile(
              leading: Screens.tasks.icon,
              title: Text(Screens.tasks.title),
              onTap: () {
                changeHomeScreen(Screens.tasks);
                Navigator.pop(context);
              },
            ),
            ListTile(
              leading: Screens.archive.icon,
              title: Text(Screens.archive.title),
              onTap: () {
                changeHomeScreen(Screens.archive);
                Navigator.pop(context);
              },
            ),
            const Spacer(),
            ListTile(
              leading: const Icon(Icons.settings),
              title: const Text('Settings'),
              onTap: () {
                Navigator.pop(context);
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => const SettingsPage()),
                );
              },
            ),
          ],
        ),
      ),
    );

    return Scaffold(
      appBar: AppBar(title: Text(_selectedScreen)),
      bottomNavigationBar: _screens[_selectedScreen]!.bottomNavigationBar,
      floatingActionButton: _screens[_selectedScreen]!.floatingActionButton,
      floatingActionButtonLocation:
          _screens[_selectedScreen]!.floatingActionButtonLocation,
      body: Center(
        child: _screens[_selectedScreen]!.screen,
      ),
      drawer: drawer,
    );
  }
}
