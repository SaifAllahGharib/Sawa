import 'package:flutter/material.dart';
import 'package:intern_intelligence_social_media_application/core/extensions/build_context_extensions.dart';
import 'package:intern_intelligence_social_media_application/core/extensions/number_extensions.dart';
import 'package:intern_intelligence_social_media_application/core/widgets/app_padding_widget.dart';
import 'package:intern_intelligence_social_media_application/core/widgets/app_placeholder.dart';
import 'package:intern_intelligence_social_media_application/core/widgets/posts_loading.dart';

import 'app_bar_profile.dart';

class ProfileLoading extends StatelessWidget {
  final bool isMyProfile;

  const ProfileLoading({super.key, this.isMyProfile = false});

  @override
  Widget build(BuildContext context) {
    return CustomScrollView(
      slivers: [
        if (isMyProfile) const AppBarProfile(),
        SliverToBoxAdapter(
          child: AppPaddingWidget(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                AppPlaceholder(
                  width: 135.h,
                  height: 135.h,
                  borderRadius: BorderRadius.circular(1000.r),
                ),
                15.verticalSpace,
                AppPlaceholder(width: 150.w, height: 15.h),
              ],
            ),
          ),
        ),
        SliverToBoxAdapter(
          child: Divider(height: 1, color: context.customColor.border),
        ),
        const PostsLoading(),
      ],
    );
  }
}
