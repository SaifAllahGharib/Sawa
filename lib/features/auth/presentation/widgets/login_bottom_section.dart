import 'package:flutter/material.dart';
import 'package:intern_intelligence_social_media_application/core/extensions/build_context_extensions.dart';

import 'do_not_or_have_account_widget.dart';

class LoginBottomSection extends StatelessWidget {
  const LoginBottomSection({super.key});

  @override
  Widget build(BuildContext context) {
    return DoNotOrHaveAccountWidget(
      label: context.tr.doNotHaveAnAccount,
      textButton: context.tr.signup,
    );
  }
}
