import 'package:isar/isar.dart';

part 'task.g.dart';

@collection
class Task {
  Id? id;
  String title;
  String description;
  bool checked;

  Task({
    required this.title,
    required this.description,
  }) : checked = false;
}

final List<Task> tasks = [
  Task(title: "Daily meeting with team", description: ""),
  Task(title: "Pay for rent", description: "")..checked = true,
  Task(title: "Check emails", description: ""),
  Task(title: "Lunch with Emma", description: "Lorem ipsum dolor est"),
  Task(title: "Meditation", description: ""),
];
