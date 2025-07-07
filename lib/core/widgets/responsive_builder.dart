import 'package:flutter/widgets.dart';

import '../responsive/app_responsive.dart';

class ResponsiveBuilder extends StatelessWidget {
  final double designWidth;
  final double designHeight;
  final Widget Function(BuildContext context) builder;

  const ResponsiveBuilder({
    super.key,
    required this.builder,
    this.designWidth = 375,
    this.designHeight = 812,
  });

  @override
  Widget build(BuildContext context) {
    AppResponsive.init(
      context,
      designWidth: designWidth,
      designHeight: designHeight,
    );
    return Builder(builder: builder);
  }
}
