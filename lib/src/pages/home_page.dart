import 'package:flutter/material.dart';

import '/src/app/layout.dart';
import '/src/app/repository.dart';
import '/src/pages/settings_page.dart';
import '/src/screens/tasks_screen.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  String _selectedScreen = "Tasks";
  static final Map<String, Screen> _screens = {
    "Tasks": tasksScreen,
    // "Categories": Text('Categories'),
    // "Archive": const Text('Archive'),
    // "Trash": const Text('Trash'),
  };

  void _onItemTapped(String screen) {
    setState(() {
      _selectedScreen = screen;
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
              leading: const Icon(Icons.task_alt),
              title: const Text('Tasks'),
              selected: _selectedScreen == "Tasks",
              onTap: () {
                _onItemTapped("Tasks");
                Navigator.pop(context);
              },
            ),
            const Spacer(),
            // ListTile(
            //   leading: const Icon(Icons.restart_alt),
            //   title: const Text('Mock tasks'),
            //   onTap: () {
            //     Navigator.pop(context);
            //     repository.mockTasks();
            //   },
            // ),
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
