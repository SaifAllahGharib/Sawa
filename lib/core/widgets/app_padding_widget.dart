import 'package:flutter/material.dart';
import 'package:intern_intelligence_social_media_application/core/extensions/number_extensions.dart';

class AppPaddingWidget extends StatelessWidget {
  final Widget child;
  final double? top;
  final double? bottom;
  final double? right;
  final double? left;

  const AppPaddingWidget({
    super.key,
    required this.child,
    this.top,
    this.bottom,
    this.right,
    this.left,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(
        top: top ?? 18.r,
        bottom: bottom ?? 18.r,
        right: right ?? 18.r,
        left: left ?? 18.r,
      ),
      child: child,
    );
  }
}
