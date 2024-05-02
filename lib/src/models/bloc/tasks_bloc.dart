import 'dart:async';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '/src/app/repository.dart';
import '/src/models/task.dart';

part 'tasks_event.dart';
part 'tasks_state.dart';

// TODO: из UI вынести логику в блок (переписать события под пользовательские события - смахнул влево/вправо и тп)
class TasksBloc extends Bloc<TasksEvent, TasksState> {
  TasksBloc() : super(TasksStateFetchingTasks()) {
    on<TasksEventGetTasks>(_getTasks);
    on<TasksEventAddTask>(_addTask);
    on<TasksEventUpdateTask>(_updateTask);
    on<TasksEventTrashTask>(_trashTask);
    on<TasksEventRestoreTask>(_restoreTask);
    on<TasksEventDeleteTask>(_deleteTask);
    on<TasksEventDeleteTrashTasks>(_deleteTrashTasks);

    add(TasksEventGetTasks());
  }

  final repository = Repository();

  FutureOr<void> _getTasks(
    TasksEventGetTasks event,
    Emitter<TasksState> emit,
  ) async {
    emit(TasksStateFetchingTasks());

    var tasks = await repository.getTasks();

    emit(TasksStateLoadedTasks(tasks: tasks));
  }

  FutureOr<void> _addTask(
    TasksEventAddTask event,
    Emitter<TasksState> emit,
  ) async {
    await repository.saveTask(event.newTask);

    var tasks = await repository.getTasks();

    emit(TasksStateLoadedTasks(tasks: tasks));
  }

  FutureOr<void> _updateTask(
    TasksEventUpdateTask event,
    Emitter<TasksState> emit,
  ) async {
    await repository.saveTask(event.modifiedTask);

    var tasks = await repository.getTasks();

    emit(TasksStateLoadedTasks(tasks: tasks));
  }

  FutureOr<void> _trashTask(
    TasksEventTrashTask event,
    Emitter<TasksState> emit,
  ) async {
    await repository.saveTask(event.task..trash = true);

    var tasks = await repository.getTasks();

    emit(TasksStateLoadedTasks(tasks: tasks));
  }

  FutureOr<void> _restoreTask(
    TasksEventRestoreTask event,
    Emitter<TasksState> emit,
  ) async {
    var task = state.tasks.firstWhere((t) => t.id! == event.taskId);

    task.archived = false;
    task.trash = false;

    await repository.saveTask(task);

    var tasks = await repository.getTasks();

    emit(TasksStateLoadedTasks(tasks: tasks));
  }

  FutureOr<void> _deleteTask(
    TasksEventDeleteTask event,
    Emitter<TasksState> emit,
  ) async {
    await repository.deleteTask(event.taskId);

    var tasks = await repository.getTasks();

    emit(TasksStateLoadedTasks(tasks: tasks));
  }

  FutureOr<void> _deleteTrashTasks(
    TasksEventDeleteTrashTasks event,
    Emitter<TasksState> emit,
  ) async {
    await repository.deleteTrashTasks();

    var tasks = await repository.getTasks();

    emit(TasksStateLoadedTasks(tasks: tasks));
  }
}
