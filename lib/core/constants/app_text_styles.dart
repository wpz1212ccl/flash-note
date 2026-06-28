import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class AppTextStyles {
  AppTextStyles._();

  static TextStyle headline1(Color color) => GoogleFonts.notoSerifSc(
    fontSize: 36,
    fontWeight: FontWeight.w700,
    color: color,
  );

  static TextStyle headline2(Color color) => GoogleFonts.notoSansSc(
    fontSize: 24,
    fontWeight: FontWeight.w600,
    color: color,
  );

  static TextStyle headline3(Color color) => GoogleFonts.notoSansSc(
    fontSize: 20,
    fontWeight: FontWeight.w600,
    color: color,
  );

  static TextStyle bodyLarge(Color color) => GoogleFonts.notoSansSc(
    fontSize: 18,
    fontWeight: FontWeight.w400,
    color: color,
    height: 1.8,
  );

  static TextStyle bodyMedium(Color color) => GoogleFonts.notoSansSc(
    fontSize: 16,
    fontWeight: FontWeight.w400,
    color: color,
  );

  static TextStyle bodySmall(Color color) => GoogleFonts.notoSansSc(
    fontSize: 14,
    fontWeight: FontWeight.w400,
    color: color,
  );

  static TextStyle caption(Color color) => GoogleFonts.notoSansSc(
    fontSize: 12,
    fontWeight: FontWeight.w400,
    color: color,
  );

  static TextStyle monospace(Color color) => GoogleFonts.dmMono(
    fontSize: 14,
    fontWeight: FontWeight.w400,
    color: color,
  );
}
