import 'package:flutter/material.dart';
import 'package:sawa/core/extensions/build_context_extensions.dart';
import 'package:sawa/core/routing/app_route_name.dart';

import 'do_not_or_have_account_widget.dart';

class SignupBottomSection extends StatelessWidget {
  const SignupBottomSection({super.key});

  @override
  Widget build(BuildContext context) {
    return DoNotOrHaveAccountWidget(
      onClick: () => context.navigator.pushNamedAndRemoveUntil(
        AppRouteName.login,
        (route) => false,
      ),
      label: context.tr.ifYouHaveAnAccount,
      textButton: context.tr.login,
    );
  }
}
