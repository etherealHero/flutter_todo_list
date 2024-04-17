import 'package:flutter/material.dart';
import 'package:flutter_sandbox/src/app/layout.dart';
import 'package:flutter_sandbox/src/models/task.dart';

import '/src/app/repository.dart';

class TaskForm extends StatefulWidget {
  const TaskForm({super.key, required this.title, this.task});

  final String title;
  final Task? task;

  @override
  State<TaskForm> createState() => _TaskFormState();
}

class _TaskFormState extends State<TaskForm> {
  final repository = Repository();

  final TextEditingController _titleController = TextEditingController();
  final TextEditingController _descriptionController = TextEditingController();

  late FocusNode _titleFocusNode;

  @override
  void initState() {
    super.initState();
    _titleFocusNode = FocusNode();
    if (widget.task != null) {
      _titleController.text = widget.task!.title;
      _descriptionController.text = widget.task!.description;
    }
  }

  @override
  void dispose() {
    _titleFocusNode.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return TapRegion(
      onTapOutside: (_) => Navigator.pop(context),
      child: Container(
        padding: const EdgeInsets.all(8.0),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(24.0),
        ),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: <Widget>[
            Text(widget.title, style: const TextStyle(fontSize: 20)),
            const SizedBox(height: 10),
            TextFormField(
              autofocus: true,
              focusNode: _titleFocusNode,
              controller: _titleController,
              decoration: const InputDecoration(
                border: OutlineInputBorder(),
                labelText: 'Title',
              ),
            ),
            const SizedBox(height: 15),
            TextFormField(
              controller: _descriptionController,
              decoration: const InputDecoration(
                border: OutlineInputBorder(),
                labelText: 'Description',
              ),
              maxLines: 3,
            ),
            const SizedBox(height: 10),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                TextButton.icon(
                  icon: Icon(Icons.close, color: Colors.red.shade300),
                  label: Text('Cancel',
                      style: TextStyle(color: Colors.red.shade300)),
                  onPressed: () {
                    Navigator.pop(context);
                  },
                ),
                ElevatedButton.icon(
                  icon: Icon(Icons.save, color: Colors.white.withOpacity(0.9)),
                  style:
                      ElevatedButton.styleFrom(backgroundColor: Colors.green),
                  label: Text('Save',
                      style: TextStyle(color: Colors.white.withOpacity(0.9))),
                  onPressed: () async {
                    if (_titleController.text.trim().isEmpty) {
                      showSnackBarFun(context, "Title shouldn't be empty");
                      _titleFocusNode.requestFocus();
                      return;
                    }

                    if (widget.task != null) {
                      widget.task!.title = _titleController.text;
                      widget.task!.description = _descriptionController.text;

                      await repository.saveTask(widget.task!);
                    } else {
                      await repository.saveTask(Task(
                        title: _titleController.text,
                        description: _descriptionController.text,
                      ));
                    }

                    if (!context.mounted) return;

                    Navigator.pop(context);
                  },
                ),
              ],
            )
          ],
        ),
      ),
    );
  }
}
