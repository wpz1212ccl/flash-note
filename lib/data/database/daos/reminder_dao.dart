part of '../app_database.dart';

@DriftAccessor(tables: [Reminders])
class ReminderDao extends DatabaseAccessor<AppDatabase> with _$ReminderDaoMixin {
  ReminderDao(super.db);

  Stream<List<Reminder>> watchActiveReminders() {
    return (select(reminders)
      ..where((t) => t.isCompleted.equals(false))
      ..orderBy([(t) => OrderingTerm.asc(t.dueTime)]))
      .watch();
  }

  Stream<List<Reminder>> watchCompletedReminders() {
    return (select(reminders)
      ..where((t) => t.isCompleted.equals(true))
      ..orderBy([(t) => OrderingTerm.desc(t.dueTime)]))
      .watch();
  }

  Future<Reminder?> getReminderById(String id) {
    return (select(reminders)..where((t) => t.id.equals(id))).getSingleOrNull();
  }

  Future<void> insertReminder(RemindersCompanion reminder) {
    return into(reminders).insert(reminder);
  }

  Future<void> updateReminder(RemindersCompanion reminder) {
    return update(reminders).replace(reminder);
  }

  Future<void> toggleComplete(String id, bool isCompleted) {
    return (update(reminders)..where((t) => t.id.equals(id)))
        .write(RemindersCompanion(isCompleted: Value(isCompleted)));
  }

  Future<void> deleteReminder(String id) {
    return (delete(reminders)..where((t) => t.id.equals(id))).go();
  }

  Future<void> deleteCompletedReminders() {
    return (delete(reminders)..where((t) => t.isCompleted.equals(true))).go();
  }
}
