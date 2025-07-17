import 'package:flutter/material.dart';
import 'package:intern_intelligence_social_media_application/core/extensions/build_context_extensions.dart';
import 'package:intern_intelligence_social_media_application/core/extensions/number_extensions.dart';

import '../../../../core/widgets/app_back_button.dart';
import '../../../../core/widgets/app_ink_well_button.dart';
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
                AppInkWellButton(
                  onTap: () {},
                  child: Icon(Icons.settings, color: context.customColor.icon),
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
