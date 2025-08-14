import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:sawa/core/extensions/number_extensions.dart';
import 'package:sawa/core/widgets/app_placeholder.dart';

class AppSvg extends StatelessWidget {
  final String assetName;

  final double? width;

  final double? height;

  final Color? color;

  final BoxFit fit;

  const AppSvg({
    super.key,
    required this.assetName,
    this.width,
    this.height,
    this.color,
    this.fit = BoxFit.contain,
  });

  @override
  Widget build(BuildContext context) {
    return SvgPicture.asset(
      assetName,
      width: width,
      height: height,
      fit: fit,
      placeholderBuilder: (context) =>
          AppPlaceholder(width: width ?? 20.r, height: height ?? 20.r),
    );
  }
}
