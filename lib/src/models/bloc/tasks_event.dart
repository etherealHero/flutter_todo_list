part of 'tasks_bloc.dart';

@immutable
sealed class TasksEvent {}

class TasksEventGetTasks extends TasksEvent {}

class TasksEventAddTask extends TasksEvent {
  final Task newTask;

  TasksEventAddTask({required this.newTask});
}

class TasksEventUpdateTask extends TasksEvent {
  final Task modifiedTask;

  TasksEventUpdateTask({required this.modifiedTask});
}

class TasksEventTrashTask extends TasksEvent {
  final Task task;

  TasksEventTrashTask({required this.task});
}

class TasksEventRestoreTask extends TasksEvent {
  final int taskId;

  TasksEventRestoreTask({required this.taskId});
}

class TasksEventDeleteTask extends TasksEvent {
  final int taskId;

  TasksEventDeleteTask({required this.taskId});
}

class TasksEventDeleteTrashTasks extends TasksEvent {}
