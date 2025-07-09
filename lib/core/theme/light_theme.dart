import 'package:flutter/material.dart';
import 'package:intern_intelligence_social_media_application/core/extensions/number_extensions.dart';
import 'package:intern_intelligence_social_media_application/core/theme/custom_colors.dart';

import '../styles/app_colors.dart';

abstract class LightTheme {
  static TextStyle get _textStyle =>
      const TextStyle(color: AppColors.lightText, fontFamily: 'Cairo');

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
        cursorColor: AppColors.primaryLight,
        selectionColor: AppColors.primaryLight,
        selectionHandleColor: AppColors.primaryLight,
      );

  static ColorScheme colorScheme = const ColorScheme.light(
    primary: AppColors.primaryLight,
    secondary: AppColors.secondaryLight,
    error: AppColors.errorLight,
  );

  static Iterable<ThemeExtension<CustomColors>> get extension =>
      <ThemeExtension<CustomColors>>[
        const CustomColors(textColor: AppColors.lightText),
      ];

  static InputDecorationTheme get inputDecorationTheme => InputDecorationTheme(
    filled: true,
    fillColor: AppColors.whiteGray,
    isDense: true,
    contentPadding: EdgeInsets.symmetric(vertical: 14.r, horizontal: 16.r),
    hintStyle: TextStyle(
      color: AppColors.lightHint,
      fontSize: 14.r,
      fontWeight: FontWeight.w400,
    ),
    enabledBorder: OutlineInputBorder(
      borderRadius: BorderRadius.circular(12.r),
      borderSide: const BorderSide(color: AppColors.lightBorder, width: 1.2),
    ),
    focusedBorder: OutlineInputBorder(
      borderRadius: BorderRadius.circular(12.r),
      borderSide: const BorderSide(color: AppColors.primaryLight, width: 1.6),
    ),
    errorBorder: OutlineInputBorder(
      borderRadius: BorderRadius.circular(12.r),
      borderSide: const BorderSide(color: AppColors.errorLight, width: 1.2),
    ),
    focusedErrorBorder: OutlineInputBorder(
      borderRadius: BorderRadius.circular(12.r),
      borderSide: const BorderSide(color: AppColors.errorLight, width: 1.5),
    ),
    disabledBorder: OutlineInputBorder(
      borderRadius: BorderRadius.circular(12.r),
      borderSide: BorderSide(
        color: AppColors.lightBorder.withValues(alpha: 0.3),
        width: 1,
      ),
    ),
  );
}
