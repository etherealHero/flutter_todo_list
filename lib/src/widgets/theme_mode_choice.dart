import 'package:flutter/material.dart';

import '/src/app/layout.dart';
import '/src/app/theme_provider.dart';

class ThemeModeChoice extends StatefulWidget {
  const ThemeModeChoice({super.key});

  @override
  State<ThemeModeChoice> createState() => _ThemeModeChoiceState();
}

class _ThemeModeChoiceState extends State<ThemeModeChoice> {
  @override
  Widget build(BuildContext context) {
    return SegmentedButton<EThemeMode>(
      segments: <ButtonSegment<EThemeMode>>[
        ButtonSegment<EThemeMode>(
          value: EThemeMode.light,
          label: Text(EThemeMode.light.name.toCapitalized()),
        ),
        ButtonSegment<EThemeMode>(
          value: EThemeMode.system,
          label: Text(EThemeMode.system.name.toCapitalized()),
        ),
        ButtonSegment<EThemeMode>(
          value: EThemeMode.dark,
          label: Text(EThemeMode.dark.name.toCapitalized()),
        ),
      ],
      selected: <EThemeMode>{ThemeController.of(context).currentTheme},
      onSelectionChanged: (Set<EThemeMode> newSelection) {
        setState(() {
          ThemeController.of(context).setTheme(newSelection.first);
        });
      },
    );
  }
}
