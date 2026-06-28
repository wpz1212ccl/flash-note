import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:path_provider/path_provider.dart';
import 'dart:io';
import '../../core/constants/app_colors.dart';
import '../../core/constants/app_text_styles.dart';
import '../../core/constants/app_spacing.dart';
import '../../core/theme/theme_provider.dart';
import '../../providers/database_provider.dart';
import '../../shared/extensions/context_extensions.dart';
import '../../shared/widgets/confirmation_dialog.dart';
import 'widgets/color_picker.dart';
import 'widgets/font_size_selector.dart';
import 'widgets/export_section.dart';

class SettingsPage extends ConsumerWidget {
  const SettingsPage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final themeMode = ref.watch(themeModeProvider);
    final isDark = context.isDarkMode;
    final bgColor = isDark ? AppColors.darkBg : AppColors.warmWhite;
    final textColor = isDark ? AppColors.lightCream : AppColors.warmBlack;
    final cardBg = isDark ? AppColors.darkSurface : AppColors.surface;

    return Scaffold(
      backgroundColor: bgColor,
      body: SafeArea(
        child: CustomScrollView(
          slivers: [
            SliverAppBar(
              pinned: true,
              backgroundColor: bgColor,
              surfaceTintColor: Colors.transparent,
              title: Text('设置', style: AppTextStyles.headline2(textColor)),
            ),
            SliverToBoxAdapter(
              child: Padding(
                padding: const EdgeInsets.all(AppSpacing.lg),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    _SectionCard(
                      title: '外观',
                      cardBg: cardBg,
                      children: [
                        const SizedBox(height: AppSpacing.sm),
                        Text('主题', style: AppTextStyles.bodySmall(textColor)),
                        const SizedBox(height: AppSpacing.sm),
                        SegmentedButton<ThemeMode>(
                          segments: const [
                            ButtonSegment(value: ThemeMode.system, label: Text('系统')),
                            ButtonSegment(value: ThemeMode.light, label: Text('浅色')),
                            ButtonSegment(value: ThemeMode.dark, label: Text('深色')),
                          ],
                          selected: {themeMode},
                          onSelectionChanged: (set) {
                            ref.read(themeModeProvider.notifier).setThemeMode(set.first);
                          },
                        ),
                        const SizedBox(height: AppSpacing.lg),
                        Text('主色调', style: AppTextStyles.bodySmall(textColor)),
                        const SizedBox(height: AppSpacing.sm),
                        const ColorPicker(),
                        const SizedBox(height: AppSpacing.lg),
                        Text('字号', style: AppTextStyles.bodySmall(textColor)),
                        const SizedBox(height: AppSpacing.sm),
                        const FontSizeSelector(),
                        const SizedBox(height: AppSpacing.md),
                      ],
                    ),
                    const SizedBox(height: AppSpacing.xxl),
                    _SectionCard(
                      title: '数据',
                      cardBg: cardBg,
                      children: [
                        Text('导出记录', style: AppTextStyles.bodySmall(textColor)),
                        const SizedBox(height: AppSpacing.sm),
                        const ExportSection(),
                        const Divider(height: 1),
                        const SizedBox(height: AppSpacing.md),
                        _StorageInfoRow(textColor: textColor),
                        const Divider(height: 1),
                        const SizedBox(height: AppSpacing.md),
                        _ClearCompletedRow(ref: ref),
                      ],
                    ),
                    const SizedBox(height: AppSpacing.xxl),
                    _SectionCard(
                      title: '关于',
                      cardBg: cardBg,
                      children: [
                        _AboutRow(textColor: textColor),
                      ],
                    ),
                    const SizedBox(height: AppSpacing.huge),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _SectionCard extends StatelessWidget {
  final String title;
  final Color cardBg;
  final List<Widget> children;

  const _SectionCard({required this.title, required this.cardBg, required this.children});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(AppSpacing.lg),
      decoration: BoxDecoration(
        color: cardBg,
        borderRadius: BorderRadius.circular(AppSpacing.radiusLg),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: children,
      ),
    );
  }
}

class _StorageInfoRow extends StatelessWidget {
  final Color textColor;
  const _StorageInfoRow({required this.textColor});

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<int>(
      future: _getDbSize(),
      builder: (context, snapshot) {
        final size = snapshot.data;
        final sizeStr = size != null ? '${(size / 1024).toStringAsFixed(1)} KB' : '计算中...';
        return Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text('存储空间', style: AppTextStyles.bodySmall(textColor)),
            Text(sizeStr, style: AppTextStyles.caption(AppColors.textSecondary)),
          ],
        );
      },
    );
  }

  Future<int> _getDbSize() async {
    try {
      final dir = await getApplicationDocumentsDirectory();
      final file = File('${dir.path}/flash_note.db');
      if (await file.exists()) {
        return await file.length();
      }
    } catch (_) {}
    return 0;
  }
}

class _ClearCompletedRow extends StatelessWidget {
  final WidgetRef ref;
  const _ClearCompletedRow({required this.ref});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () async {
        final confirmed = await ConfirmationDialog.show(
          context,
          message: '确定清除所有已完成的提醒吗？',
        );
        if (confirmed == true) {
          await ref.read(reminderDaoProvider).deleteCompletedReminders();
        }
      },
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text('清除已完成提醒', style: AppTextStyles.bodySmall(AppColors.danger)),
        ],
      ),
    );
  }
}

class _AboutRow extends StatelessWidget {
  final Color textColor;
  const _AboutRow({required this.textColor});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text('版本', style: AppTextStyles.bodySmall(textColor)),
            Text('v1.0.0', style: AppTextStyles.caption(AppColors.textSecondary)),
          ],
        ),
        const SizedBox(height: AppSpacing.sm),
        GestureDetector(
          onTap: () {
            showAboutDialog(
              context: context,
              applicationName: '闪念',
              applicationVersion: 'v1.0.0',
              children: [
                const Text('闪念 - 极速灵感捕捉\n完全离线 · 数据本地 · 隐私第一'),
              ],
            );
          },
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text('关于闪念', style: AppTextStyles.bodySmall(textColor)),
              const Icon(Icons.chevron_right, size: 18, color: AppColors.textSecondary),
            ],
          ),
        ),
      ],
    );
  }
}
