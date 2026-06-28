import 'package:flutter/material.dart';
import '../../../../core/constants/app_colors.dart';
import '../../../../core/constants/app_spacing.dart';
import '../../capture/widgets/reminder_picker.dart';

class TodoInputSheet extends StatefulWidget {
  const TodoInputSheet({super.key});

  @override
  State<TodoInputSheet> createState() => _TodoInputSheetState();
}

class _TodoInputSheetState extends State<TodoInputSheet> {
  final TextEditingController _controller = TextEditingController();
  DateTime? _dueTime;

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final accentColor = Theme.of(context).colorScheme.primary;

    return Padding(
      padding: EdgeInsets.only(
        bottom: MediaQuery.of(context).viewInsets.bottom,
      ),
      child: Padding(
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
            Text('新建待办', style: Theme.of(context).textTheme.headlineSmall),
            const SizedBox(height: AppSpacing.lg),
            TextField(
              controller: _controller,
              autofocus: true,
              decoration: InputDecoration(
                hintText: '输入待办内容',
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(AppSpacing.radiusMd),
                ),
                contentPadding: const EdgeInsets.all(AppSpacing.lg),
              ),
              minLines: 2,
              maxLines: 5,
            ),
            const SizedBox(height: AppSpacing.lg),
            SizedBox(
              width: double.infinity,
              child: OutlinedButton.icon(
                onPressed: () async {
                  final time = await ReminderPicker.show(context);
                  if (time != null) setState(() => _dueTime = time);
                },
                icon: Icon(
                  _dueTime != null ? Icons.access_time : Icons.access_time_outlined,
                  size: 18,
                ),
                label: Text(_dueTime != null ? '已设定时间' : '设定提醒时间'),
                style: OutlinedButton.styleFrom(
                  side: BorderSide(color: accentColor.withAlpha(80)),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(AppSpacing.radiusMd),
                  ),
                ),
              ),
            ),
            const SizedBox(height: AppSpacing.lg),
            SizedBox(
              width: double.infinity,
              child: ElevatedButton(
                onPressed: () {
                  if (_controller.text.trim().isNotEmpty) {
                    Navigator.pop(context, {
                      'content': _controller.text.trim(),
                      'dueTime': _dueTime,
                    });
                  }
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: accentColor,
                  foregroundColor: Colors.white,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(AppSpacing.radiusMd),
                  ),
                  padding: const EdgeInsets.symmetric(vertical: AppSpacing.md),
                ),
                child: const Text('添加'),
              ),
            ),
            const SizedBox(height: AppSpacing.md),
          ],
        ),
      ),
    );
  }
}
