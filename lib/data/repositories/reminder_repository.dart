import 'package:drift/drift.dart';
import 'package:uuid/uuid.dart';
import '../../services/notification_service.dart';
import '../database/app_database.dart';

class ReminderRepository {
  final ReminderDao _dao;
  final NotificationService _notificationService;
  final _uuid = const Uuid();

  ReminderRepository(this._dao, this._notificationService);

  Future<String> createReminder({
    required String content,
    required DateTime dueTime,
    String? sourceEntryId,
  }) async {
    final id = _uuid.v4();
    final notificationId = id.hashCode.abs() % 2147483647;
    final now = DateTime.now();

    await _dao.insertReminder(RemindersCompanion(
      id: Value(id),
      content: Value(content),
      dueTime: Value(dueTime),
      createdAt: Value(now),
      sourceEntryId: Value(sourceEntryId),
      notificationId: Value(notificationId),
    ));

    await _notificationService.scheduleReminder(
      notificationId: notificationId,
      title: '闪念提醒',
      body: content.length > 50 ? '${content.substring(0, 50)}...' : content,
      scheduledTime: dueTime,
      payload: id,
    );

    return id;
  }

  Future<void> completeReminder(String id) async {
    final reminder = await _dao.getReminderById(id);
    if (reminder != null) {
      await _notificationService.cancelNotification(reminder.notificationId);
      await _dao.toggleComplete(id, true);
    }
  }

  Future<void> deleteReminder(String id) async {
    final reminder = await _dao.getReminderById(id);
    if (reminder != null) {
      await _notificationService.cancelNotification(reminder.notificationId);
    }
    await _dao.deleteReminder(id);
  }

  Future<void> rescheduleReminder(String id, DateTime newTime) async {
    final reminder = await _dao.getReminderById(id);
    if (reminder != null) {
      await _notificationService.cancelNotification(reminder.notificationId);
      await _dao.updateReminder(RemindersCompanion(
        id: Value(reminder.id),
        content: Value(reminder.content),
        dueTime: Value(newTime),
        isCompleted: Value(reminder.isCompleted),
        createdAt: Value(reminder.createdAt),
        sourceEntryId: Value(reminder.sourceEntryId),
        notificationId: Value(reminder.notificationId),
      ));
      await _notificationService.scheduleReminder(
        notificationId: reminder.notificationId,
        title: '闪念提醒',
        body: reminder.content.length > 50
            ? '${reminder.content.substring(0, 50)}...'
            : reminder.content,
        scheduledTime: newTime,
        payload: id,
      );
    }
  }
}
