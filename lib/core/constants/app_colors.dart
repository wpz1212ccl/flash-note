import 'package:flutter/material.dart';

class AppColors {
  AppColors._();

  // 浅色模式调色板
  static const warmWhite = Color(0xFFFAF8F5);
  static const surface = Color(0xFFFFFFFF);
  static const warmBlack = Color(0xFF2D2A26);
  static const textSecondary = Color(0xFF9E9890);
  static const divider = Color(0xFFEEEAE5);

  // 深色模式调色板
  static const darkBg = Color(0xFF1A1916);
  static const darkSurface = Color(0xFF252320);
  static const lightCream = Color(0xFFEDE8E0);
  static const darkTextSecondary = Color(0xFF706B63);
  static const darkDivider = Color(0xFF353230);

  // 主强调色
  static const apricot = Color(0xFFE8A87C);

  // 标签色板
  static const tagApricot = Color(0xFFE8A87C);
  static const tagMint = Color(0xFF7EC8A0);
  static const tagSky = Color(0xFF7EB5D6);
  static const tagLavender = Color(0xFFB8A0D8);
  static const tagRose = Color(0xFFD89A9A);
  static const tagSand = Color(0xFFD4C5A0);

  // 状态色
  static const danger = Color(0xFFD85A5A);
  static const success = Color(0xFF6BBF7A);

  // 6个预设标签
  static const List<Color> tagColors = [
    tagApricot,
    tagMint,
    tagSky,
    tagLavender,
    tagRose,
    tagSand,
  ];

  // 色板选择器颜色
  static const List<Color> accentOptions = [
    apricot,
    tagMint,
    tagSky,
    tagLavender,
    tagRose,
    tagSand,
    Color(0xFF666666),
    Color(0xFF222222),
  ];
}
