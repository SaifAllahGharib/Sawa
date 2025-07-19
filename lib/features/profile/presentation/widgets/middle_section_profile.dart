import 'package:flutter/material.dart';
import 'package:intern_intelligence_social_media_application/core/constants/app_assets.dart';
import 'package:intern_intelligence_social_media_application/core/di/dependency_injection.dart';
import 'package:intern_intelligence_social_media_application/core/extensions/build_context_extensions.dart';
import 'package:intern_intelligence_social_media_application/core/extensions/number_extensions.dart';
import 'package:intern_intelligence_social_media_application/core/helpers/shared_preferences_helper.dart';
import 'package:intern_intelligence_social_media_application/features/home/presentation/widgets/app_asset_image.dart';

import '../../../../core/styles/app_colors.dart';
import '../../../../core/styles/app_styles.dart';
import '../../../../core/widgets/app_ink_well_button.dart';
import '../../../../core/widgets/app_network_image.dart';
import '../../../../core/widgets/app_padding_widget.dart';

class MiddleSectionProfile extends StatefulWidget {
  const MiddleSectionProfile({super.key});

  @override
  State<MiddleSectionProfile> createState() => _MiddleSectionProfileState();
}

class _MiddleSectionProfileState extends State<MiddleSectionProfile> {
  late final SharedPreferencesHelper _sharedPreferencesHelper;

  @override
  void initState() {
    _sharedPreferencesHelper = getIt<SharedPreferencesHelper>();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return SliverToBoxAdapter(
      child: AppPaddingWidget(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SizedBox(
              width: 135.h,
              height: 135.h,
              child: Stack(
                children: [
                  _sharedPreferencesHelper.getUserImage() != null
                      ? AppNetworkImage(
                          image: _sharedPreferencesHelper.getUserImage() ?? '',
                          height: 135.h,
                          width: 135.h,
                          borderRadius: BorderRadius.circular(3000.r),
                        )
                      : AppAssetImage(
                          image: AppAssets.profile,
                          height: 135.h,
                          width: 135.h,
                          borderRadius: BorderRadius.circular(3000.r),
                        ),
                  Align(
                    alignment: AlignmentDirectional.bottomEnd,
                    child: AppInkWellButton(
                      onTap: () {},
                      child: Container(
                        padding: EdgeInsets.all(5.r),
                        decoration: BoxDecoration(
                          color: context.theme.scaffoldBackgroundColor,
                          borderRadius: BorderRadius.circular(3000.r),
                          border: Border.all(
                            color: context.customColor.border ?? AppColors.gray,
                          ),
                        ),
                        child: Icon(
                          Icons.camera_alt_outlined,
                          color: context.customColor.icon,
                          size: 18.r,
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
            10.verticalSpace,
            Text(
              _sharedPreferencesHelper.getUserName() ?? '',
              style: AppStyles.s29W400.copyWith(
                color: context.customColor.textColor,
              ),
            ),
            if (_sharedPreferencesHelper.getUserBio() != null) 5.verticalSpace,
            if (_sharedPreferencesHelper.getUserBio() != null)
              Text(
                _sharedPreferencesHelper.getUserBio() ?? '',
                style: AppStyles.s16W400.copyWith(
                  color: context.customColor.textColor,
                ),
              ),
          ],
        ),
      ),
    );
  }
}
