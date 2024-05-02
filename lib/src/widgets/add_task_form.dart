import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '/src/models/bloc/tasks_bloc.dart';
import '/src/models/task.dart';

class TaskForm extends StatefulWidget {
  const TaskForm({super.key, required this.title, this.task});

  final String title;
  final Task? task;

  @override
  State<TaskForm> createState() => _TaskFormState();
}

class _TaskFormState extends State<TaskForm> {
  final _formKey = GlobalKey<FormState>();
  late FocusNode _titleFocusNode;

  final TextEditingController _titleController = TextEditingController();
  final TextEditingController _descriptionController = TextEditingController();

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
    return TextFieldTapRegion(
      onTapOutside: (_) => Navigator.pop(context),
      child: Container(
        padding: const EdgeInsets.all(8.0),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(24.0),
        ),
        child: Form(
          key: _formKey,
          autovalidateMode: AutovalidateMode.onUserInteraction,
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: <Widget>[
              Text(widget.title, style: const TextStyle(fontSize: 20)),
              const SizedBox(height: 10),
              TextFormField(
                autofocus: true,
                validator: (value) {
                  if (value == null || value.trim().isEmpty) {
                    return "Title shouldn't be empty";
                  }
                  return null;
                },
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
                    icon:
                        Icon(Icons.save, color: Colors.white.withOpacity(0.9)),
                    style:
                        ElevatedButton.styleFrom(backgroundColor: Colors.green),
                    label: Text('Save',
                        style: TextStyle(color: Colors.white.withOpacity(0.9))),
                    onPressed: () async {
                      if (!_formKey.currentState!.validate()) {
                        _titleController.text = "";
                        _titleFocusNode.requestFocus();
                        return;
                      }

                      if (widget.task != null) {
                        widget.task!.title = _titleController.text.trim();
                        widget.task!.description = _descriptionController.text;

                        context.read<TasksBloc>().add(
                            TasksEventUpdateTask(modifiedTask: widget.task!));
                      } else {
                        context.read<TasksBloc>().add(
                              TasksEventAddTask(
                                  newTask: Task(
                                title: _titleController.text.trim(),
                                description: _descriptionController.text,
                              )),
                            );
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
      ),
    );
  }
}
