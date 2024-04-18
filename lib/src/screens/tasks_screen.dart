import 'package:flutter/material.dart';
import 'package:flutter_slidable/flutter_slidable.dart';

import '/src/app/repository.dart';
import '/src/app/layout.dart';
import '/src/models/task.dart';
import '/src/widgets/task_card.dart';
import '/src/widgets/add_task_form.dart';

var tasksScreen = ScreenLayout(
  screen: TasksScreen(),
  bottomNavigationBar: const TasksBottomBar(),
);

class TasksScreen extends StatelessWidget {
  TasksScreen({super.key});

  final repository = Repository();

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Expanded(
          child: StreamBuilder<List<Task>>(
              stream: repository.listenTasks(),
              builder: (context, snapshot) {
                if (snapshot.connectionState == ConnectionState.waiting) {
                  return const CircularProgressIndicator();
                }

                return snapshot.hasData && snapshot.data!.isNotEmpty
                    ? SlidableAutoCloseBehavior(
                        child: ListView(
                          children: snapshot.data!
                              .map(
                                (task) => TaskCard(task),
                              )
                              .toList(),
                        ),
                      )
                    : Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text(
                            'Task list is empty',
                            textAlign: TextAlign.center,
                            style: Theme.of(context).textTheme.titleLarge,
                          ),
                          const SizedBox(height: 10),
                          TextButton.icon(
                            onPressed: () =>
                                Scaffold.of(context).showBottomSheet(
                              (context) =>
                                  const TaskForm(title: "Add new task"),
                            ),
                            icon: const Icon(Icons.add),
                            label: const Text("Create first task"),
                          )
                        ],
                      );
              }),
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
