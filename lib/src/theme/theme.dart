
import 'package:flutter/material.dart';
import 'package:smart_restaurant_app/src/theme/widget_themes/app_text_theme.dart';

import 'color_scheme.dart';

class AppTheme {
  AppTheme._();

  factory AppTheme() {
    return instance;
  }

  static final AppTheme instance = AppTheme._();

  ThemeData get lightTheme {
    return ThemeData(
      useMaterial3: true,
      brightness: Brightness.light,
      // appBarTheme: appBarTheme,
      colorScheme: colorSchemeLight,
      // tabBarTheme: tabBarTheme,
      textTheme: appTextTheme,
    );
  }
}
