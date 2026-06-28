import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../data/database/app_database.dart';

final appDatabaseProvider = Provider<AppDatabase>((ref) {
  final db = AppDatabase();
  ref.onDispose(() => db.close());
  return db;
});

final entryDaoProvider = Provider((ref) {
  return ref.watch(appDatabaseProvider).entryDao;
});

final reminderDaoProvider = Provider((ref) {
  return ref.watch(appDatabaseProvider).reminderDao;
});
