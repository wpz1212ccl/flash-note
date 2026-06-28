import 'package:flutter/material.dart';
import '../../../core/constants/app_colors.dart';
import '../../../core/utils/haptic_feedback.dart';

class TagData {
  final String name;
  final Color color;
  const TagData(this.name, this.color);
}

const List<TagData> predefinedTags = [
  TagData('灵感', AppColors.tagApricot),
  TagData('随笔', AppColors.tagMint),
  TagData('工作', AppColors.tagSky),
  TagData('梦境', AppColors.tagLavender),
  TagData('情绪', AppColors.tagRose),
  TagData('生活', AppColors.tagSand),
];

class TagSelector extends StatefulWidget {
  final int? selectedIndex;
  final void Function(int index, TagData tag) onTagSelected;

  const TagSelector({
    super.key,
    this.selectedIndex,
    required this.onTagSelected,
  });

  @override
  State<TagSelector> createState() => _TagSelectorState();
}

class _TagSelectorState extends State<TagSelector> {
  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: List.generate(predefinedTags.length, (index) {
        final isSelected = widget.selectedIndex == index;
        return GestureDetector(
          onTap: () {
            HapticHelper.light();
            widget.onTagSelected(index, predefinedTags[index]);
          },
          child: AnimatedContainer(
            duration: const Duration(milliseconds: 200),
            width: isSelected ? 30 : 24,
            height: isSelected ? 30 : 24,
            margin: const EdgeInsets.symmetric(horizontal: 6),
            decoration: BoxDecoration(
              color: predefinedTags[index].color,
              shape: BoxShape.circle,
              border: isSelected
                  ? Border.all(color: predefinedTags[index].color.withAlpha(60), width: 3)
                  : null,
            ),
          ),
        );
      }),
    );
  }
}
