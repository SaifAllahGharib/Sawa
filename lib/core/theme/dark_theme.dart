import 'package:flutter/material.dart';
import 'package:intern_intelligence_social_media_application/core/extensions/number_extensions.dart';

import '../styles/app_colors.dart';
import 'custom_colors.dart';

abstract class DarkTheme {
  static TextStyle get _textStyle =>
      const TextStyle(color: AppColors.darkText, fontFamily: 'Cairo');

  static TextTheme get textTheme => TextTheme(
    bodyLarge: _textStyle,
    bodyMedium: _textStyle,
    bodySmall: _textStyle,
    titleLarge: _textStyle,
    titleMedium: _textStyle,
    titleSmall: _textStyle,
    labelLarge: _textStyle,
    labelMedium: _textStyle,
    labelSmall: _textStyle,
    displayLarge: _textStyle,
    displayMedium: _textStyle,
    displaySmall: _textStyle,
    headlineLarge: _textStyle,
    headlineMedium: _textStyle,
    headlineSmall: _textStyle,
  );

  static TextSelectionThemeData textSelectionThemeData =
      const TextSelectionThemeData(
        cursorColor: AppColors.primaryDark,
        selectionColor: AppColors.primaryDark,
        selectionHandleColor: AppColors.primaryDark,
      );

  static ColorScheme colorScheme = const ColorScheme.light(
    primary: AppColors.primaryDark,
    secondary: AppColors.secondaryDark,
    error: AppColors.errorDark,
  );

  static Iterable<ThemeExtension<CustomColors>> get extension =>
      <ThemeExtension<CustomColors>>[
        const CustomColors(border: AppColors.darkBorder),
      ];

  static InputDecorationTheme get inputDecorationTheme => InputDecorationTheme(
    filled: true,
    fillColor: AppColors.surfaceDark,
    isDense: true,
    contentPadding: EdgeInsets.symmetric(vertical: 14.r, horizontal: 16.r),
    hintStyle: TextStyle(
      color: AppColors.darkHint,
      fontSize: 14.r,
      fontWeight: FontWeight.w400,
    ),
    enabledBorder: OutlineInputBorder(
      borderRadius: BorderRadius.circular(12.r),
      borderSide: const BorderSide(color: AppColors.darkBorder, width: 1.2),
    ),
    focusedBorder: OutlineInputBorder(
      borderRadius: BorderRadius.circular(12.r),
      borderSide: const BorderSide(color: AppColors.primaryDark, width: 1.6),
    ),
    errorBorder: OutlineInputBorder(
      borderRadius: BorderRadius.circular(12.r),
      borderSide: const BorderSide(color: AppColors.errorDark, width: 1.2),
    ),
    focusedErrorBorder: OutlineInputBorder(
      borderRadius: BorderRadius.circular(12.r),
      borderSide: const BorderSide(color: AppColors.errorDark, width: 1.5),
    ),
    disabledBorder: OutlineInputBorder(
      borderRadius: BorderRadius.circular(12.r),
      borderSide: BorderSide(
        color: AppColors.darkBorder.withValues(alpha: 0.3),
        width: 1,
      ),
    ),
  );
}
