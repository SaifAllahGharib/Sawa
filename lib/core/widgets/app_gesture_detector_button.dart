import 'package:flutter/material.dart';

class AppGestureDetectorButton extends StatelessWidget {
  final Widget child;
  final VoidCallback onTap;

  const AppGestureDetectorButton({
    super.key,
    required this.child,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      behavior: HitTestBehavior.opaque,
      onTap: onTap,
      child: child,
    );
  }
}
