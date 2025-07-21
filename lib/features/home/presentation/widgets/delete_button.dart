import 'package:flutter/material.dart';

import '../../../../core/widgets/app_gesture_detector_button.dart';

class DeleteButton extends StatelessWidget {
  final VoidCallback onClick;

  const DeleteButton({super.key, required this.onClick});

  @override
  Widget build(BuildContext context) {
    return Positioned(
      top: 4,
      right: 4,
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
