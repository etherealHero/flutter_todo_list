import 'package:flutter/material.dart';
import 'package:flutter_sandbox/src/pages/settings_page.dart';

import '../screens/tasks_screen.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  String _selectedScreen = "Tasks";
  static final Map<String, Widget> _screens = {
    "Tasks": const TasksScreen(),
    // TODO: add screens
    // "Categories": Text('Categories'),
    // "Archive": const Text('Archive'),
    // "Trash": const Text('Trash'),
  };

  void _onItemTapped(String screen) {
    setState(() {
      _selectedScreen = screen;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text(_selectedScreen)),
      body: Center(
        child: _screens[_selectedScreen],
      ),
      drawer: Drawer(
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
              ListTile(
                leading: const Icon(Icons.settings),
                title: const Text('Settings'),
                onTap: () {
                  Navigator.pop(context);
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => const SettingsPage()),
                  );
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}
