import 'dart:math';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:intern_intelligence_social_media_application/core/extensions/number_extensions.dart';

import 'app_placeholder.dart';

class AppNetworkImage extends StatelessWidget {
  final String image;
  final double? width;
  final double? height;
  final BoxFit? fit;
  final BorderRadius? borderRadius;
  final double? bottomLeft;
  final double? bottomRight;
  final double? topLeft;
  final double? topRight;

  const AppNetworkImage({
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
    return ClipRRect(
      borderRadius:
          borderRadius ??
          BorderRadius.only(
            bottomLeft: Radius.circular(bottomLeft ?? 16.r),
            bottomRight: Radius.circular(bottomRight ?? 16.r),
            topLeft: Radius.circular(topLeft ?? 0),
            topRight: Radius.circular(topRight ?? 0),
          ),
      child: CachedNetworkImage(
        imageUrl: image,
        width: width,
        height: height,
        fit: fit,
        placeholder: (context, url) => AppPlaceholder(
          width: width ?? double.infinity,
          height: height ?? 200,
          borderRadius:
              borderRadius ??
              BorderRadius.only(
                bottomLeft: Radius.circular(bottomLeft ?? 16.r),
                bottomRight: Radius.circular(bottomRight ?? 16.r),
                topLeft: Radius.circular(topLeft ?? 0),
                topRight: Radius.circular(topRight ?? 0),
              ),
        ),
        errorWidget: (context, url, error) => Container(
          width: width ?? double.infinity,
          height: height ?? 200,
          decoration: BoxDecoration(
            color: Colors.grey.shade300,
            borderRadius:
                borderRadius ??
                BorderRadius.only(
                  bottomLeft: Radius.circular(bottomLeft ?? 16.r),
                  bottomRight: Radius.circular(bottomRight ?? 16.r),
                  topLeft: Radius.circular(topLeft ?? 0),
                  topRight: Radius.circular(topRight ?? 0),
                ),
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
