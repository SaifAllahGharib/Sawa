import 'package:flutter/material.dart';
import 'package:sawa/core/extensions/number_extensions.dart';

import 'app_gesture_detector_button.dart';

class MediaDeleteButton extends StatelessWidget {
  final VoidCallback onClick;

  const MediaDeleteButton({super.key, required this.onClick});

  @override
  Widget build(BuildContext context) {
    return Positioned(
      top: 8.r,
      right: 8.r,
      child: AppGestureDetectorButton(
        onTap: onClick,
        child: Container(
          padding: const EdgeInsets.all(4),
          decoration: const BoxDecoration(
            color: Colors.black54,
            shape: BoxShape.circle,
          ),
          child: const Icon(Icons.close, color: Colors.white, size: 18),
        ),
      ),
    );
  }
}
