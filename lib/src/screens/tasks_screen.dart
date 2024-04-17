import 'package:flutter/material.dart';
import 'package:flutter_slidable/flutter_slidable.dart';

import '/src/app/repository.dart';
import '/src/widgets/task_card.dart';
import '/src/models/task.dart';

// ignore: unused_import
import '/src/widgets/add_task_form.dart';

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
                    : Center(
                        child: Text(
                        'Task list is empty. \nPress "+ New task" button',
                        textAlign: TextAlign.center,
                        style: Theme.of(context).textTheme.titleLarge,
                      ));
              }),
        ),
        SizedBox(
          height: 50,
          width: double.infinity,
          child: ElevatedButton(
            style: ElevatedButton.styleFrom(
              backgroundColor: Colors.green,
            ),
            onPressed: () => Scaffold.of(context).showBottomSheet(
                (context) => const TaskForm(title: "Add new task")),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Icon(
                  Icons.add,
                  color: Colors.white.withOpacity(0.9),
                ),
                const SizedBox(width: 10),
                Text(
                  'New task',
                  style: TextStyle(
                    color: Colors.white.withOpacity(0.9),
                  ),
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }
}
