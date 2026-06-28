import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../data/database/app_database.dart';
import '../data/repositories/reminder_repository.dart';
import '../services/notification_service.dart';
import 'database_provider.dart';

final reminderRepositoryProvider = Provider<ReminderRepository>((ref) {
  final reminderDao = ref.watch(reminderDaoProvider);
  return ReminderRepository(reminderDao, NotificationService.instance);
});

final activeRemindersProvider = StreamProvider<List<Reminder>>((ref) {
  return ref.watch(reminderDaoProvider).watchActiveReminders();
});

final completedRemindersProvider = StreamProvider<List<Reminder>>((ref) {
  return ref.watch(reminderDaoProvider).watchCompletedReminders();
});

final overdueRemindersProvider = Provider<List<Reminder>>((ref) {
  final active = ref.watch(activeRemindersProvider).valueOrNull ?? [];
  final now = DateTime.now();
  return active.where((r) => r.dueTime.isBefore(now)).toList();
});
