import 'package:flutter/material.dart';
import 'package:flutter_slidable/flutter_slidable.dart';

import '/src/models/task.dart';
import '/src/app/repository.dart';
import '/src/widgets/add_task_form.dart';

class TaskCard extends StatefulWidget {
  const TaskCard(
    this.task, {
    super.key,
  });

  final Task task;

  @override
  State<TaskCard> createState() => _TaskCardState();
}

class _TaskCardState extends State<TaskCard>
    with SingleTickerProviderStateMixin {
  late final controller = SlidableController(this);
  final repository = Repository();

  @override
  Widget build(BuildContext context) {
    var leading = Checkbox(
      value: widget.task.checked,
      onChanged: (v) => repository.saveTask(widget.task..checked = v!),
    );
    var title = Text(
      widget.task.title,
      style: widget.task.checked
          ? TextStyle(
              decoration: TextDecoration.lineThrough,
              color: Theme.of(context).colorScheme.primary.withOpacity(0.7))
          : const TextStyle(
              decoration: TextDecoration.none,
            ),
    );
    var subtitle = Text(
      widget.task.description,
      style: widget.task.checked
          ? TextStyle(
              decoration: TextDecoration.lineThrough,
              color: Theme.of(context).colorScheme.primary.withOpacity(0.7))
          : const TextStyle(
              decoration: TextDecoration.none,
            ),
    );

    return Slidable(
      key: Key(widget.task.id.toString()),
      groupTag: "0",
      endActionPane: ActionPane(
        motion: const DrawerMotion(),
        children: [
          CustomSlidableAction(
            padding: EdgeInsets.zero,
            backgroundColor: Colors.transparent,
            onPressed: (context) => Scaffold.of(context).showBottomSheet(
                (context) => TaskForm(title: "Edit task", task: widget.task)),
            child: Container(
              margin: const EdgeInsets.symmetric(vertical: 4, horizontal: 2),
              height: double.infinity,
              width: double.infinity,
              alignment: Alignment.center,
              decoration: const BoxDecoration(
                color: Colors.blue,
                borderRadius: BorderRadius.all(
                  Radius.circular(10),
                ),
              ),
              child: const Text('Edit'),
            ),
          ),
          CustomSlidableAction(
            padding: EdgeInsets.zero,
            backgroundColor: Colors.transparent,
            onPressed: (context) => repository.deleteTask(widget.task.id!),
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
      startActionPane: ActionPane(
        motion: const DrawerMotion(),
        children: [
          CustomSlidableAction(
            padding: EdgeInsets.zero,
            backgroundColor: Colors.transparent,
            onPressed: (context) => repository.saveTask(
              widget.task..archived = !widget.task.archived,
            ),
            child: Container(
              margin: const EdgeInsets.symmetric(vertical: 4, horizontal: 2),
              height: double.infinity,
              width: double.infinity,
              alignment: Alignment.center,
              decoration: BoxDecoration(
                color: Colors.yellow.shade800,
                borderRadius: const BorderRadius.all(
                  Radius.circular(10),
                ),
              ),
              child: Text(widget.task.archived ? 'Unarchive' : 'Archive'),
            ),
          ),
        ],
      ),
      child: Card(
        elevation: 4,
        child: widget.task.description.isEmpty
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
