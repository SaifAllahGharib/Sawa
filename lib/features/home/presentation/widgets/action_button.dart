import 'package:flutter/material.dart';
import 'package:intern_intelligence_social_media_application/core/extensions/number_extensions.dart';
import 'package:intern_intelligence_social_media_application/core/widgets/app_ink_well_button.dart';

import '../../../../core/styles/app_colors.dart';
import '../../../../core/styles/app_styles.dart';

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
    return AppInkWellButton(
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
