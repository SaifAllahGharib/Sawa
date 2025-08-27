import 'package:flutter/material.dart';

@immutable
class CustomColors extends ThemeExtension<CustomColors> {
  final Color textColor;
  final Color border;
  final Color icon;
  final Color overlay;

  const CustomColors({
    this.textColor = Colors.black,
    this.border = Colors.grey,
    this.icon = Colors.blue,
    this.overlay = Colors.black12,
  });

  @override
  CustomColors copyWith({
    Color? textColor,
    Color? border,
    Color? icon,
    Color? overlay,
  }) {
    return CustomColors(
      textColor: textColor ?? this.textColor,
      border: border ?? this.border,
      icon: icon ?? this.icon,
      overlay: overlay ?? this.overlay,
    );
  }

  @override
  CustomColors lerp(ThemeExtension<CustomColors>? other, double t) {
    if (other is! CustomColors) return this;
    return CustomColors(
      textColor: Color.lerp(textColor, other.textColor, t)!,
      border: Color.lerp(border, other.border, t)!,
      icon: Color.lerp(icon, other.icon, t)!,
      overlay: Color.lerp(overlay, other.overlay, t)!,
    );
  }
}
