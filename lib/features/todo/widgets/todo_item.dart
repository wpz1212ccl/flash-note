import 'package:flutter/material.dart';
import '../../../../core/constants/app_colors.dart';
import '../../../../core/constants/app_text_styles.dart';
import '../../../../core/constants/app_spacing.dart';
import '../../../../core/utils/date_formatter.dart';
import '../../../../data/database/app_database.dart';
import '../../../../shared/extensions/context_extensions.dart';

class TodoItem extends StatefulWidget {
  final Reminder reminder;
  final VoidCallback onToggle;
  final VoidCallback onDelete;
  final VoidCallback onTap;

  const TodoItem({
    super.key,
    required this.reminder,
    required this.onToggle,
    required this.onDelete,
    required this.onTap,
  });

  @override
  State<TodoItem> createState() => _TodoItemState();
}

class _TodoItemState extends State<TodoItem> with SingleTickerProviderStateMixin {
  late AnimationController _pulseController;

  @override
  void initState() {
    super.initState();
    if (_isOverdue) {
      _pulseController = AnimationController(
        vsync: this,
        duration: const Duration(milliseconds: 1500),
      )..repeat(reverse: true);
    } else {
      _pulseController = AnimationController(vsync: this);
    }
  }

  @override
  void dispose() {
    _pulseController.dispose();
    super.dispose();
  }

  bool get _isOverdue => !widget.reminder.isCompleted && widget.reminder.dueTime.isBefore(DateTime.now());

  @override
  Widget build(BuildContext context) {
    final isDark = context.isDarkMode;
    final textColor = isDark ? AppColors.lightCream : AppColors.warmBlack;
    final secondaryColor = isDark ? AppColors.darkTextSecondary : AppColors.textSecondary;
    final isCompleted = widget.reminder.isCompleted;

    final timeWidget = _isOverdue && _pulseController.isAnimating
        ? AnimatedBuilder(
            animation: _pulseController,
            builder: (context, child) => Opacity(
              opacity: 0.6 + 0.4 * _pulseController.value,
              child: child,
            ),
            child: _buildTimeLabel(isDark),
          )
        : _buildTimeLabel(isDark);

    return Dismissible(
      key: Key(widget.reminder.id),
      direction: DismissDirection.endToStart,
      background: Container(
        alignment: Alignment.centerRight,
        padding: const EdgeInsets.only(right: AppSpacing.xxl),
        color: AppColors.danger,
        child: const Icon(Icons.delete, color: Colors.white),
      ),
      onDismissed: (_) => widget.onDelete(),
      child: InkWell(
        onTap: widget.onTap,
        child: SizedBox(
          height: 56,
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: AppSpacing.lg),
            child: Row(
              children: [
                GestureDetector(
                  onTap: widget.onToggle,
                  child: AnimatedContainer(
                    duration: const Duration(milliseconds: 300),
                    width: 22,
                    height: 22,
                    decoration: BoxDecoration(
                      color: isCompleted ? AppColors.apricot : Colors.transparent,
                      shape: BoxShape.circle,
                      border: Border.all(
                        color: isCompleted ? AppColors.apricot : secondaryColor,
                        width: 2,
                      ),
                    ),
                    child: isCompleted
                        ? const Icon(Icons.check, size: 14, color: Colors.white)
                        : null,
                  ),
                ),
                const SizedBox(width: AppSpacing.md),
                Expanded(
                  child: Text(
                    widget.reminder.content,
                    style: AppTextStyles.bodyMedium(
                      isCompleted ? secondaryColor : textColor,
                    ).copyWith(
                      decoration: isCompleted ? TextDecoration.lineThrough : null,
                    ),
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                  ),
                ),
                const SizedBox(width: AppSpacing.sm),
                timeWidget,
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildTimeLabel(bool isDark) {
    final secondaryColor = isDark ? AppColors.darkTextSecondary : AppColors.textSecondary;
    return Text(
      DateFormatter.todoTime(widget.reminder.dueTime),
      style: AppTextStyles.caption(
        _isOverdue ? AppColors.danger : secondaryColor,
      ),
    );
  }
}
