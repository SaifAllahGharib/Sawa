import 'package:flutter/material.dart';
import 'package:intern_intelligence_social_media_application/core/widgets/app_ink_well_button.dart';

class AppRemoveFocus extends StatelessWidget {
  final Widget child;

  const AppRemoveFocus({super.key, required this.child});

  @override
  Widget build(BuildContext context) {
    return AppInkWellButton(
      onTap: () => FocusScope.of(context).unfocus(),
      child: child,
    );
  }
}
