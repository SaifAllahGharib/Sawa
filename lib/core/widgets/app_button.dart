import 'package:flutter/material.dart';
import 'package:sawa/core/extensions/build_context_extensions.dart';
import 'package:sawa/core/extensions/number_extensions.dart';
import 'package:sawa/core/styles/app_styles.dart';

class AppButton extends StatelessWidget {
  final VoidCallback onClick;
  final String text;
  final Color? background;
  final Color? textColor;
  final double? width;
  final bool enabled;
  final BorderRadiusGeometry? borderRadius;
  final EdgeInsets? padding;

  const AppButton({
    super.key,
    required this.onClick,
    required this.text,
    this.background,
    this.textColor,
    this.width,
    this.enabled = false,
    this.borderRadius,
    this.padding,
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: width ?? double.infinity,
      child: ElevatedButton(
        onPressed: enabled ? onClick : null,
        style: ButtonStyle(
          enableFeedback: false,
          shape: WidgetStatePropertyAll(
            RoundedRectangleBorder(
              borderRadius: borderRadius ?? BorderRadius.circular(1000.r),
            ),
          ),
          backgroundColor: WidgetStatePropertyAll(
            enabled
                ? (background ?? context.theme.primaryColor)
                : context.theme.primaryColor.withValues(alpha: 0.3),
          ),
          padding: WidgetStatePropertyAll(
            padding ?? EdgeInsets.symmetric(vertical: 12.r),
          ),
        ),
        child: Text(
          text,
          style: AppStyles.s15W600.copyWith(color: textColor ?? Colors.white),
        ),
      ),
    );
  }
}
