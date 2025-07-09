import 'package:flutter/material.dart';

class AppRemoveFocus extends StatelessWidget {
  final Widget child;

  const AppRemoveFocus({super.key, required this.child});

  @override
  Widget build(BuildContext context) {
    return InkWell(
      overlayColor: const WidgetStatePropertyAll(Colors.transparent),
      splashColor: Colors.transparent,
      highlightColor: Colors.transparent,
      hoverColor: Colors.transparent,
      focusColor: Colors.transparent,
      enableFeedback: false,
      onTap: () => FocusScope.of(context).unfocus(),
      child: child,
    );
  }
}
