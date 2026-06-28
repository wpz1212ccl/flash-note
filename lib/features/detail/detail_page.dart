import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../core/constants/app_colors.dart';
import '../../core/constants/app_text_styles.dart';
import '../../core/constants/app_spacing.dart';
import '../../providers/entry_providers.dart';
import '../../shared/extensions/context_extensions.dart';
import '../../shared/widgets/confirmation_dialog.dart';
import 'widgets/metadata_bar.dart';

class DetailPage extends ConsumerWidget {
  final String entryId;

  const DetailPage({super.key, required this.entryId});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final entryAsync = ref.watch(singleEntryProvider(entryId));
    final isDark = context.isDarkMode;
    final bgColor = isDark ? AppColors.darkBg : AppColors.warmWhite;
    final textColor = isDark ? AppColors.lightCream : AppColors.warmBlack;
    return Scaffold(
      backgroundColor: bgColor,
      body: entryAsync.when(
        data: (entry) {
          if (entry == null) {
            return Center(child: Text('条目不存在', style: AppTextStyles.bodyMedium(AppColors.textSecondary)));
          }

          return CustomScrollView(
            slivers: [
              SliverAppBar(
                pinned: true,
                backgroundColor: bgColor,
                leading: IconButton(
                  icon: const Icon(Icons.arrow_back_ios_rounded, size: 20),
                  onPressed: () => Navigator.pop(context),
                ),
                actions: [
                  IconButton(
                    icon: const Icon(Icons.edit_outlined, size: 20),
                    onPressed: () {
                      Navigator.pushNamed(context, '/capture', arguments: entryId);
                    },
                  ),
                  IconButton(
                    icon: const Icon(Icons.delete_outline, size: 20),
                    onPressed: () async {
                      final confirmed = await ConfirmationDialog.show(
                        context,
                        message: '确定删除这条记录吗？',
                      );
                      if (confirmed == true) {
                        await ref.read(entryRepositoryProvider).deleteEntry(entryId);
                        if (context.mounted) Navigator.pop(context);
                      }
                    },
                  ),
                ],
              ),
              SliverToBoxAdapter(
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: AppSpacing.xxl),
                  child: Hero(
                    tag: 'entry-${entry.id}',
                    child: Material(
                      type: MaterialType.transparency,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          if (entry.title != null) ...[
                            Text(
                              entry.title!,
                              style: AppTextStyles.headline2(textColor),
                            ),
                            const SizedBox(height: AppSpacing.lg),
                          ],
                          Text(
                            entry.content,
                            style: AppTextStyles.bodyLarge(textColor),
                          ),
                          const SizedBox(height: AppSpacing.xxxl),
                          MetadataBar(
                            entry: entry,
                            reminderStatus: entry.reminderId != null ? '已设定' : null,
                          ),
                          const SizedBox(height: AppSpacing.huge),
                        ],
                      ),
                    ),
                  ),
                ),
              ),
            ],
          );
        },
        loading: () => const Center(child: CircularProgressIndicator()),
        error: (err, _) => Center(child: Text('加载失败: $err')),
      ),
    );
  }
}
