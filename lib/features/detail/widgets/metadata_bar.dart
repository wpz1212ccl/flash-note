import 'package:flutter/material.dart';
import '../../../../core/constants/app_colors.dart';
import '../../../../core/constants/app_text_styles.dart';
import '../../../../core/constants/app_spacing.dart';
import '../../../../core/utils/date_formatter.dart';
import '../../../../data/database/app_database.dart';

class MetadataBar extends StatelessWidget {
  final Entry entry;
  final String? reminderStatus;

  const MetadataBar({super.key, required this.entry, this.reminderStatus});

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;
    final secondaryColor = isDark ? AppColors.darkTextSecondary : AppColors.textSecondary;

    final tagColor = entry.color != null ? Color(int.parse(entry.color!)) : null;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Container(
          padding: const EdgeInsets.symmetric(horizontal: AppSpacing.md, vertical: AppSpacing.sm),
          decoration: BoxDecoration(
            color: (isDark ? AppColors.darkSurface : AppColors.surface).withAlpha(128),
            borderRadius: BorderRadius.circular(AppSpacing.radiusSm),
          ),
          child: Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              Icon(Icons.access_time_rounded, size: 14, color: secondaryColor),
              const SizedBox(width: AppSpacing.sm),
              Text(
                DateFormatter.detailPageTime(entry.createdAt),
                style: AppTextStyles.caption(secondaryColor),
              ),
            ],
          ),
        ),
        if (entry.tag != null && tagColor != null) ...[
          const SizedBox(height: AppSpacing.sm),
          Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              Container(
                width: 8,
                height: 8,
                decoration: BoxDecoration(color: tagColor, shape: BoxShape.circle),
              ),
              const SizedBox(width: AppSpacing.sm),
              Text(
                entry.tag!,
                style: AppTextStyles.caption(secondaryColor),
              ),
            ],
          ),
        ],
        if (reminderStatus != null) ...[
          const SizedBox(height: AppSpacing.sm),
          Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              Icon(Icons.notifications_outlined, size: 14, color: secondaryColor),
              const SizedBox(width: AppSpacing.sm),
              Text(
                '提醒已设定：$reminderStatus',
                style: AppTextStyles.caption(secondaryColor),
              ),
            ],
          ),
        ],
      ],
    );
  }
}
