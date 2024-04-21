import 'package:flutter/material.dart';

import '/src/app/layout.dart';
import '/src/app/repository.dart';
import '/src/pages/settings_page.dart';
import '/src/screens/trash_screen.dart';
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
    Screens.trash.title: trashScreen,
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
            _buildMenuItem(context, Screens.tasks),
            _buildMenuItem(context, Screens.archive),
            const Divider(),
            _buildMenuItem(context, Screens.trash),
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

  ListTile _buildMenuItem(BuildContext context, Screens screen) {
    return ListTile(
      leading: screen.icon,
      title: Text(screen.title),
      onTap: () {
        changeHomeScreen(screen);
        Navigator.pop(context);
      },
    );
  }
}
