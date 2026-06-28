import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../features/home/enums/view_mode.dart';

class ViewModeNotifier extends StateNotifier<ViewMode> {
  ViewModeNotifier() : super(ViewMode.timeline) {
    _loadFromPrefs();
  }

  Future<void> _loadFromPrefs() async {
    final prefs = await SharedPreferences.getInstance();
    final mode = prefs.getString('view_mode') ?? 'timeline';
    state = mode == 'grid' ? ViewMode.grid : ViewMode.timeline;
  }

  Future<void> setViewMode(ViewMode mode) async {
    state = mode;
    final prefs = await SharedPreferences.getInstance();
    await prefs.setString('view_mode', mode == ViewMode.grid ? 'grid' : 'timeline');
  }
}

final viewModeProvider = StateNotifierProvider<ViewModeNotifier, ViewMode>((ref) {
  return ViewModeNotifier();
});

class FontSizeNotifier extends StateNotifier<String> {
  FontSizeNotifier() : super('m') {
    _loadFromPrefs();
  }

  Future<void> _loadFromPrefs() async {
    final prefs = await SharedPreferences.getInstance();
    state = prefs.getString('font_size') ?? 'm';
  }

  Future<void> setFontSize(String size) async {
    state = size;
    final prefs = await SharedPreferences.getInstance();
    await prefs.setString('font_size', size);
  }

  double get scale {
    return switch (state) {
      's' => 0.85,
      'm' => 1.0,
      'l' => 1.15,
      'xl' => 1.3,
      _ => 1.0,
    };
  }
}

final fontSizeProvider = StateNotifierProvider<FontSizeNotifier, String>((ref) {
  return FontSizeNotifier();
});

class DefaultTagNotifier extends StateNotifier<String?> {
  DefaultTagNotifier() : super(null) {
    _loadFromPrefs();
  }

  Future<void> _loadFromPrefs() async {
    final prefs = await SharedPreferences.getInstance();
    state = prefs.getString('default_tag');
  }

  Future<void> setDefaultTag(String? tag) async {
    state = tag;
    final prefs = await SharedPreferences.getInstance();
    if (tag != null) {
      await prefs.setString('default_tag', tag);
    } else {
      await prefs.remove('default_tag');
    }
  }
}

final defaultTagProvider = StateNotifierProvider<DefaultTagNotifier, String?>((ref) {
  return DefaultTagNotifier();
});
