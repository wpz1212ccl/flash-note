import 'package:drift/drift.dart';

@DataClassName('Entry')
class Entries extends Table {
  TextColumn get id => text()();
  TextColumn get content => text()();
  TextColumn get title => text().nullable()();
  DateTimeColumn get createdAt => dateTime()();
  DateTimeColumn get updatedAt => dateTime()();
  TextColumn get tag => text().nullable()();
  TextColumn get color => text().nullable()();
  BoolColumn get isPinned => boolean().withDefault(const Constant(false))();
  TextColumn get reminderId => text().nullable()();

  @override
  Set<Column> get primaryKey => {id};

  // ignore: override_on_non_overriding_member
  @override
  List<Index> get indexes => [Index('idx_entries_created_at', 'createdAt')];
}
