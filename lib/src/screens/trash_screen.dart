import 'package:flutter/material.dart';
import 'package:flutter_slidable/flutter_slidable.dart';

import '/src/app/repository.dart';
import '/src/app/layout.dart';
import '/src/models/task.dart';
import '/src/pages/home_page.dart';
import '/src/widgets/task_card.dart';

var trashScreen = ScreenLayout(
  screen: TrashScreen(),
  bottomNavigationBar: TrashBottomBar(),
);

class TrashScreen extends StatelessWidget {
  TrashScreen({super.key});

  final repository = Repository();

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Expanded(
          child: StreamBuilder<List<Task>>(
              stream: repository.listenTrashTasks(),
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
                            '${Screens.trash.title} is empty',
                            textAlign: TextAlign.center,
                            style: Theme.of(context).textTheme.titleLarge,
                          ),
                          const SizedBox(height: 10),
                          TextButton.icon(
                            onPressed: () {
                              context
                                  .findAncestorStateOfType<HomePageState>()!
                                  .changeHomeScreen(Screens.tasks);
                            },
                            icon: const Icon(Icons.keyboard_backspace_rounded),
                            label: Text("Back to ${Screens.tasks.title}"),
                          )
                        ],
                      );
              }),
        ),
      ],
    );
  }
}

class TrashBottomBar extends StatelessWidget {
  TrashBottomBar({
    super.key,
  });

  final repository = Repository();

  @override
  Widget build(BuildContext context) {
    return BottomAppBar(
      elevation: 4,
      child: Row(
        children: <Widget>[
          ElevatedButton.icon(
            onPressed: () {
              context
                  .findAncestorStateOfType<HomePageState>()!
                  .changeHomeScreen(Screens.tasks);
            },
            icon: const Icon(Icons.keyboard_backspace_rounded),
            label: Text(Screens.tasks.title),
          ),
          const Spacer(),
          IconButton(
            icon: const Icon(Icons.delete_outline),
            onPressed: () {
              showDialog<String>(
                context: context,
                builder: (BuildContext context) => AlertDialog(
                  title: const Text('Confirm action'),
                  content: const Text(
                    'Empty the trash permanently',
                  ),
                  actions: <Widget>[
                    TextButton(
                      onPressed: () => Navigator.pop(context, 'Cancel'),
                      child: const Text('Cancel'),
                    ),
                    TextButton(
                      onPressed: () => Navigator.pop(context, 'OK'),
                      child: const Text('OK'),
                    ),
                  ],
                ),
              ).then((returnVal) async {
                if (returnVal != null && returnVal == 'OK') {
                  await repository.deleteTrashTasks();

                  if (!context.mounted) return;

                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(
                      content: const Text('Trash list emptied'),
                      action: SnackBarAction(label: 'OK', onPressed: () {}),
                    ),
                  );
                }
              });
            },
          ),
        ],
      ),
    );
  }
}
