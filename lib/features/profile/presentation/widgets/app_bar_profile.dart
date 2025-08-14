import 'package:flutter/material.dart';
import 'package:sawa/core/extensions/build_context_extensions.dart';
import 'package:sawa/core/extensions/number_extensions.dart';
import 'package:sawa/core/routing/app_route_name.dart';

import '../../../../core/widgets/app_back_button.dart';
import '../../../../core/widgets/app_gesture_detector_button.dart';
import '../../../../core/widgets/app_padding_widget.dart';

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
                      context.navigator.pushNamed(AppRouteName.settings),
                  child: Icon(Icons.settings, color: context.customColor.icon!),
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
