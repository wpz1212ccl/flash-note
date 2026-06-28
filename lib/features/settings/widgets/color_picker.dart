import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../../../core/constants/app_colors.dart';
import '../../../../core/constants/app_spacing.dart';
import '../../../../core/theme/theme_provider.dart';

class ColorPicker extends ConsumerWidget {
  const ColorPicker({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final selectedColor = ref.watch(accentColorProvider);

    return Wrap(
      spacing: AppSpacing.md,
      runSpacing: AppSpacing.md,
      children: AppColors.accentOptions.map((color) {
        final isSelected = color.toARGB32() == selectedColor.toARGB32();
        return GestureDetector(
          onTap: () => ref.read(accentColorProvider.notifier).setAccentColor(color),
          child: AnimatedContainer(
            duration: const Duration(milliseconds: 200),
            width: 36,
            height: 36,
            decoration: BoxDecoration(
              color: color,
              shape: BoxShape.circle,
              border: Border.all(
                color: isSelected ? Colors.white : Colors.transparent,
                width: 3,
              ),
              boxShadow: isSelected
                  ? [BoxShadow(color: selectedColor.withAlpha(100), blurRadius: 8, spreadRadius: 2)]
                  : null,
            ),
          ),
        );
      }).toList(),
    );
  }
}
