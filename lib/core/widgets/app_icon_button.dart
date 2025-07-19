import 'package:flutter/material.dart';
import 'package:intern_intelligence_social_media_application/core/extensions/build_context_extensions.dart';
import 'package:intern_intelligence_social_media_application/core/extensions/number_extensions.dart';

import '../styles/app_colors.dart';
import 'app_ink_well_button.dart';

class AppIconButton extends StatelessWidget {
  final IconData icon;
  final VoidCallback onPressed;

  const AppIconButton({super.key, required this.icon, required this.onPressed});

  @override
  Widget build(BuildContext context) {
    return Material(
      color: Colors.transparent,
      child: AppInkWellButton(
        onTap: onPressed,
        child: Container(
          padding: EdgeInsets.all(8.r),
          decoration: BoxDecoration(
            color: context.theme.scaffoldBackgroundColor,
            borderRadius: BorderRadius.circular(12.r),
            boxShadow: [
              BoxShadow(
                color: AppColors.gray.withValues(alpha: 0.1),
                blurRadius: 1,
                offset: const Offset(0.7, 0.7),
              ),
              BoxShadow(
                color: AppColors.gray.withValues(alpha: 0.1),
                blurRadius: 1,
                offset: const Offset(-0.7, -0.7),
              ),
            ],
          ),
          child: Icon(icon, size: 26.r, color: context.theme.primaryColor),
        ),
      ),
    );
  }
}
