import 'package:flutter/material.dart';
import 'package:intern_intelligence_social_media_application/core/extensions/number_extensions.dart';

import '../../../../core/widgets/app_gesture_detector_button.dart';

class DeleteButton extends StatelessWidget {
  final VoidCallback onClick;

  const DeleteButton({super.key, required this.onClick});

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
