import 'package:flutter/material.dart';
import '../constants/app_colors.dart';
import '../constants/app_text_styles.dart';
import '../constants/app_spacing.dart';

class AppTheme {
  AppTheme._();

  static ThemeData buildLightTheme(Color accentColor) {
    final colorScheme = ColorScheme.fromSeed(
      seedColor: accentColor,
      brightness: Brightness.light,
      primary: accentColor,
      surface: AppColors.surface,
    );

    return ThemeData(
      useMaterial3: true,
      scaffoldBackgroundColor: AppColors.warmWhite,
      colorScheme: colorScheme,
      primaryColor: accentColor,
      textTheme: TextTheme(
        headlineLarge: AppTextStyles.headline1(AppColors.warmBlack),
        headlineMedium: AppTextStyles.headline2(AppColors.warmBlack),
        headlineSmall: AppTextStyles.headline3(AppColors.warmBlack),
        bodyLarge: AppTextStyles.bodyLarge(AppColors.warmBlack),
        bodyMedium: AppTextStyles.bodyMedium(AppColors.warmBlack),
        bodySmall: AppTextStyles.bodySmall(AppColors.warmBlack),
        labelSmall: AppTextStyles.caption(AppColors.textSecondary),
      ),
      appBarTheme: const AppBarTheme(
        backgroundColor: Colors.transparent,
        elevation: 0,
        scrolledUnderElevation: 0,
        surfaceTintColor: Colors.transparent,
      ),
      dividerTheme: const DividerThemeData(
        color: AppColors.divider,
        thickness: 0.5,
        space: 1,
      ),
      cardTheme: CardThemeData(
        color: AppColors.surface,
        elevation: 0,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(AppSpacing.radiusLg),
        ),
      ),
      floatingActionButtonTheme: FloatingActionButtonThemeData(
        backgroundColor: accentColor,
        elevation: 0,
        shape: const CircleBorder(),
      ),
      bottomNavigationBarTheme: BottomNavigationBarThemeData(
        backgroundColor: AppColors.surface,
        elevation: 0,
        selectedItemColor: accentColor,
        unselectedItemColor: AppColors.textSecondary,
      ),
      pageTransitionsTheme: const PageTransitionsTheme(
        builders: {
          TargetPlatform.android: CupertinoPageTransitionsBuilder(),
          TargetPlatform.iOS: CupertinoPageTransitionsBuilder(),
        },
      ),
    );
  }

  static ThemeData buildDarkTheme(Color accentColor) {
    final colorScheme = ColorScheme.fromSeed(
      seedColor: accentColor,
      brightness: Brightness.dark,
      primary: accentColor,
      surface: AppColors.darkSurface,
    );

    return ThemeData(
      useMaterial3: true,
      scaffoldBackgroundColor: AppColors.darkBg,
      colorScheme: colorScheme,
      primaryColor: accentColor,
      textTheme: TextTheme(
        headlineLarge: AppTextStyles.headline1(AppColors.lightCream),
        headlineMedium: AppTextStyles.headline2(AppColors.lightCream),
        headlineSmall: AppTextStyles.headline3(AppColors.lightCream),
        bodyLarge: AppTextStyles.bodyLarge(AppColors.lightCream),
        bodyMedium: AppTextStyles.bodyMedium(AppColors.lightCream),
        bodySmall: AppTextStyles.bodySmall(AppColors.lightCream),
        labelSmall: AppTextStyles.caption(AppColors.darkTextSecondary),
      ),
      appBarTheme: const AppBarTheme(
        backgroundColor: Colors.transparent,
        elevation: 0,
        scrolledUnderElevation: 0,
        surfaceTintColor: Colors.transparent,
      ),
      dividerTheme: const DividerThemeData(
        color: AppColors.darkDivider,
        thickness: 0.5,
        space: 1,
      ),
      cardTheme: CardThemeData(
        color: AppColors.darkSurface,
        elevation: 0,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(AppSpacing.radiusLg),
        ),
      ),
      floatingActionButtonTheme: FloatingActionButtonThemeData(
        backgroundColor: accentColor,
        elevation: 0,
        shape: const CircleBorder(),
      ),
      bottomNavigationBarTheme: BottomNavigationBarThemeData(
        backgroundColor: AppColors.darkSurface,
        elevation: 0,
        selectedItemColor: accentColor,
        unselectedItemColor: AppColors.darkTextSecondary,
      ),
      pageTransitionsTheme: const PageTransitionsTheme(
        builders: {
          TargetPlatform.android: CupertinoPageTransitionsBuilder(),
          TargetPlatform.iOS: CupertinoPageTransitionsBuilder(),
        },
      ),
    );
  }
}
