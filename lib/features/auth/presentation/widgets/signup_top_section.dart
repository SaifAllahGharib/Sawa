import 'package:flutter/material.dart';
import 'package:intern_intelligence_social_media_application/core/extensions/build_context_extensions.dart';
import 'package:intern_intelligence_social_media_application/core/extensions/number_extensions.dart';

import '../../../../core/styles/app_styles.dart';
import '../../../../core/widgets/app_back_button.dart';

class SignupTopSection extends StatelessWidget {
  const SignupTopSection({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        20.verticalSpace,
        Row(
          children: [
            const AppBackButton(),
            const Spacer(),
            Text(context.tr.welcome, style: AppStyles.s30W600),
            const Spacer(),
          ],
        ),
      ],
    );
  }
}
