import 'package:flutter/material.dart';
import 'package:intern_intelligence_social_media_application/core/extensions/build_context_extensions.dart';

import 'app_ink_well_button.dart';

class AppBackButton extends StatelessWidget {
  const AppBackButton({super.key});

  @override
  Widget build(BuildContext context) {
    return AppInkWellButton(
      onTap: () => context.navigator.pop(),
      child: const Icon(Icons.arrow_back_ios_new),
    );
  }
}
