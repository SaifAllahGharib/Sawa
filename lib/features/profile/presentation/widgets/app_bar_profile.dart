import 'package:flutter/material.dart';
import 'package:sawa/core/extensions/build_context_extensions.dart';
import 'package:sawa/core/extensions/number_extensions.dart';
import 'package:sawa/core/routing/app_route_name.dart';

import '../../../../core/constants/app_assets.dart';
import '../../../../core/services/navigation/navigation_service.dart';
import '../../../../core/widgets/app_back_button.dart';
import '../../../../core/widgets/app_gesture_detector_button.dart';
import '../../../../core/widgets/app_padding_widget.dart';
import '../../../../core/widgets/app_svg.dart';

class AppBarProfile extends StatelessWidget {
  const AppBarProfile({super.key});

  @override
  Widget build(BuildContext context) {
    return SliverToBoxAdapter(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          AppPaddingWidget(
            bottom: 10.r,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                const AppBackButton(),
                AppGestureDetectorButton(
                  onTap: () =>
                      NavigationService.I.pushNamed(AppRouteName.settings),
                  child: AppSvg(
                    assetName: AppAssets.settings,
                    colorFilter: ColorFilter.mode(
                      context.customColor.icon,
                      BlendMode.srcIn,
                    ),
                    width: 25.r,
                    height: 25.r,
                  ),
                ),
              ],
            ),
          ),
          Divider(height: 1, color: context.customColor.border),
        ],
      ),
    );
  }
}
