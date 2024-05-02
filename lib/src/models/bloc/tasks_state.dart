part of 'tasks_bloc.dart';

@immutable
sealed class TasksState {
  final List<Task> tasks;

  const TasksState({required this.tasks});
}

final class TasksStateFetchingTasks extends TasksState {
  TasksStateFetchingTasks() : super(tasks: <Task>[]);
}

final class TasksStateLoadedTasks extends TasksState {
  const TasksStateLoadedTasks({required super.tasks});
}
