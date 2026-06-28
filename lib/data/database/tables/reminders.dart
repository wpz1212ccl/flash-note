import 'package:drift/drift.dart';

@DataClassName('Reminder')
class Reminders extends Table {
  TextColumn get id => text()();
  TextColumn get content => text()();
  DateTimeColumn get dueTime => dateTime()();
  BoolColumn get isCompleted => boolean().withDefault(const Constant(false))();
  DateTimeColumn get createdAt => dateTime()();
  TextColumn get sourceEntryId => text().nullable()();
  IntColumn get notificationId => integer()();

  @override
  Set<Column> get primaryKey => {id};
}
