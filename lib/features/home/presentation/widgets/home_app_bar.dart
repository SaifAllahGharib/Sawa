import 'package:flutter/material.dart';
import 'package:sawa/core/constants/strings.dart';
import 'package:sawa/core/extensions/build_context_extensions.dart';
import 'package:sawa/core/extensions/number_extensions.dart';
import 'package:sawa/core/widgets/app_gesture_detector_button.dart';

import '../../../../core/styles/app_styles.dart';
import '../../../../core/utils/app_bottom_sheet.dart';
import 'create_post_bottom_sheet_widget.dart';

class HomeAppBar extends StatelessWidget {
  const HomeAppBar({super.key});

  void _onTapCreatePost(BuildContext context) {
    AppBottomSheet.show(context, (_) {
      return const CreatePostBottomSheetWidget();
    });
  }

  @override
  Widget build(BuildContext context) {
    return SliverAppBar(
      floating: true,
      snap: true,
      automaticallyImplyLeading: false,
      backgroundColor: context.theme.scaffoldBackgroundColor,
      elevation: 0,
      surfaceTintColor: Colors.transparent,
      title: Text(
        AppStrings.appName,
        style: AppStyles.s22W600.copyWith(
          color: context.theme.primaryColor,
          letterSpacing: 5,
        ),
      ),
      actions: [
        AppGestureDetectorButton(
          child: Icon(Icons.add, color: context.customColor.icon!, size: 26.r),
          onTap: () => _onTapCreatePost(context),
        ),
        15.horizontalSpace,
        AppGestureDetectorButton(
          child: Icon(
            Icons.search_outlined,
            color: context.theme.primaryColor,
            size: 26.r,
          ),
          onTap: () {},
        ),
        15.horizontalSpace,
        AppGestureDetectorButton(
          child: Icon(
            Icons.chat_outlined,
            color: context.theme.primaryColor,
            size: 26.r,
          ),
          onTap: () {},
        ),
        15.horizontalSpace,
      ],
    );
  }
}
