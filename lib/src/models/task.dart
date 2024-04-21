import 'package:isar/isar.dart';

part 'task.g.dart';

@collection
class Task {
  Id? id;
  String title;
  String description;
  bool checked;
  bool archived;
  bool trash;

  Task({
    required this.title,
    required this.description,
  })  : checked = false,
        archived = false,
        trash = false;
}
