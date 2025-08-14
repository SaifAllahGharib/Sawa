import 'package:flutter/material.dart';
import 'package:sawa/core/extensions/build_context_extensions.dart';
import 'package:sawa/core/extensions/number_extensions.dart';

import '../../../../core/styles/app_styles.dart';

class LoginTopSection extends StatelessWidget {
  const LoginTopSection({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        20.verticalSpace,
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(context.tr.welcomeBack, style: AppStyles.s30W600),
            10.horizontalSpace,
            Icon(
              Icons.waving_hand_outlined,
              size: 24.r,
              color: context.theme.primaryColor,
            ),
          ],
        ),
      ],
    );
  }
}
