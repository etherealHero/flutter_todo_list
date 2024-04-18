import 'package:flutter/material.dart';
import 'package:flutter_sandbox/src/pages/home_page.dart';
import 'package:flutter_slidable/flutter_slidable.dart';

import '/src/app/repository.dart';
import '/src/app/layout.dart';
import '/src/models/task.dart';
import '/src/widgets/task_card.dart';

var archiveScreen = ScreenLayout(
  screen: ArchiveScreen(),
  bottomNavigationBar: const ArchiveBottomBar(),
);

class ArchiveScreen extends StatelessWidget {
  ArchiveScreen({super.key});

  final repository = Repository();

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Expanded(
          child: StreamBuilder<List<Task>>(
              stream: repository.listenArchivedTasks(),
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
                            '${Screens.archive.title} is empty',
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

class ArchiveBottomBar extends StatelessWidget {
  const ArchiveBottomBar({
    super.key,
  });

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
          )
        ],
      ),
    );
  }
}
