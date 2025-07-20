import 'package:flutter/material.dart';

import '../../../../core/extensions/build_context_extensions.dart';
import '../../../../core/extensions/number_extensions.dart';
import '../../../../core/styles/app_styles.dart';
import '../../../../core/widgets/app_gesture_detector_button.dart';

class DoNotOrHaveAccountWidget extends StatelessWidget {
  final String label;
  final String textButton;
  final VoidCallback onClick;

  const DoNotOrHaveAccountWidget({
    super.key,
    required this.label,
    required this.textButton,
    required this.onClick,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Text(label, style: AppStyles.s15W500),
        4.horizontalSpace,
        AppGestureDetectorButton(
          onTap: onClick,
          child: Text(
            textButton,
            style: AppStyles.s15WB.copyWith(color: context.theme.primaryColor),
          ),
        ),
      ],
    );
  }
}
