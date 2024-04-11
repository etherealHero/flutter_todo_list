import 'package:flutter/material.dart';
import 'package:flutter_slidable/flutter_slidable.dart';

import '/src/models/task.dart';

class TaskCard extends StatelessWidget {
  const TaskCard(
    this.task, {
    super.key,
  });

  final Task task;

  @override
  Widget build(BuildContext context) {
    var leading = Checkbox(
      value: task.checked,
      onChanged: (v) {},
    );
    var title = Text(task.title);
    var subtitle = Text(task.description);

    return Slidable(
      key: Key(task.id.toString()),
      endActionPane: ActionPane(
        motion: const ScrollMotion(),
        children: [
          CustomSlidableAction(
            padding: EdgeInsets.zero,
            backgroundColor: Colors.transparent,
            onPressed: (context) {},
            child: Container(
              margin: const EdgeInsets.symmetric(vertical: 4, horizontal: 2),
              height: double.infinity,
              width: double.infinity,
              alignment: Alignment.center,
              decoration: const BoxDecoration(
                color: Colors.red,
                borderRadius: BorderRadius.all(
                  Radius.circular(10),
                ),
              ),
              child: const Text('Delete'),
            ),
          ),
        ],
      ),
      child: Card(
        elevation: 4,
        child: task.description.isEmpty
            ? ListTile(
                leading: leading,
                title: title,
              )
            : ListTile(
                leading: leading,
                title: title,
                subtitle: subtitle,
              ),
      ),
    );
  }
}
