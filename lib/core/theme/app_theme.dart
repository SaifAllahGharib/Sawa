import 'package:flutter/material.dart';
import 'package:intern_intelligence_social_media_application/core/theme/dark_theme.dart';

import '../styles/app_colors.dart';
import 'light_theme.dart';

abstract class AppTheme {
  static ThemeData get light => ThemeData(
    useMaterial3: true,
    brightness: Brightness.light,
    textSelectionTheme: LightTheme.textSelectionThemeData,
    textTheme: LightTheme.textTheme,
    scaffoldBackgroundColor: AppColors.lightBackground,
    primaryColor: AppColors.primaryLight,
    colorScheme: LightTheme.colorScheme,
    extensions: LightTheme.extension,
    inputDecorationTheme: LightTheme.inputDecorationTheme,
  );

  static ThemeData get dark => ThemeData(
    useMaterial3: true,
    brightness: Brightness.dark,
    textSelectionTheme: DarkTheme.textSelectionThemeData,
    textTheme: DarkTheme.textTheme,
    scaffoldBackgroundColor: AppColors.darkBackground,
    primaryColor: AppColors.primaryDark,
    colorScheme: DarkTheme.colorScheme,
    extensions: DarkTheme.extension,
    inputDecorationTheme: DarkTheme.inputDecorationTheme,
  );
}
