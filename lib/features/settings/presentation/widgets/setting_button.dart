import 'package:flutter/material.dart';
import 'package:intern_intelligence_social_media_application/core/extensions/build_context_extensions.dart';
import 'package:intern_intelligence_social_media_application/core/extensions/number_extensions.dart';
import 'package:intern_intelligence_social_media_application/core/styles/app_colors.dart';

import '../../../../core/styles/app_styles.dart';

class SettingButton extends StatelessWidget {
  final String text;
  final VoidCallback onTap;
  final IconData icon;

  const SettingButton({
    super.key,
    required this.text,
    required this.onTap,
    this.icon = Icons.arrow_forward_ios_rounded,
  });

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      borderRadius: BorderRadius.circular(12),
      splashColor: AppColors.gray.withValues(alpha: 0.1),
      highlightColor: Colors.transparent,
      child: Padding(
        padding: EdgeInsets.symmetric(vertical: 14.r),
        child: Column(
          children: [
            Row(
              children: [
                Expanded(child: Text(text, style: AppStyles.s18W500)),
                Icon(icon, size: 18, color: context.customColor.icon),
              ],
            ),
            12.verticalSpace,
            Divider(
              height: 1,
              thickness: 0.7,
              color: context.customColor.border!.withValues(alpha: 0.5),
            ),
          ],
        ),
      ),
    );
  }
}
