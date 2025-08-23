import 'package:flutter/material.dart';
import 'package:sawa/core/extensions/build_context_extensions.dart';
import 'package:sawa/core/routing/app_route_name.dart';

import '../../../../core/services/navigation/navigation_service.dart';
import 'do_not_or_have_account_widget.dart';

class LoginBottomSection extends StatelessWidget {
  const LoginBottomSection({super.key});

  @override
  Widget build(BuildContext context) {
    return DoNotOrHaveAccountWidget(
      onClick: () => NavigationService.I.pushNamed(AppRouteName.signup),
      label: context.tr.doNotHaveAnAccount,
      textButton: context.tr.signup,
    );
  }
}
