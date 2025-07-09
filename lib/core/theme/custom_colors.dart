import 'package:flutter/material.dart';

@immutable
class CustomColors extends ThemeExtension<CustomColors> {
  final Color? textColor;

  const CustomColors({this.textColor});

  @override
  CustomColors copyWith({Color? textColor}) {
    return CustomColors(textColor: textColor ?? this.textColor);
  }

  @override
  CustomColors lerp(ThemeExtension<CustomColors>? other, double t) {
    if (other is! CustomColors) return this;
    return CustomColors(textColor: Color.lerp(textColor, other.textColor, t)!);
  }
}
