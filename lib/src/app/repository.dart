import 'package:path_provider/path_provider.dart';
import 'package:isar/isar.dart';

import '/src/models/task.dart';

class Repository {
  late Future<Isar> db;

  Repository() {
    db = openDB();
  }

  Future<Isar> openDB() async {
    final dir = await getApplicationDocumentsDirectory();

    if (Isar.instanceNames.isEmpty) {
      return await Isar.open(
        [TaskSchema],
        directory: dir.path,
        inspector: true,
      );
    }

    return Future.value(Isar.getInstance());
  }

  Future<void> cleanDb() async {
    final isar = await db;
    await isar.writeTxn(() => isar.clear());
  }

  // task repository
  Stream<List<Task>> listenTasks() async* {
    var isar = await db;

    yield* isar.tasks.where().watch(fireImmediately: true);
  }

  Future<void> saveTask(Task task) async {
    var isar = await db;

    isar.writeTxnSync(() => isar.tasks.putSync(task));
  }

  Future<void> deleteTask(int id) async {
    var isar = await db;

    isar.writeTxnSync(() => isar.tasks.deleteSync(id));
  }

  Future<void> mockTasks() async {
    await cleanDb();

    var isar = await db;

    isar.writeTxnSync(() {
      isar.tasks.putSync(
        Task(title: "Daily meeting with team", description: ""),
      );
      isar.tasks.putSync(
        Task(title: "Pay for rent", description: "")..checked = true,
      );
      isar.tasks.putSync(
        Task(title: "Check emails", description: ""),
      );
      isar.tasks.putSync(
        Task(title: "Lunch with Emma", description: "Lorem ipsum dolor est"),
      );
      isar.tasks.putSync(
        Task(title: "Meditation", description: ""),
      );
    });
  }
}
