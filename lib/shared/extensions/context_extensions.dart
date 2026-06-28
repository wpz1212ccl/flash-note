import 'package:flutter/material.dart';

extension BuildContextExt on BuildContext {
  ThemeData get theme => Theme.of(this);
  ColorScheme get colorScheme => Theme.of(this).colorScheme;
  TextTheme get textTheme => Theme.of(this).textTheme;
  bool get isDarkMode => Theme.of(this).brightness == Brightness.dark;
  double get bottomPadding => MediaQuery.of(this).padding.bottom;
  double get topPadding => MediaQuery.of(this).padding.top;
  double get screenWidth => MediaQuery.of(this).size.width;
  double get screenHeight => MediaQuery.of(this).size.height;
}
