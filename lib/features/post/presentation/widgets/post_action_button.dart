import 'package:flutter/material.dart';
import 'package:sawa/core/extensions/number_extensions.dart';
import 'package:sawa/core/styles/app_colors.dart';

import '../../../../core/styles/app_styles.dart';
import '../../../../core/widgets/app_gesture_detector_button.dart';

class PostActionButton extends StatelessWidget {
  final Widget icon;
  final String? label;
  final VoidCallback? onPressed;
  final VoidCallback? onLongPress;

  const PostActionButton({
    super.key,
    required this.icon,
    this.label,
    required this.onPressed,
    this.onLongPress,
  });

  @override
  Widget build(BuildContext context) {
    return AppGestureDetectorButton(
      onTap: onPressed ?? () {},
      onLongPress: onLongPress ?? () {},
      child: Padding(
        padding: EdgeInsets.symmetric(vertical: 8.r),
        child: label == null
            ? icon
            : Row(
                children: [
                  icon,
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
