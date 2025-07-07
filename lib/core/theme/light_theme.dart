import 'package:flutter/material.dart';
import 'package:intern_intelligence_social_media_application/core/extensions/number_extensions.dart';

import '../di/dependency_injection.dart';
import '../helpers/shared_preferences_helper.dart';
import '../styles/app_colors.dart';

abstract class LightTheme {
  static TextStyle _textStyle(BuildContext context) => TextStyle(
    color: Colors.black,
    fontFamily: (getIt<SharedPreferencesHelper>().getLanguageCode() == 'ar')
        ? 'cairo'
        : 'poppins',
  );

  static TextTheme textTheme(BuildContext context) => TextTheme(
    bodyLarge: _textStyle(context),
    bodyMedium: _textStyle(context),
    bodySmall: _textStyle(context),
    titleLarge: _textStyle(context),
    titleMedium: _textStyle(context),
    titleSmall: _textStyle(context),
    labelLarge: _textStyle(context),
    labelMedium: _textStyle(context),
    labelSmall: _textStyle(context),
    displayLarge: _textStyle(context),
    displayMedium: _textStyle(context),
    displaySmall: _textStyle(context),
    headlineLarge: _textStyle(context),
    headlineMedium: _textStyle(context),
    headlineSmall: _textStyle(context),
  );

  static const TextSelectionThemeData textSelectionThemeData =
      TextSelectionThemeData(
        cursorColor: AppColors.primary,
        selectionColor: AppColors.primary,
        selectionHandleColor: AppColors.primary,
      );

  static const ColorScheme colorScheme = ColorScheme.light(
    primary: AppColors.primary,
    secondary: AppColors.secondary,
    error: AppColors.error,
  );

  static InputDecorationTheme inputDecorationTheme(BuildContext context) =>
      InputDecorationTheme(
        hintStyle: const TextStyle(color: AppColors.lightHint),
        filled: true,
        fillColor: AppColors.gray.withValues(alpha: 0.2),
        contentPadding: EdgeInsets.symmetric(vertical: 12.r, horizontal: 12.r),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12.r),
          borderSide: BorderSide.none,
        ),
      );
}
