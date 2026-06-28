import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../data/database/app_database.dart';
import '../data/repositories/entry_repository.dart';
import 'database_provider.dart';

final entryRepositoryProvider = Provider<EntryRepository>((ref) {
  final entryDao = ref.watch(entryDaoProvider);
  final reminderDao = ref.watch(reminderDaoProvider);
  return EntryRepository(entryDao, reminderDao);
});

final allEntriesProvider = StreamProvider<List<Entry>>((ref) {
  return ref.watch(entryDaoProvider).watchAllEntries();
});

final entriesByTagProvider = StreamProvider.family<List<Entry>, String>((ref, tag) {
  return ref.watch(entryDaoProvider).watchEntriesByTag(tag);
});

final searchResultsProvider = FutureProvider.family<List<Entry>, String>((ref, query) {
  return ref.watch(entryDaoProvider).searchEntries(query);
});

final singleEntryProvider = FutureProvider.family<Entry?, String>((ref, id) {
  return ref.watch(entryDaoProvider).getEntryById(id);
});
