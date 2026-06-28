import 'package:flutter/material.dart';
import '../../../../core/constants/app_colors.dart';
import '../../../../core/constants/app_text_styles.dart';
import '../../../../core/constants/app_spacing.dart';
import '../../../../core/utils/date_formatter.dart';
import '../../../../data/database/app_database.dart';
import '../../../../shared/extensions/context_extensions.dart';

class TimelineCard extends StatelessWidget {
  final Entry entry;

  const TimelineCard({super.key, required this.entry});

  @override
  Widget build(BuildContext context) {
    final isDark = context.isDarkMode;
    final cardBg = isDark ? AppColors.darkSurface : AppColors.surface;
    final textColor = isDark ? AppColors.lightCream : AppColors.warmBlack;
    final secondaryColor = isDark ? AppColors.darkTextSecondary : AppColors.textSecondary;
    final borderColor = isDark ? AppColors.darkDivider : AppColors.divider;

    final tagColor = entry.color != null ? Color(int.parse(entry.color!)) : AppColors.apricot;

    return Padding(
      padding: const EdgeInsets.only(left: AppSpacing.xxxl, right: AppSpacing.lg, bottom: AppSpacing.xxl),
      child: Hero(
        tag: 'entry-${entry.id}',
        child: Material(
          color: cardBg,
          borderRadius: BorderRadius.circular(AppSpacing.radiusLg),
          child: InkWell(
            borderRadius: BorderRadius.circular(AppSpacing.radiusLg),
            onTap: () {
              Navigator.of(context).pushNamed('/detail/${entry.id}');
            },
            child: Container(
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(AppSpacing.radiusLg),
                border: Border.all(color: borderColor, width: 0.5),
              ),
              padding: const EdgeInsets.all(AppSpacing.lg),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  if (entry.title != null) ...[
                    Text(
                      entry.title!,
                      style: AppTextStyles.headline3(textColor),
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                    ),
                    const SizedBox(height: AppSpacing.sm),
                  ],
                  Text(
                    entry.content,
                    style: AppTextStyles.bodyMedium(textColor),
                    maxLines: 2,
                    overflow: TextOverflow.ellipsis,
                  ),
                  const SizedBox(height: AppSpacing.md),
                  Row(
                    children: [
                      Text(
                        DateFormatter.cardTime(entry.createdAt),
                        style: AppTextStyles.monospace(secondaryColor).copyWith(fontSize: 12),
                      ),
                      const Spacer(),
                      Container(
                        width: 8,
                        height: 8,
                        decoration: BoxDecoration(
                          color: tagColor,
                          shape: BoxShape.circle,
                        ),
                      ),
                      if (entry.reminderId != null) ...[
                        const SizedBox(width: AppSpacing.sm),
                        Icon(Icons.access_time_rounded, size: 14, color: secondaryColor),
                      ],
                    ],
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
