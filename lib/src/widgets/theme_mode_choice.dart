import 'package:flutter/material.dart';

import '/src/app/theme_provider.dart';

class ChoiceTheme extends StatefulWidget {
  const ChoiceTheme({super.key});

  @override
  State<ChoiceTheme> createState() => _ChoiceThemeState();
}

class _ChoiceThemeState extends State<ChoiceTheme> {
  @override
  Widget build(BuildContext context) {
    return SegmentedButton(
      segments: <ButtonSegment<ThemeMode>>[
        ButtonSegment(
            value: ThemeMode.light, label: Text(ThemeMode.light.name)),
        ButtonSegment(
            value: ThemeMode.system, label: Text(ThemeMode.system.name)),
        ButtonSegment(value: ThemeMode.dark, label: Text(ThemeMode.dark.name)),
      ],
      selected: {ThemeController.of(context).currentTheme},
      onSelectionChanged: (Set<ThemeMode> newSelection) => setState(() {
        ThemeController.of(context).setTheme(newSelection.first);
      }),
    );
  }
}
