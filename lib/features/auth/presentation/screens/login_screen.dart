import 'package:flutter/material.dart';
import 'package:intern_intelligence_social_media_application/core/extensions/number_extensions.dart';
import 'package:intern_intelligence_social_media_application/core/widgets/app_padding_widget.dart';
import 'package:intern_intelligence_social_media_application/core/widgets/app_remove_focus.dart';
import 'package:intern_intelligence_social_media_application/core/widgets/app_scaffold.dart';

import '../widgets/login_bottom_section.dart';
import '../widgets/login_middle_section.dart';
import '../widgets/login_top_section.dart';

class LoginScreen extends StatelessWidget {
  const LoginScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return AppScaffold(
      child: AppPaddingWidget(
        child: AppRemoveFocus(
          child: SingleChildScrollView(
            child: Column(
              children: [
                const LoginTopSection(),
                20.verticalSpace,
                const LoginMiddleSection(),
                10.verticalSpace,
                const LoginBottomSection(),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
