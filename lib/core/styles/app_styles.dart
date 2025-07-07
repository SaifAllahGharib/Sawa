import 'package:flutter/material.dart';

import '../../core/extensions/number_extensions.dart';

abstract class AppStyles {
  /// ----------- Sizes 11 --------------------
  static TextStyle get s11W400 =>
      TextStyle(fontSize: 11.f, fontWeight: FontWeight.w400);

  /// -----------------------------------------

  /// ----------- Sizes 12 --------------------
  static TextStyle get s12W400 =>
      TextStyle(fontSize: 12.f, fontWeight: FontWeight.w400);

  /// -----------------------------------------

  /// ----------- Sizes 15 --------------------
  static TextStyle get s15W400 =>
      TextStyle(fontSize: 15.f, fontWeight: FontWeight.w400);

  static TextStyle get s15W500 =>
      TextStyle(fontSize: 15.f, fontWeight: FontWeight.w500);

  static TextStyle get s15W600 =>
      TextStyle(fontSize: 15.f, fontWeight: FontWeight.w600);

  /// -----------------------------------------

  /// ----------- Sizes 16 --------------------
  static TextStyle get s16W500 =>
      TextStyle(fontSize: 16.f, fontWeight: FontWeight.w500);

  /// -----------------------------------------

  /// ----------- Sizes 18 --------------------
  static TextStyle get s18W500 =>
      TextStyle(fontSize: 18.f, fontWeight: FontWeight.w500);

  static TextStyle get s18W600 =>
      TextStyle(fontSize: 18.f, fontWeight: FontWeight.w600);

  /// -----------------------------------------

  /// ----------- Sizes 20 --------------------
  static TextStyle get s20WB =>
      TextStyle(fontSize: 20.f, fontWeight: FontWeight.bold);

  /// -----------------------------------------

  /// ----------- Sizes 30 --------------------
  static TextStyle get s30W600 =>
      TextStyle(fontSize: 30.f, fontWeight: FontWeight.w600);

  /// -----------------------------------------
}
