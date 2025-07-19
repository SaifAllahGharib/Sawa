import 'package:flutter/material.dart';
import 'package:intern_intelligence_social_media_application/core/extensions/build_context_extensions.dart';
import 'package:intern_intelligence_social_media_application/core/extensions/number_extensions.dart';

import '../../../../core/styles/app_colors.dart';
import '../../../../core/styles/app_styles.dart';
import '../../../../core/widgets/app_ink_well_button.dart';
import '../../../../core/widgets/app_network_image.dart';
import '../../../../core/widgets/app_padding_widget.dart';

class MiddleSectionProfile extends StatelessWidget {
  const MiddleSectionProfile({super.key});

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
                  AppNetworkImage(
                    image: 'https://randomuser.me/api/portraits/men/75.jpg',
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
              'Saif Allah Ghareeb',
              style: AppStyles.s29W400.copyWith(
                color: context.customColor.textColor,
              ),
            ),
            5.verticalSpace,
            Text(
              'Programmer',
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
