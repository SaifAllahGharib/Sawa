import 'package:flutter/material.dart';
import 'package:sawa/core/clients/firebase_client.dart';
import 'package:sawa/core/constants/app_assets.dart';
import 'package:sawa/core/constants/strings.dart';
import 'package:sawa/core/di/dependency_injection.dart';
import 'package:sawa/core/extensions/build_context_extensions.dart';
import 'package:sawa/core/extensions/number_extensions.dart';
import 'package:sawa/core/routing/app_route_name.dart';
import 'package:sawa/core/widgets/app_gesture_detector_button.dart';
import 'package:sawa/core/widgets/app_svg.dart';

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

  void _onTapProfile(BuildContext context) {
    context.navigator.pushNamed(
      AppRouteName.profile,
      arguments: getIt<FirebaseClient>().auth.currentUser!.uid,
    );
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
          child: Icon(
            Icons.person_outlined,
            color: context.customColor.icon!,
            size: 26.r,
          ),
          onTap: () => _onTapProfile(context),
        ),
        15.horizontalSpace,
        AppGestureDetectorButton(
          child: _buildSvgIcon(context: context, assetName: AppAssets.create),
          onTap: () => _onTapCreatePost(context),
        ),
        15.horizontalSpace,
        AppGestureDetectorButton(
          child: _buildSvgIcon(context: context, assetName: AppAssets.search),
          onTap: () {},
        ),
        15.horizontalSpace,
        AppGestureDetectorButton(
          child: _buildSvgIcon(
            context: context,
            assetName: AppAssets.chat,
            color: context.theme.primaryColor,
          ),
          onTap: () {},
        ),
        15.horizontalSpace,
      ],
    );
  }

  Widget _buildSvgIcon({
    required BuildContext context,
    required String assetName,
    Color? color,
  }) {
    return AppSvg(
      assetName: assetName,
      colorFilter: ColorFilter.mode(
        color ?? context.customColor.icon!,
        BlendMode.srcIn,
      ),
      width: 26.r,
      height: 26.r,
    );
  }
}
