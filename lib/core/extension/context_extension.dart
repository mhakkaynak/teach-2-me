import 'package:flutter/material.dart';

import '../init/theme/app_theme_light.dart';

extension ContextExtension on BuildContext {
  MediaQueryData get mediaQuery => MediaQuery.of(this);
}

extension MediaQueryExtension on BuildContext {
  double get height => mediaQuery.size.height;

  double get width => mediaQuery.size.width;

  double get lowHeight => height * 0.1;

  double get lowWidth => width * 0.1;

  double get normalHeight => height * 0.3;

  double get normalWidth => width * 0.3;

  double get highHeight => height * 0.4;

  double get highWidth => width * 0.4;

  double customHeight(double value) => height * value;

  double customWidth(double value) => width * value;
}

extension PaddingExtension on BuildContext {
  EdgeInsets get paddingLowSymetric => EdgeInsets.symmetric(
      horizontal: customWidth(0.05), vertical: customHeight(0.03));
}

extension ThemeExtension on BuildContext {
  ThemeData get currentTheme => AppThemeLight.instance!.lightTheme;
}
