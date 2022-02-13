import 'package:flutter/material.dart';

class AppThemeLight {
  AppThemeLight._init();

  static AppThemeLight? _instance;

  static AppThemeLight? get instance {
    _instance ??= AppThemeLight._init();
    return _instance;
  }

  final ColorScheme _appColorSchema = const ColorScheme.light(
    primary: Color(0xfff9613f),
    secondary: Color(0xfff3c8bf),
    onPrimary: Color(0xffff936b),
    onSecondary: Color(0xfffffbf2),
    background: Colors.white,
  );
  ThemeData get lightTheme => ThemeData(
        colorScheme: _appColorSchema,
        primaryColor: _appColorSchema.primary,
        backgroundColor: _appColorSchema.background,
        hintColor: _appColorSchema.background,
      );
}
