import 'package:flutter/material.dart';

import '/src/app/theme_provider.dart';
import '/src/app/repository.dart';

class SettingsPage extends StatefulWidget {
  const SettingsPage({super.key});

  @override
  State<SettingsPage> createState() => _SettingsPageState();
}

class _SettingsPageState extends State<SettingsPage> {
  final repository = Repository();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: const BackButton(),
        title: const Text('Settings'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(15.0),
        child: Column(
          children: <Widget>[
            Row(
              children: [
                const Text('Dark mode'),
                const SizedBox(width: 10),
                Switch(
                  onChanged: (bool value) {
                    if (ThemeController.of(context).currentTheme == "dark") {
                      ThemeController.of(context).setTheme("light");
                    } else {
                      ThemeController.of(context).setTheme("dark");
                    }
                    setState(() {});
                  },
                  value: ThemeController.of(context).currentTheme == "dark",
                ),
              ],
            ),
            const Spacer(),
            ListTile(
              leading: const Icon(Icons.restart_alt),
              title: const Text('Migrate'),
              onTap: () {
                Navigator.pop(context);
                repository.migrate();
              },
            ),
          ],
        ),
      ),
    );
  }
}
