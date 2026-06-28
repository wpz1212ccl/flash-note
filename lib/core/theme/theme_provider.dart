import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../constants/app_colors.dart';

class ThemeModeNotifier extends StateNotifier<ThemeMode> {
  ThemeModeNotifier() : super(ThemeMode.system) {
    _loadFromPrefs();
  }

  Future<void> _loadFromPrefs() async {
    final prefs = await SharedPreferences.getInstance();
    final modeStr = prefs.getString('theme_mode') ?? 'system';
    state = switch (modeStr) {
      'light' => ThemeMode.light,
      'dark' => ThemeMode.dark,
      _ => ThemeMode.system,
    };
  }

  Future<void> setThemeMode(ThemeMode mode) async {
    state = mode;
    final prefs = await SharedPreferences.getInstance();
    final modeStr = switch (mode) {
      ThemeMode.light => 'light',
      ThemeMode.dark => 'dark',
      ThemeMode.system => 'system',
    };
    await prefs.setString('theme_mode', modeStr);
  }
}

final themeModeProvider = StateNotifierProvider<ThemeModeNotifier, ThemeMode>((ref) {
  return ThemeModeNotifier();
});

class AccentColorNotifier extends StateNotifier<Color> {
  AccentColorNotifier() : super(AppColors.apricot) {
    _loadFromPrefs();
  }

  Future<void> _loadFromPrefs() async {
    final prefs = await SharedPreferences.getInstance();
    final hex = prefs.getString('accent_color');
    if (hex != null) {
      final color = Color(int.parse(hex));
      if (color != state) state = color;
    }
  }

  Future<void> setAccentColor(Color color) async {
    state = color;
    final prefs = await SharedPreferences.getInstance();
    await prefs.setString('accent_color', color.toARGB32().toRadixString(16).padLeft(8, '0'));
  }
}

final accentColorProvider = StateNotifierProvider<AccentColorNotifier, Color>((ref) {
  return AccentColorNotifier();
});
