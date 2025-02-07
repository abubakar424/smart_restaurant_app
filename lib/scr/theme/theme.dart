import 'package:flutter/material.dart';
import 'package:smart_restaurant_app/scr/theme/color_scheme.dart';
import 'package:smart_restaurant_app/scr/theme/text_theme.dart';

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
      colorScheme: colorSchemeLight,
      textTheme: textTheme,
    );
  }
}
