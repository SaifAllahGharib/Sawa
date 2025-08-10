import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../core/di/dependency_injection.dart';
import '../../../../core/styles/app_colors.dart';
import '../../../../core/styles/app_styles.dart';
import '../../../../core/utils/app_bottom_sheet.dart';
import '../../../../core/utils/enums.dart';
import '../../../../core/widgets/app_gesture_detector_button.dart';
import '../../../../core/widgets/app_padding_widget.dart';
import '../../../../core/widgets/full_screen_gallery_widget.dart';
import '../../../../core/widgets/profile_image.dart';
import '../../../../shared/cubits/media/media_cubit.dart';
import '../../../../shared/cubits/validation/validation_cubit.dart';
import '../../../user/domain/entity/user_entity.dart';
import './../../../../core/extensions/build_context_extensions.dart';
import './../../../../core/extensions/number_extensions.dart';
import 'camera_or_gallery_widget.dart';
import 'change_bio_widget.dart';
import 'change_name_widget.dart';

class MiddleSectionProfile extends StatelessWidget {
  final UserEntity user;
  final bool isMyProfile;

  const MiddleSectionProfile({
    super.key,
    required this.user,
    required this.isMyProfile,
  });

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

  void _onTapOnBio(BuildContext context) {
    AppBottomSheet.showModal(
      context,
      (context) => BlocProvider(
        create: (context) => ValidationCubit(requiredFields: {'changeBio'}),
        child: const ChangeBioWidget(),
      ),
    );
  }

  void _onTapImage(BuildContext context) {
    context.navigator.push(
      PageRouteBuilder(
        pageBuilder: (context, animation, secondaryAnimation) =>
            FullScreenGalleryWidget(
              media: user.image,
              mediaType: MediaType.image.toString(),
            ),
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
                  AppGestureDetectorButton(
                    onTap: () => _onTapImage(context),
                    child: ProfileImage(url: user.image, size: 135),
                  ),
                  if (isMyProfile)
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
                              color:
                                  context.customColor.border ?? AppColors.gray,
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
              onTap: () => isMyProfile ? _onTapOnName(context) : null,
              child: Text(
                user.name.toString(),
                style: AppStyles.s29W400.copyWith(
                  color: context.customColor.textColor,
                ),
              ),
            ),
            5.verticalSpace,
            AppGestureDetectorButton(
              onTap: () => isMyProfile ? _onTapOnBio(context) : null,
              child: Text(
                user.bio != null ? user.bio.toString() : context.tr.noBio,
                style: AppStyles.s16W400.copyWith(
                  color: context.customColor.textColor,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
