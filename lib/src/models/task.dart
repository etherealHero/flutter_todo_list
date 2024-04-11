class Task {
  final int id;
  String title;
  String description;
  bool checked;

  Task({
    required this.id,
    required this.title,
    required this.description,
  }) : checked = false;
}

final List<Task> tasks = [
  Task(id: 5, title: "Daily meeting with team", description: ""),
  Task(id: 4, title: "Pay for rent", description: "")..checked = true,
  Task(id: 3, title: "Check emails", description: ""),
  Task(id: 2, title: "Lunch with Emma", description: "Lorem ipsum dolor est"),
  Task(id: 1, title: "Meditation", description: ""),
];
