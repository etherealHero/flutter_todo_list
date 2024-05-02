import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_slidable/flutter_slidable.dart';

import '/src/models/bloc/tasks_bloc.dart';
import '/src/models/task.dart';
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

  @override
  Widget build(BuildContext context) {
    var leading = Checkbox(
      value: widget.task.checked,
      onChanged: !widget.task.archived && !widget.task.trash
          ? (v) => context.read<TasksBloc>().add(
              TasksEventUpdateTask(modifiedTask: widget.task..checked = v!))
          : null,
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
        dismissible: DismissiblePane(
          onDismissed: () {
            if (widget.task.trash) {
              context
                  .read<TasksBloc>()
                  .add(TasksEventDeleteTask(taskId: widget.task.id!));
            } else {
              context
                  .read<TasksBloc>()
                  .add(TasksEventTrashTask(task: widget.task));
            }
          },
        ),
        motion: const DrawerMotion(),
        children: widget.task.archived || widget.task.trash
            ? [
                DeleteAction(widget: widget),
              ]
            : [
                EditAction(widget: widget),
                DeleteAction(widget: widget),
              ],
      ),
      startActionPane: ActionPane(
        motion: const DrawerMotion(),
        dismissible: DismissiblePane(
          onDismissed: () {
            if (widget.task.trash) {
              context
                  .read<TasksBloc>()
                  .add(TasksEventRestoreTask(taskId: widget.task.id!));
            } else {
              context.read<TasksBloc>().add(
                    TasksEventUpdateTask(
                      modifiedTask: widget.task
                        ..archived = !widget.task.archived,
                    ),
                  );
            }
          },
        ),
        children: [
          ArchiveAction(widget: widget),
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

class ArchiveAction extends StatelessWidget {
  const ArchiveAction({
    super.key,
    required this.widget,
  });

  final TaskCard widget;

  @override
  Widget build(BuildContext context) {
    return CustomSlidableAction(
      padding: EdgeInsets.zero,
      backgroundColor: Colors.transparent,
      onPressed: (context) {
        if (widget.task.trash) {
          context.read<TasksBloc>().add(
                TasksEventUpdateTask(
                  modifiedTask: widget.task
                    ..trash = false
                    ..archived = false,
                ),
              );
        } else {
          context.read<TasksBloc>().add(
                TasksEventUpdateTask(
                  modifiedTask: widget.task..archived = !widget.task.archived,
                ),
              );
        }
      },
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
        child: Text(widget.task.trash
            ? 'Restore'
            : widget.task.archived
                ? 'Unarchive'
                : 'Archive'),
      ),
    );
  }
}

class DeleteAction extends StatelessWidget {
  const DeleteAction({
    super.key,
    required this.widget,
  });

  final TaskCard widget;

  @override
  Widget build(BuildContext context) {
    return CustomSlidableAction(
      padding: EdgeInsets.zero,
      backgroundColor: Colors.transparent,
      onPressed: (context) {
        if (widget.task.trash) {
          context
              .read<TasksBloc>()
              .add(TasksEventDeleteTask(taskId: widget.task.id!));
        } else {
          context.read<TasksBloc>().add(TasksEventTrashTask(task: widget.task));
        }
      },
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
        child: Text(widget.task.trash ? 'Delete' : 'Trash'),
      ),
    );
  }
}

class EditAction extends StatelessWidget {
  const EditAction({
    super.key,
    required this.widget,
  });

  final TaskCard widget;

  @override
  Widget build(BuildContext context) {
    return CustomSlidableAction(
      padding: EdgeInsets.zero,
      backgroundColor: Colors.transparent,
      onPressed: (context) => Scaffold.of(context).showBottomSheet(
        (context) => TaskForm(title: "Edit task", task: widget.task),
        enableDrag: false,
      ),
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
    );
  }
}
