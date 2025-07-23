import 'dart:math';

import 'package:flutter/material.dart';
import 'package:intern_intelligence_social_media_application/core/extensions/number_extensions.dart';

class AppAssetImage extends StatelessWidget {
  final String image;
  final double? width;
  final double? height;
  final BoxFit? fit;
  final BorderRadius? borderRadius;
  final double? bottomLeft;
  final double? bottomRight;
  final double? topLeft;
  final double? topRight;

  const AppAssetImage({
    super.key,
    required this.image,
    this.width = double.infinity,
    this.height,
    this.fit = BoxFit.cover,
    this.bottomLeft,
    this.bottomRight,
    this.topLeft,
    this.topRight,
    this.borderRadius,
  });

  @override
  Widget build(BuildContext context) {
    final BorderRadius resolvedRadius =
        borderRadius ??
        BorderRadius.only(
          bottomLeft: Radius.circular(bottomLeft ?? 16.r),
          bottomRight: Radius.circular(bottomRight ?? 16.r),
          topLeft: Radius.circular(topLeft ?? 0),
          topRight: Radius.circular(topRight ?? 0),
        );

    return ClipRRect(
      borderRadius: resolvedRadius,
      child: Image.asset(
        image,
        width: width,
        height: height,
        fit: fit,
        errorBuilder: (context, error, stackTrace) => Container(
          width: width ?? double.infinity,
          height: height ?? 200,
          decoration: BoxDecoration(
            color: Colors.grey.shade300,
            borderRadius: resolvedRadius,
          ),
          child: Icon(
            Icons.error,
            color: Colors.red.shade700,
            size: min(width ?? 100, height ?? 100) * 0.2,
          ),
        ),
      ),
    );
  }
}
