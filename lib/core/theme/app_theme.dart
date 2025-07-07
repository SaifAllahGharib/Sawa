import 'package:flutter/material.dart';

import '../styles/app_colors.dart';
import 'light_theme.dart';

abstract class AppTheme {
  static ThemeData light(BuildContext context) => ThemeData(
    useMaterial3: true,
    brightness: Brightness.light,
    textSelectionTheme: LightTheme.textSelectionThemeData,
    textTheme: LightTheme.textTheme(context),
    scaffoldBackgroundColor: AppColors.lightBackground,
    primaryColor: AppColors.primary,
    colorScheme: LightTheme.colorScheme,
    inputDecorationTheme: LightTheme.inputDecorationTheme(context),
  );
}
