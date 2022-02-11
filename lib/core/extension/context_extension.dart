import 'package:flutter/material.dart';
import 'package:teach_2_me/core/init/theme/app_theme_light.dart';

extension ThemeExtension on BuildContext {
  ThemeData get currentTheme => AppThemeLight.instance!.lightTheme;
}
