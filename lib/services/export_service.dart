import 'dart:convert';
import 'dart:io';
import 'package:path_provider/path_provider.dart';
import '../data/database/app_database.dart';
import '../core/utils/date_formatter.dart';

class ExportService {
  final EntryDao _entryDao;
  final ReminderDao _reminderDao;

  ExportService(this._entryDao, this._reminderDao);

  Future<String> _ensureExportDir() async {
    final appDir = await getApplicationDocumentsDirectory();
    final exportDir = Directory('${appDir.path}/exports');
    if (!await exportDir.exists()) {
      await exportDir.create(recursive: true);
    }
    return exportDir.path;
  }

  Future<String> exportAsJson() async {
    final entries = await _entryDao.watchAllEntries().first;
    final reminders = await _reminderDao.watchActiveReminders().first;

    final data = {
      'exportTime': DateTime.now().toIso8601String(),
      'entries': entries.map((e) => {
        'id': e.id,
        'content': e.content,
        'title': e.title,
        'createdAt': e.createdAt.toIso8601String(),
        'updatedAt': e.updatedAt.toIso8601String(),
        'tag': e.tag,
        'color': e.color,
      }).toList(),
      'reminders': reminders.map((r) => {
        'id': r.id,
        'content': r.content,
        'dueTime': r.dueTime.toIso8601String(),
        'isCompleted': r.isCompleted,
      }).toList(),
    };

    final fileName = '${DateFormatter.exportFileName()}.json';
    final filePath = '${await _ensureExportDir()}/$fileName';
    final file = File(filePath);
    await file.writeAsString(const JsonEncoder.withIndent('  ').convert(data));
    return filePath;
  }

  Future<String> exportAsMarkdown() async {
    final entries = await _entryDao.watchAllEntries().first;
    final buf = StringBuffer();

    buf.writeln('# 闪念导出');
    buf.writeln();
    buf.writeln('> 导出时间: ${DateFormatter.detailPageTime(DateTime.now())}');
    buf.writeln();

    for (final entry in entries) {
      buf.writeln('---');
      buf.writeln();
      if (entry.title != null) {
        buf.writeln('## ${entry.title}');
        buf.writeln();
      }
      buf.writeln(entry.content);
      buf.writeln();
      buf.writeln(
          '_${DateFormatter.detailPageTime(entry.createdAt)}_');
      if (entry.tag != null) {
        buf.writeln('_标签: ${entry.tag}_');
      }
      buf.writeln();
    }

    final fileName = '${DateFormatter.exportFileName()}.md';
    final filePath = '${await _ensureExportDir()}/$fileName';
    final file = File(filePath);
    await file.writeAsString(buf.toString());
    return filePath;
  }

  Future<String> exportAsText() async {
    final entries = await _entryDao.watchAllEntries().first;
    final buf = StringBuffer();

    for (var i = 0; i < entries.length; i++) {
      final entry = entries[i];
      if (entry.title != null) {
        buf.writeln(entry.title);
        buf.writeln();
      }
      buf.writeln(entry.content);
      buf.writeln();
      buf.writeln(DateFormatter.detailPageTime(entry.createdAt));
      if (entry.tag != null) {
        buf.writeln('标签: ${entry.tag}');
      }
      if (i < entries.length - 1) {
        buf.writeln();
        buf.writeln();
      }
    }

    final fileName = '${DateFormatter.exportFileName()}.txt';
    final filePath = '${await _ensureExportDir()}/$fileName';
    final file = File(filePath);
    await file.writeAsString(buf.toString());
    return filePath;
  }
}
