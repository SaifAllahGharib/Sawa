import 'package:flutter/material.dart';
import 'package:intern_intelligence_social_media_application/core/extensions/build_context_extensions.dart';
import 'package:intern_intelligence_social_media_application/core/extensions/number_extensions.dart';
import 'package:intern_intelligence_social_media_application/core/styles/app_colors.dart';

import '../../../../core/widgets/app_gesture_detector_button.dart';

class TextProfileInfoWidget extends StatelessWidget {
  final String name;
  final VoidCallback onEditTap;
  final TextStyle textStyle;

  const TextProfileInfoWidget({
    super.key,
    required this.name,
    required this.onEditTap,
    required this.textStyle,
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: double.infinity,
      child: Wrap(
        alignment: WrapAlignment.spaceBetween,
        children: [
          Text(name, style: textStyle),
          AppGestureDetectorButton(
            onTap: onEditTap,
            child: Container(
              padding: EdgeInsets.all(10.r),
              decoration: BoxDecoration(
                color: AppColors.whiteGray,
                borderRadius: BorderRadius.circular(13.r),
              ),
              child: Icon(
                Icons.edit,
                size: 20.r,
                color: context.customColor.icon,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
