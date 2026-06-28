import 'package:drift/drift.dart';
import 'package:uuid/uuid.dart';
import '../database/app_database.dart';

class EntryRepository {
  final EntryDao _dao;
  final ReminderDao _reminderDao;
  final _uuid = const Uuid();

  EntryRepository(this._dao, this._reminderDao);

  Future<void> createEntry({
    required String content,
    String? title,
    String? tag,
    String? color,
  }) async {
    final now = DateTime.now();
    await _dao.insertEntry(EntriesCompanion(
      id: Value(_uuid.v4()),
      content: Value(content),
      title: Value(title),
      createdAt: Value(now),
      updatedAt: Value(now),
      tag: Value(tag),
      color: Value(color),
    ));
  }

  Future<void> updateEntryContent(String id, String content, String? title) async {
    final existing = await _dao.getEntryById(id);
    if (existing != null) {
      await _dao.updateEntry(EntriesCompanion(
        id: Value(existing.id),
        content: Value(content),
        title: Value(title),
        createdAt: Value(existing.createdAt),
        updatedAt: Value(DateTime.now()),
        tag: Value(existing.tag),
        color: Value(existing.color),
        isPinned: Value(existing.isPinned),
        reminderId: Value(existing.reminderId),
      ));
    }
  }

  Future<void> deleteEntry(String id) async {
    final entry = await _dao.getEntryById(id);
    if (entry?.reminderId != null) {
      await _reminderDao.deleteReminder(entry!.reminderId!);
    }
    await _dao.deleteEntry(id);
  }

  Future<void> updateEntryReminder(String id, String reminderId) async {
    final existing = await _dao.getEntryById(id);
    if (existing != null) {
      await _dao.updateEntry(EntriesCompanion(
        id: Value(existing.id),
        content: Value(existing.content),
        title: Value(existing.title),
        createdAt: Value(existing.createdAt),
        updatedAt: Value(DateTime.now()),
        tag: Value(existing.tag),
        color: Value(existing.color),
        isPinned: Value(existing.isPinned),
        reminderId: Value(reminderId),
      ));
    }
  }

  Future<List<Entry>> search(String query) => _dao.searchEntries(query);
}
