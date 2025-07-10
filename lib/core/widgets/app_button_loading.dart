import 'package:flutter/material.dart';
import 'package:intern_intelligence_social_media_application/core/extensions/build_context_extensions.dart';
import 'package:intern_intelligence_social_media_application/core/extensions/number_extensions.dart';

class AppButtonLoading extends StatelessWidget {
  final double? width;
  final Color? background;

  const AppButtonLoading({super.key, this.width, this.background});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: width ?? double.infinity,
      child: ElevatedButton(
        onPressed: null,
        style: ButtonStyle(
          backgroundColor: WidgetStatePropertyAll(
            background ?? context.theme.primaryColor.withValues(alpha: 0.3),
          ),
          padding: WidgetStatePropertyAll(EdgeInsets.symmetric(vertical: 12.r)),
        ),
        child: SizedBox(
          width: 20.w,
          height: 20.w,
          child: const CircularProgressIndicator(
            strokeWidth: 2.5,
            valueColor: AlwaysStoppedAnimation<Color>(Colors.white),
          ),
        ),
      ),
    );
  }
}
