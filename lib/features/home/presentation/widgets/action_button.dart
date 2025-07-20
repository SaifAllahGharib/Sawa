import 'package:flutter/material.dart';
import 'package:intern_intelligence_social_media_application/core/extensions/number_extensions.dart';

import '../../../../core/styles/app_colors.dart';
import '../../../../core/styles/app_styles.dart';
import '../../../../core/widgets/app_gesture_detector_button.dart';

class ActionButton extends StatelessWidget {
  final IconData icon;
  final String? label;
  final VoidCallback onPressed;

  const ActionButton({
    super.key,
    required this.icon,
    this.label,
    required this.onPressed,
  });

  @override
  Widget build(BuildContext context) {
    return AppGestureDetectorButton(
      onTap: onPressed,
      child: Padding(
        padding: EdgeInsets.symmetric(vertical: 8.r, horizontal: 12.r),
        child: label == null
            ? Icon(icon, size: 20.r, color: AppColors.gray)
            : Row(
                children: [
                  Icon(icon, size: 20.r, color: AppColors.gray),
                  6.horizontalSpace,
                  Text(
                    label ?? '',
                    style: AppStyles.s14W500.copyWith(color: AppColors.gray),
                  ),
                ],
              ),
      ),
    );
  }
}
