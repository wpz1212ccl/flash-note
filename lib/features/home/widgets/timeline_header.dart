import 'package:flutter/material.dart';
import '../../../../core/constants/app_colors.dart';
import '../../../../core/constants/app_text_styles.dart';
import '../../../../core/constants/app_spacing.dart';
import '../../../../core/utils/date_formatter.dart';
import '../../../../shared/extensions/context_extensions.dart';
import '../enums/view_mode.dart';

class TimelineHeader extends StatelessWidget {
  final DateTime date;
  final ViewMode viewMode;
  final VoidCallback onToggleView;
  final VoidCallback onSearch;

  const TimelineHeader({
    super.key,
    required this.date,
    required this.viewMode,
    required this.onToggleView,
    required this.onSearch,
  });

  @override
  Widget build(BuildContext context) {
    final isDark = context.isDarkMode;
    final textColor = isDark ? AppColors.lightCream : AppColors.warmBlack;
    final secondaryColor = isDark ? AppColors.darkTextSecondary : AppColors.textSecondary;

    return Container(
      height: 140,
      padding: const EdgeInsets.only(left: AppSpacing.lg, right: AppSpacing.lg, top: AppSpacing.xxxl),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            crossAxisAlignment: CrossAxisAlignment.end,
            children: [
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      DateFormatter.homeLargeDate(date),
                      style: AppTextStyles.headline1(textColor),
                    ),
                    const SizedBox(height: AppSpacing.xs),
                    Text(
                      DateFormatter.homeSubtitle(date),
                      style: AppTextStyles.bodySmall(secondaryColor),
                    ),
                  ],
                ),
              ),
              Row(
                children: [
                  IconButton(
                    icon: Icon(viewMode == ViewMode.grid ? Icons.view_timeline_outlined : Icons.grid_view_rounded, size: 22),
                    color: secondaryColor,
                    onPressed: onToggleView,
                  ),
                  IconButton(
                    icon: const Icon(Icons.search_rounded, size: 22),
                    color: secondaryColor,
                    onPressed: onSearch,
                  ),
                ],
              ),
            ],
          ),
        ],
      ),
    );
  }
}

class CollapsedHeader extends StatelessWidget {
  final DateTime date;
  final ViewMode viewMode;
  final VoidCallback onToggleView;
  final VoidCallback onSearch;

  const CollapsedHeader({
    super.key,
    required this.date,
    required this.viewMode,
    required this.onToggleView,
    required this.onSearch,
  });

  @override
  Widget build(BuildContext context) {
    final secondaryColor = context.isDarkMode ? AppColors.darkTextSecondary : AppColors.textSecondary;

    return Container(
      height: 60,
      padding: const EdgeInsets.symmetric(horizontal: AppSpacing.lg),
      child: Row(
        children: [
          Text(
            DateFormatter.collapsedTitle(date),
            style: AppTextStyles.headline3(context.isDarkMode ? AppColors.lightCream : AppColors.warmBlack),
          ),
          const Spacer(),
          IconButton(
            icon: Icon(viewMode == ViewMode.grid ? Icons.view_timeline_outlined : Icons.grid_view_rounded, size: 22),
            color: secondaryColor,
            onPressed: onToggleView,
          ),
          IconButton(
            icon: const Icon(Icons.search_rounded, size: 22),
            color: secondaryColor,
            onPressed: onSearch,
          ),
        ],
      ),
    );
  }
}
