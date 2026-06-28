import 'package:flutter/material.dart';
import '../../../core/constants/app_colors.dart';
import '../../../core/constants/app_spacing.dart';

class ReminderPicker extends StatelessWidget {
  final void Function(DateTime time) onTimeSelected;

  const ReminderPicker({super.key, required this.onTimeSelected});

  static Future<DateTime?> show(BuildContext context) {
    DateTime? result;
    showModalBottomSheet<DateTime>(
      context: context,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
      ),
      builder: (context) {
        return ReminderPicker(
          onTimeSelected: (time) {
            result = time;
            Navigator.pop(context);
          },
        );
      },
    );
    return Future.value(result);
  }

  @override
  Widget build(BuildContext context) {
    final accentColor = Theme.of(context).colorScheme.primary;
    final now = DateTime.now();
    final tonight = DateTime(now.year, now.month, now.day, 20, 0);
    final tomorrow9 = DateTime(now.year, now.month, now.day + 1, 9, 0);

    final options = [
      ('15分钟后', now.add(const Duration(minutes: 15))),
      ('1小时后', now.add(const Duration(hours: 1))),
      ('今晚 20:00', tonight),
      ('明早 09:00', tomorrow9),
      ('自定义时间', null),
    ];

    return Padding(
      padding: const EdgeInsets.all(AppSpacing.xxl),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Container(
            width: 40,
            height: 4,
            decoration: BoxDecoration(
              color: AppColors.textSecondary.withAlpha(80),
              borderRadius: BorderRadius.circular(2),
            ),
          ),
          const SizedBox(height: AppSpacing.xxl),
          Text('设定提醒', style: Theme.of(context).textTheme.headlineSmall),
          const SizedBox(height: AppSpacing.lg),
          ...options.map((opt) {
            return Padding(
              padding: const EdgeInsets.only(bottom: AppSpacing.sm),
              child: SizedBox(
                width: double.infinity,
                child: OutlinedButton(
                  onPressed: () {
                    if (opt.$2 != null) {
                      onTimeSelected(opt.$2!);
                    } else {
                      _showDateTimePicker(context);
                    }
                  },
                  style: OutlinedButton.styleFrom(
                    side: BorderSide(color: accentColor.withAlpha(80)),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(AppSpacing.radiusFull),
                    ),
                    padding: const EdgeInsets.symmetric(vertical: AppSpacing.md),
                  ),
                  child: Text(opt.$1, style: TextStyle(color: accentColor)),
                ),
              ),
            );
          }),
          const SizedBox(height: AppSpacing.md),
        ],
      ),
    );
  }

  Future<void> _showDateTimePicker(BuildContext context) async {
    final date = await showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime.now(),
      lastDate: DateTime.now().add(const Duration(days: 365)),
    );
    if (date == null || !context.mounted) return;

    final time = await showTimePicker(
      context: context,
      initialTime: TimeOfDay.now(),
    );
    if (time == null) return;

    final dateTime = DateTime(date.year, date.month, date.day, time.hour, time.minute);
    onTimeSelected(dateTime);
  }
}
