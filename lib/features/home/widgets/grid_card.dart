import 'dart:math';
import 'package:flutter/material.dart';
import '../../../../core/constants/app_colors.dart';
import '../../../../core/constants/app_text_styles.dart';
import '../../../../core/constants/app_spacing.dart';
import '../../../../core/utils/date_formatter.dart';
import '../../../../data/database/app_database.dart';
import '../../../../shared/extensions/context_extensions.dart';

class GridCard extends StatefulWidget {
  final Entry entry;

  const GridCard({super.key, required this.entry});

  @override
  State<GridCard> createState() => _GridCardState();
}

class _GridCardState extends State<GridCard> {
  late final double _rotation;

  @override
  void initState() {
    super.initState();
    _rotation = Random().nextDouble() * 4 - 2;
  }

  @override
  Widget build(BuildContext context) {
    final isDark = context.isDarkMode;
    final textColor = isDark ? AppColors.lightCream : AppColors.warmBlack;
    final secondaryColor = isDark ? AppColors.darkTextSecondary : AppColors.textSecondary;

    final tagColor = widget.entry.color != null
        ? Color(int.parse(widget.entry.color!))
        : AppColors.apricot;
    final bgColor = tagColor.withAlpha(20);

    return Hero(
      tag: 'entry-${widget.entry.id}',
      child: Material(
        color: Colors.transparent,
        child: InkWell(
          borderRadius: BorderRadius.circular(AppSpacing.radiusLg),
          onTap: () {
            Navigator.of(context).pushNamed('/detail/${widget.entry.id}');
          },
          child: Transform.rotate(
            angle: _rotation * pi / 180,
            child: Container(
              decoration: BoxDecoration(
                color: bgColor,
                borderRadius: BorderRadius.circular(AppSpacing.radiusLg),
                border: Border.all(
                  color: tagColor.withAlpha(40),
                  width: 0.5,
                ),
                boxShadow: [
                  BoxShadow(
                    color: tagColor.withAlpha(15),
                    blurRadius: 8,
                    offset: const Offset(0, 2),
                  ),
                ],
              ),
              padding: const EdgeInsets.all(AppSpacing.md),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  if (widget.entry.title != null) ...[
                    Text(
                      widget.entry.title!,
                      style: AppTextStyles.headline3(textColor),
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                    ),
                    const SizedBox(height: AppSpacing.sm),
                  ],
                  Expanded(
                    child: Text(
                      widget.entry.content,
                      style: AppTextStyles.bodySmall(textColor),
                      maxLines: 4,
                      overflow: TextOverflow.ellipsis,
                    ),
                  ),
                  const SizedBox(height: AppSpacing.sm),
                  Text(
                    DateFormatter.cardTime(widget.entry.createdAt),
                    style: AppTextStyles.caption(secondaryColor),
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
