import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_slidable/flutter_slidable.dart';

import '/src/app/layout.dart';
import '/src/models/bloc/tasks_bloc.dart';
import '/src/models/task.dart';
import '/src/pages/home_page.dart';
import '/src/widgets/task_card.dart';

var archiveScreen = ScreenLayout(
  screen: const ArchiveScreen(),
  bottomNavigationBar: const ArchiveBottomBar(),
);

class ArchiveScreen extends StatelessWidget {
  const ArchiveScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        BlocBuilder<TasksBloc, TasksState>(
          builder: (context, state) {
            if (state is TasksStateFetchingTasks) {
              return const CircularProgressIndicator();
            }

            if (state is TasksStateLoadedTasks && state.tasks.isNotEmpty) {
              Iterable<Task> tasks = state.tasks.where(
                (t) => t.archived && !t.trash,
              );

              if (tasks.isNotEmpty) {
                return Expanded(
                  child: SlidableAutoCloseBehavior(
                    child: ListView(
                      children: tasks.map((task) => TaskCard(task)).toList(),
                    ),
                  ),
                );
              } else {
                return Expanded(
                  child: Column(
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
                  ),
                );
              }
            }

            return const Text('lorem');
          },
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
