import 'package:flutter/material.dart';

@immutable
class CustomColors extends ThemeExtension<CustomColors> {
  final Color? border;

  const CustomColors({this.border});

  @override
  CustomColors copyWith({Color? border}) {
    return CustomColors(border: border ?? this.border);
  }

  @override
  CustomColors lerp(ThemeExtension<CustomColors>? other, double t) {
    if (other is! CustomColors) return this;
    return CustomColors(border: Color.lerp(border, other.border, t)!);
  }
}
