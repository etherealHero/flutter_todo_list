import 'package:path_provider/path_provider.dart';
import 'package:isar/isar.dart';
import 'package:shared_preferences/shared_preferences.dart';

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

    yield* isar.tasks
        .where()
        .filter()
        .archivedEqualTo(false)
        .trashEqualTo(false)
        .watch(fireImmediately: true);
  }

  Stream<List<Task>> listenArchivedTasks() async* {
    var isar = await db;

    yield* isar.tasks
        .where()
        .filter()
        .archivedEqualTo(true)
        .trashEqualTo(false)
        .watch(fireImmediately: true);
  }

  Stream<List<Task>> listenTrashTasks() async* {
    var isar = await db;

    yield* isar.tasks
        .where()
        .filter()
        .trashEqualTo(true)
        .watch(fireImmediately: true);
  }

  Future<void> saveTask(Task task) async {
    var isar = await db;

    isar.writeTxnSync(() => isar.tasks.putSync(task));
  }

  Future<void> deleteTask(int id) async {
    var isar = await db;

    isar.writeTxnSync(() => isar.tasks.deleteSync(id));
  }

  Future<void> deleteTrashTasks() async {
    var isar = await db;

    isar.writeTxnSync(() {
      isar.tasks.where().filter().trashEqualTo(true).deleteAllSync();
    });
  }

  // migrations
  Future<void> performMigrationIfNeeded(SharedPreferences prefs) async {
    const int lastVersion = 2;
    final currentVersion = prefs.getInt('version') ?? lastVersion;

    switch (currentVersion) {
      case 1:
        // add trash feature
        await migrateV1ToV2();
        break;
      case 2:
        return;
      default:
        throw Exception('Unknown version: $currentVersion');
    }

    await prefs.setInt('version', lastVersion);
  }

  Future<void> migrateV1ToV2() async {
    var isar = await db;

    var tasks = isar.tasks.where().findAllSync();

    isar.writeTxnSync(() {
      for (var task in tasks) {
        isar.tasks.putSync(task..trash = false);
      }
    });
  }
}
