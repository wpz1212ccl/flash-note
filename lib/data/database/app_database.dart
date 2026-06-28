import 'package:drift/drift.dart';
import 'package:drift/native.dart';
import 'package:path_provider/path_provider.dart';
import 'package:path/path.dart' as p;
import 'dart:io';
import 'tables/entries.dart';
import 'tables/reminders.dart';

part 'app_database.g.dart';
part 'daos/entry_dao.dart';
part 'daos/reminder_dao.dart';

@DriftDatabase(tables: [Entries, Reminders], daos: [EntryDao, ReminderDao])
class AppDatabase extends _$AppDatabase {
  AppDatabase() : super(_openConnection());

  @override
  int get schemaVersion => 1;

  @override
  MigrationStrategy get migration => MigrationStrategy(
    onCreate: (Migrator m) async {
      await m.createAll();
    },
  );
}

LazyDatabase _openConnection() {
  return LazyDatabase(() async {
    final dbFolder = await getApplicationDocumentsDirectory();
    final file = File(p.join(dbFolder.path, 'flash_note.db'));
    return NativeDatabase.createInBackground(file);
  });
}
