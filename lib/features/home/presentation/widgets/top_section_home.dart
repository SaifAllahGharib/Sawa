import 'package:flutter/material.dart';
import 'package:intern_intelligence_social_media_application/core/di/dependency_injection.dart';
import 'package:intern_intelligence_social_media_application/core/extensions/build_context_extensions.dart';
import 'package:intern_intelligence_social_media_application/core/extensions/number_extensions.dart';
import 'package:intern_intelligence_social_media_application/core/helpers/shared_preferences_helper.dart';
import 'package:intern_intelligence_social_media_application/core/utils/app_bottom_sheet.dart';
import 'package:intern_intelligence_social_media_application/core/widgets/profile_image.dart';
import 'package:intern_intelligence_social_media_application/features/home/presentation/widgets/create_post_bottom_sheet_widget.dart';

import '../../../../core/routing/app_route_name.dart';
import '../../../../core/styles/app_styles.dart';
import '../../../../core/widgets/app_gesture_detector_button.dart';
import '../../../../core/widgets/app_padding_widget.dart';

class TopSectionHome extends StatelessWidget {
  const TopSectionHome({super.key});

  void _onTapCreatePost(BuildContext context) {
    AppBottomSheet.show(context, (_) {
      return const CreatePostBottomSheetWidget();
    });
  }

  @override
  Widget build(BuildContext context) {
    return SliverToBoxAdapter(
      child: AppPaddingWidget(
        top: 8.r,
        bottom: 0,
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            AppGestureDetectorButton(
              onTap: () => context.navigator.pushNamed(AppRouteName.profile),
              child: ProfileImage(
                url:
                    getIt<SharedPreferencesHelper>().getUserImage() != 'null' &&
                        getIt<SharedPreferencesHelper>()
                            .getUserImage()
                            .isNotEmpty
                    ? getIt<SharedPreferencesHelper>().getUserImage()
                    : '',
              ),
            ),
            10.horizontalSpace,
            Expanded(
              child: AppGestureDetectorButton(
                onTap: () => _onTapCreatePost(context),
                child: Container(
                  padding: EdgeInsets.symmetric(
                    horizontal: 12.r,
                    vertical: 8.r,
                  ),
                  decoration: BoxDecoration(
                    color: Colors.transparent,
                    borderRadius: BorderRadius.circular(1000.r),
                    border: Border.all(
                      color: context.customColor.border!,
                      width: 1.r,
                    ),
                  ),
                  width: double.infinity,
                  child: Text(
                    context.tr.whateYouThinking,
                    style: AppStyles.s15W400,
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
