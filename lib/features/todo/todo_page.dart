import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../core/constants/app_colors.dart';
import '../../core/constants/app_text_styles.dart';
import '../../core/constants/app_spacing.dart';
import '../../providers/reminder_providers.dart';
import '../../shared/extensions/context_extensions.dart';
import 'widgets/todo_item.dart';
import 'widgets/todo_input_sheet.dart';

class TodoPage extends ConsumerStatefulWidget {
  const TodoPage({super.key});

  @override
  ConsumerState<TodoPage> createState() => _TodoPageState();
}

class _TodoPageState extends ConsumerState<TodoPage> {
  bool _showCompleted = false;

  @override
  Widget build(BuildContext context) {
    final activeReminders = ref.watch(activeRemindersProvider).valueOrNull ?? [];
    final completedReminders = ref.watch(completedRemindersProvider).valueOrNull ?? [];
    final isDark = context.isDarkMode;
    final bgColor = isDark ? AppColors.darkBg : AppColors.warmWhite;
    final textColor = isDark ? AppColors.lightCream : AppColors.warmBlack;
    final secondaryColor = isDark ? AppColors.darkTextSecondary : AppColors.textSecondary;
    final accentColor = Theme.of(context).colorScheme.primary;

    return Scaffold(
      backgroundColor: bgColor,
      body: SafeArea(
        child: CustomScrollView(
          slivers: [
            SliverAppBar(
              pinned: true,
              backgroundColor: bgColor,
              surfaceTintColor: Colors.transparent,
              title: Text('待办', style: AppTextStyles.headline2(textColor)),
              actions: [
                IconButton(
                  icon: Icon(Icons.add_rounded, color: accentColor),
                  onPressed: () async {
                    final result = await showModalBottomSheet<Map<String, dynamic>>(
                      context: context,
                      isScrollControlled: true,
                      shape: const RoundedRectangleBorder(
                        borderRadius: BorderRadius.vertical(top: Radius.circular(AppSpacing.radiusLg)),
                      ),
                      builder: (context) => const TodoInputSheet(),
                    );
                    if (result != null) {
                      await ref.read(reminderRepositoryProvider).createReminder(
                        content: result['content'] as String,
                        dueTime: (result['dueTime'] as DateTime?) ?? DateTime.now().add(const Duration(hours: 1)),
                      );
                    }
                  },
                ),
              ],
            ),
            SliverToBoxAdapter(
              child: _SectionHeader(title: '进行中', count: activeReminders.length),
            ),
            if (activeReminders.isEmpty)
              SliverToBoxAdapter(
                child: Padding(
                  padding: const EdgeInsets.all(AppSpacing.xxl),
                  child: Text('暂无待办', style: AppTextStyles.bodyMedium(secondaryColor)),
                ),
              )
            else
              SliverList(
                delegate: SliverChildBuilderDelegate(
                  (context, index) => TodoItem(
                    reminder: activeReminders[index],
                    onToggle: () {
                      ref.read(reminderRepositoryProvider).completeReminder(activeReminders[index].id);
                    },
                    onDelete: () {
                      ref.read(reminderRepositoryProvider).deleteReminder(activeReminders[index].id);
                    },
                    onTap: () {
                      // Edit - can reuse input sheet
                    },
                  ),
                  childCount: activeReminders.length,
                ),
              ),
            SliverToBoxAdapter(
              child: GestureDetector(
                onTap: () => setState(() => _showCompleted = !_showCompleted),
                child: _SectionHeader(
                  title: '已完成 (${completedReminders.length})',
                  trailing: Icon(
                    _showCompleted ? Icons.expand_less : Icons.expand_more,
                    color: secondaryColor,
                  ),
                ),
              ),
            ),
            if (_showCompleted) ...[
              if (completedReminders.isEmpty)
                SliverToBoxAdapter(
                  child: Padding(
                    padding: const EdgeInsets.all(AppSpacing.xxl),
                    child: Text('暂无已完成的待办', style: AppTextStyles.bodyMedium(secondaryColor)),
                  ),
                )
              else
                SliverList(
                  delegate: SliverChildBuilderDelegate(
                    (context, index) => Opacity(
                      opacity: 0.6,
                      child: TodoItem(
                        reminder: completedReminders[index],
                        onToggle: () {},
                        onDelete: () {
                          ref.read(reminderRepositoryProvider).deleteReminder(completedReminders[index].id);
                        },
                        onTap: () {},
                      ),
                    ),
                    childCount: completedReminders.length,
                  ),
                ),
            ],
            const SliverToBoxAdapter(child: SizedBox(height: 80)),
          ],
        ),
      ),
    );
  }
}

class _SectionHeader extends StatelessWidget {
  final String title;
  final int? count;
  final Widget? trailing;

  const _SectionHeader({required this.title, this.count, this.trailing});

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;
    final secondaryColor = isDark ? AppColors.darkTextSecondary : AppColors.textSecondary;

    return Padding(
      padding: const EdgeInsets.fromLTRB(AppSpacing.lg, AppSpacing.lg, AppSpacing.lg, AppSpacing.sm),
      child: Row(
        children: [
          Text(
            count != null ? '$title ($count)' : title,
            style: AppTextStyles.bodySmall(secondaryColor).copyWith(fontWeight: FontWeight.w600),
          ),
          if (trailing != null) ...[
            const Spacer(),
            trailing!,
          ],
        ],
      ),
    );
  }
}
