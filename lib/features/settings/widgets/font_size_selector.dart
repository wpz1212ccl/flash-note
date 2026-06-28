import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../../../core/constants/app_colors.dart';
import '../../../../core/constants/app_spacing.dart';
import '../../../../providers/settings_providers.dart';
import '../../../../shared/extensions/context_extensions.dart';

class FontSizeSelector extends ConsumerWidget {
  const FontSizeSelector({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final currentSize = ref.watch(fontSizeProvider);
    final isDark = context.isDarkMode;
    final selectedColor = isDark ? AppColors.lightCream : AppColors.warmBlack;
    final unselectedColor = isDark ? AppColors.darkTextSecondary : AppColors.textSecondary;

    final options = [
      ('小', 's', 14.0),
      ('中', 'm', 16.0),
      ('大', 'l', 18.0),
      ('极大', 'xl', 20.0),
    ];

    return Row(
      children: options.map((opt) {
        final isSelected = currentSize == opt.$2;
        return Expanded(
          child: GestureDetector(
            onTap: () => ref.read(fontSizeProvider.notifier).setFontSize(opt.$2),
            child: AnimatedContainer(
              duration: const Duration(milliseconds: 200),
              margin: const EdgeInsets.only(right: AppSpacing.sm),
              padding: const EdgeInsets.symmetric(vertical: AppSpacing.sm),
              decoration: BoxDecoration(
                color: isSelected
                    ? (isDark ? AppColors.darkDivider : AppColors.divider)
                    : Colors.transparent,
                borderRadius: BorderRadius.circular(AppSpacing.radiusSm),
              ),
              child: Column(
                children: [
                  Text(
                    opt.$1,
                    style: TextStyle(
                      color: isSelected ? selectedColor : unselectedColor,
                      fontWeight: isSelected ? FontWeight.w600 : FontWeight.w400,
                    ),
                  ),
                  const SizedBox(height: 4),
                  Text(
                    'Aa',
                    style: TextStyle(
                      fontSize: opt.$3,
                      color: isSelected ? selectedColor : unselectedColor,
                    ),
                  ),
                ],
              ),
            ),
          ),
        );
      }).toList(),
    );
  }
}
