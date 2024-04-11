import 'package:flutter/material.dart';

class AddTaskForm extends StatelessWidget {
  const AddTaskForm({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return TapRegion(
      onTapOutside: (_) => Navigator.pop(context),
      child: Container(
        padding: const EdgeInsets.all(8.0),
        decoration: BoxDecoration(
          border: Border.all(
              color: Theme.of(context).colorScheme.primaryContainer,
              width: 2.0),
          borderRadius: BorderRadius.circular(24.0),
        ),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: <Widget>[
            const SizedBox(height: 10),
            TextFormField(
              autofocus: true,
              decoration: const InputDecoration(
                border: OutlineInputBorder(),
                labelText: 'Title',
              ),
            ),
            const SizedBox(height: 15),
            TextFormField(
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
                ElevatedButton.icon(
                  icon: Icon(Icons.close, color: Colors.white.withOpacity(0.9)),
                  style: ElevatedButton.styleFrom(backgroundColor: Colors.red),
                  label: Text('Cancel',
                      style: TextStyle(color: Colors.white.withOpacity(0.9))),
                  onPressed: () => Navigator.pop(context),
                ),
                ElevatedButton.icon(
                  icon: Icon(Icons.add, color: Colors.white.withOpacity(0.9)),
                  style:
                      ElevatedButton.styleFrom(backgroundColor: Colors.green),
                  label: Text('Add task',
                      style: TextStyle(color: Colors.white.withOpacity(0.9))),
                  onPressed: () => Navigator.pop(context),
                ),
              ],
            )
          ],
        ),
      ),
    );
  }
}
