import 'package:flutter/material.dart';
import 'package:intern_intelligence_social_media_application/core/extensions/number_extensions.dart';

import '../styles/app_colors.dart';
import '../styles/app_styles.dart';
import 'app_gesture_detector_button.dart';

class PostActionButton extends StatelessWidget {
  final IconData icon;
  final Color iconColor;
  final String? label;
  final VoidCallback? onPressed;

  const PostActionButton({
    super.key,
    required this.icon,
    this.label,
    required this.onPressed,
    required this.iconColor,
  });

  @override
  Widget build(BuildContext context) {
    return AppGestureDetectorButton(
      onTap: onPressed ?? () {},
      child: Padding(
        padding: EdgeInsets.symmetric(vertical: 8.r),
        child: label == null
            ? Icon(icon, size: 20.r, color: iconColor)
            : Row(
                children: [
                  Icon(icon, size: 20.r, color: iconColor),
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
