import 'package:flutter/material.dart';

class ScreenLayout {
  ScreenLayout({
    required this.screen,
    this.bottomNavigationBar,
    this.floatingActionButton,
    this.floatingActionButtonLocation,
  });

  final Widget screen;
  final Widget? bottomNavigationBar;
  final Widget? floatingActionButton;
  final FloatingActionButtonLocation? floatingActionButtonLocation;
}

enum Screens {
  tasks(title: "Tasks", icon: Icon(Icons.library_add_check_outlined)),
  trash(title: "Trash", icon: Icon(Icons.delete_outline_rounded)),
  archive(title: "Archive", icon: Icon(Icons.archive_outlined));

  const Screens({
    required this.title,
    required this.icon,
  });

  final String title;
  final Icon icon;
}

extension StringCasingExtension on String {
  String toCapitalized() =>
      length > 0 ? '${this[0].toUpperCase()}${substring(1).toLowerCase()}' : '';
  String toTitleCase() => replaceAll(RegExp(' +'), ' ')
      .split(' ')
      .map((str) => str.toCapitalized())
      .join(' ');
}
