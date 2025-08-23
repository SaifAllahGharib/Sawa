import 'package:flutter/material.dart';
import 'package:sawa/core/services/navigation/navigation_service.dart';

import 'app_gesture_detector_button.dart';

class AppBackButton extends StatelessWidget {
  const AppBackButton({super.key});

  @override
  Widget build(BuildContext context) {
    return AppGestureDetectorButton(
      onTap: () {
        final navigator = NavigationService.I;

        if (navigator.canPop()) {
          navigator.pop();
        }
      },
      child: const Icon(Icons.arrow_back_ios_new),
    );
  }
}
