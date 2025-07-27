import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intern_intelligence_social_media_application/core/di/dependency_injection.dart';
import 'package:intern_intelligence_social_media_application/core/extensions/build_context_extensions.dart';
import 'package:intern_intelligence_social_media_application/core/extensions/number_extensions.dart';
import 'package:intern_intelligence_social_media_application/core/shared/cubits/media/media_cubit.dart';
import 'package:intern_intelligence_social_media_application/core/user/domain/entity/user_entity.dart';
import 'package:intern_intelligence_social_media_application/core/utils/app_bottom_sheet.dart';
import 'package:intern_intelligence_social_media_application/core/widgets/profile_image.dart';
import 'package:intern_intelligence_social_media_application/features/profile/presentation/widgets/change_name_widget.dart';

import '../../../../core/shared/cubits/validation/validation_cubit.dart';
import '../../../../core/styles/app_colors.dart';
import '../../../../core/styles/app_styles.dart';
import '../../../../core/widgets/app_gesture_detector_button.dart';
import '../../../../core/widgets/app_padding_widget.dart';
import 'camera_or_gallery_widget.dart';

class MiddleSectionProfile extends StatelessWidget {
  final UserEntity user;

  const MiddleSectionProfile({super.key, required this.user});

  void _onTapOnCamera(BuildContext context) {
    AppBottomSheet.showModal(context, (context) {
      return BlocProvider(
        create: (context) => getIt<MediaCubit>(),
        child: const CameraOrGalleryWidget(),
      );
    });
  }

  void _onTapOnName(BuildContext context) {
    AppBottomSheet.showModal(
      context,
      (context) => BlocProvider(
        create: (context) => ValidationCubit(requiredFields: {'changeName'}),
        child: const ChangeNameWidget(),
      ),
    );
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
                  ProfileImage(url: user.image, size: 135),
                  Align(
                    alignment: AlignmentDirectional.bottomEnd,
                    child: AppGestureDetectorButton(
                      onTap: () => _onTapOnCamera(context),
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
            AppGestureDetectorButton(
              onTap: () => _onTapOnName(context),
              child: Text(
                user.name ?? '',
                style: AppStyles.s29W400.copyWith(
                  color: context.customColor.textColor,
                ),
              ),
            ),
            if (user.bio != null) ...[
              5.verticalSpace,
              Text(
                user.bio.toString(),
                style: AppStyles.s16W400.copyWith(
                  color: context.customColor.textColor,
                ),
              ),
            ],
          ],
        ),
      ),
    );
  }
}
