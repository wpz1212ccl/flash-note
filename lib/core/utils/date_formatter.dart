import 'package:intl/intl.dart';

class DateFormatter {
  DateFormatter._();

  static String homeLargeDate(DateTime date) {
    return DateFormat('d EEEE', 'zh_CN').format(date);
  }

  static String homeSubtitle(DateTime date) {
    return DateFormat('yyyy年M月 · EEEE', 'zh_CN').format(date);
  }

  static String collapsedTitle(DateTime date) {
    return DateFormat('M月 · EEEE', 'zh_CN').format(date);
  }

  static String cardTime(DateTime date) {
    return DateFormat('HH:mm').format(date);
  }

  static String detailPageTime(DateTime date) {
    return DateFormat('yyyy年M月d日 EEEE HH:mm', 'zh_CN').format(date);
  }

  static String dateSeparator(DateTime date) {
    final now = DateTime.now();
    final today = DateTime(now.year, now.month, now.day);
    final yesterday = today.subtract(const Duration(days: 1));
    final dateDay = DateTime(date.year, date.month, date.day);

    if (dateDay == today) return '今天';
    if (dateDay == yesterday) return '昨天';
    if (date.year == now.year) {
      return DateFormat('M月d日 EEEE', 'zh_CN').format(date);
    }
    return DateFormat('yyyy年M月d日', 'zh_CN').format(date);
  }

  static String todoTime(DateTime dueTime) {
    final now = DateTime.now();
    final today = DateTime(now.year, now.month, now.day);
    final tomorrow = today.add(const Duration(days: 1));
    final dueDay = DateTime(dueTime.year, dueTime.month, dueTime.day);
    final timeStr = DateFormat('HH:mm').format(dueTime);

    if (dueDay == today) return '今天 $timeStr';
    if (dueDay == tomorrow) return '明天 $timeStr';
    if (dueTime.year == now.year) {
      return '${DateFormat('M月d日').format(dueTime)} $timeStr';
    }
    return '${DateFormat('yyyy年M月d日').format(dueTime)} $timeStr';
  }

  static String exportFileName() {
    return DateFormat('闪念导出_yyyyMMdd_HHmmss', 'zh_CN').format(DateTime.now());
  }
}
