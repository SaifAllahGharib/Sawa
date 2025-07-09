import 'package:flutter/material.dart';

class AppInkWellButton extends StatelessWidget {
  final Widget child;
  final VoidCallback onTap;

  const AppInkWellButton({super.key, required this.child, required this.onTap});

  @override
  Widget build(BuildContext context) {
    return InkWell(
      overlayColor: const WidgetStatePropertyAll(Colors.transparent),
      splashColor: Colors.transparent,
      highlightColor: Colors.transparent,
      hoverColor: Colors.transparent,
      focusColor: Colors.transparent,
      enableFeedback: false,
      onTap: onTap,
      child: child,
    );
  }
}
