import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_slidable/flutter_slidable.dart';

import '/src/app/layout.dart';
import '/src/models/bloc/tasks_bloc.dart';
import '/src/models/task.dart';
import '/src/widgets/task_card.dart';
import '/src/widgets/add_task_form.dart';

var tasksScreen = ScreenLayout(
  screen: const TasksScreen(),
  bottomNavigationBar: const TasksBottomBar(),
);

class TasksScreen extends StatelessWidget {
  const TasksScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        BlocBuilder<TasksBloc, TasksState>(
          builder: (context, state) {
            if (state is TasksStateFetchingTasks) {
              return const CircularProgressIndicator();
            }

            if (state is TasksStateLoadedTasks && state.tasks.isNotEmpty) {
              Iterable<Task> tasks = state.tasks.where(
                (t) => !t.archived && !t.trash,
              );

              if (tasks.isNotEmpty) {
                return Expanded(
                  child: SlidableAutoCloseBehavior(
                    child: ListView(
                      children: tasks.map((task) => TaskCard(task)).toList(),
                    ),
                  ),
                );
              } else {
                return Expanded(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        'Task list is empty',
                        textAlign: TextAlign.center,
                        style: Theme.of(context).textTheme.titleLarge,
                      ),
                      const SizedBox(height: 10),
                      TextButton.icon(
                        onPressed: () => Scaffold.of(context).showBottomSheet(
                          (context) => const TaskForm(title: "Add new task"),
                          enableDrag: false,
                        ),
                        icon: const Icon(Icons.add),
                        label: const Text("Create first task"),
                      )
                    ],
                  ),
                );
              }
            }

            return const Text('lorem');
          },
        ),
      ],
    );
  }
}

class TasksBottomBar extends StatelessWidget {
  const TasksBottomBar({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return BottomAppBar(
      elevation: 4,
      child: Row(
        children: <Widget>[
          const Spacer(),
          ElevatedButton(
            style: ElevatedButton.styleFrom(
                backgroundColor: Theme.of(context).colorScheme.primary,
                padding: const EdgeInsets.all(20)),
            onPressed: () => Scaffold.of(context).showBottomSheet(
              (context) => const TaskForm(title: "Add new task"),
              enableDrag: false,
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Icon(
                  Icons.add,
                  color: Theme.of(context).colorScheme.onPrimary,
                ),
                const SizedBox(width: 10),
                Text(
                  'Add',
                  style: TextStyle(
                    color: Theme.of(context).colorScheme.onPrimary,
                  ),
                ),
              ],
            ),
          )
        ],
      ),
    );
  }
}
