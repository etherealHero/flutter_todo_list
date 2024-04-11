import 'package:flutter/material.dart';

import '../widgets/add_task_form.dart';
import '/src/widgets/task_card.dart';
import '/src/models/task.dart';

class TasksScreen extends StatelessWidget {
  const TasksScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Expanded(
          child: ListView(
            children: tasks
                .map(
                  (task) => TaskCard(task),
                )
                .toList(),
          ),
        ),
        SizedBox(
          height: 50,
          width: double.infinity,
          child: ElevatedButton(
            style: ElevatedButton.styleFrom(
              backgroundColor: Colors.green,
            ),
            onPressed: () => Scaffold.of(context)
                .showBottomSheet((context) => const AddTaskForm()),
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
