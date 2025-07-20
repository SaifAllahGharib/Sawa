import 'package:flutter/material.dart';

import 'app_gesture_detector_button.dart';

class AppRemoveFocus extends StatelessWidget {
  final Widget child;

  const AppRemoveFocus({super.key, required this.child});

  @override
  Widget build(BuildContext context) {
    return AppGestureDetectorButton(
      onTap: () => FocusScope.of(context).unfocus(),
      child: child,
    );
  }
}
