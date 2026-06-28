part of '../app_database.dart';

@DriftAccessor(tables: [Entries])
class EntryDao extends DatabaseAccessor<AppDatabase> with _$EntryDaoMixin {
  EntryDao(super.db);

  Stream<List<Entry>> watchAllEntries() {
    return (select(entries)
      ..orderBy([(t) => OrderingTerm.desc(t.createdAt)]))
      .watch();
  }

  Stream<List<Entry>> watchEntriesByTag(String tag) {
    return (select(entries)
      ..where((t) => t.tag.equals(tag))
      ..orderBy([(t) => OrderingTerm.desc(t.createdAt)]))
      .watch();
  }

  Future<Entry?> getEntryById(String id) {
    return (select(entries)..where((t) => t.id.equals(id))).getSingleOrNull();
  }

  Future<void> insertEntry(EntriesCompanion entry) {
    return into(entries).insert(entry);
  }

  Future<void> updateEntry(EntriesCompanion entry) {
    return update(entries).replace(entry);
  }

  Future<void> deleteEntry(String id) {
    return (delete(entries)..where((t) => t.id.equals(id))).go();
  }

  Future<List<Entry>> searchEntries(String query) {
    final pattern = '%$query%';
    return (select(entries)
      ..where((t) => t.content.like(pattern) | t.title.like(pattern))
      ..orderBy([(t) => OrderingTerm.desc(t.createdAt)]))
      .get();
  }

  Future<List<Entry>> getEntriesByDateRange(DateTime start, DateTime end) {
    return (select(entries)
      ..where((t) => t.createdAt.isBetweenValues(start, end))
      ..orderBy([(t) => OrderingTerm.desc(t.createdAt)]))
      .get();
  }
}
