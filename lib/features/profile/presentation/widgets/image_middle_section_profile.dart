import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:sawa/core/extensions/build_context_extensions.dart';
import 'package:sawa/core/extensions/number_extensions.dart';
import 'package:sawa/core/styles/app_colors.dart';
import 'package:sawa/core/widgets/app_loading_widget.dart';

import '../../../../core/di/dependency_injection.dart';
import '../../../../core/utils/app_bottom_sheet.dart';
import '../../../../core/utils/app_snack_bar.dart';
import '../../../../core/utils/enums.dart';
import '../../../../core/widgets/app_gesture_detector_button.dart';
import '../../../../core/widgets/full_screen_gallery_widget.dart';
import '../../../../core/widgets/profile_image.dart';
import '../../../../shared/cubits/main/main_cubit.dart';
import '../../../../shared/cubits/media/media_cubit.dart';
import '../../../user/domain/entity/user_entity.dart';
import '../cubit/profile/profile_cubit.dart';
import '../cubit/profile/profile_state.dart';
import 'camera_or_gallery_widget.dart';

class ImageMiddleSectionProfile extends StatelessWidget {
  final UserEntity userEntity;
  final bool isMyProfile;

  const ImageMiddleSectionProfile({
    super.key,
    required this.userEntity,
    required this.isMyProfile,
  });

  void _getUser(BuildContext context) {
    context.read<MainCubit>().getUser();
  }

  void _onTapOnCamera(BuildContext context) {
    AppBottomSheet.showModal(context, (context) {
      return MultiBlocProvider(
        providers: [
          BlocProvider(create: (context) => getIt<MediaCubit>()),
          BlocProvider(create: (context) => getIt<ProfileCubit>()),
        ],
        child: const CameraOrGalleryWidget(),
      );
    });
  }

  void _onTapImage(BuildContext context) {
    context.navigator.push(
      PageRouteBuilder(
        pageBuilder: (context, animation, secondaryAnimation) =>
            FullScreenGalleryWidget(
              media: userEntity.image,
              mediaType: MediaType.image.toString(),
            ),
      ),
    );
  }

  void _handleImageState(BuildContext context, ProfileState state) {
    if (state.updateType == ProfileUpdateType.image && !state.isLoading) {
      _getUser(context);
    } else if (state.errorCode != null) {
      AppSnackBar.showError(context, context.tr.errorToUpdateImage);
    }
  }

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: 135.h,
      height: 135.h,
      child: BlocConsumer<ProfileCubit, ProfileState>(
        listener: _handleImageState,
        builder: (context, state) {
          if (state.updateType == ProfileUpdateType.image && state.isLoading) {
            return Container(
              width: 135.h,
              height: 135.h,
              decoration: BoxDecoration(
                color: context.customColor.border,
                borderRadius: BorderRadius.circular(1000.r),
              ),
              child: const AppLoadingWidget(),
            );
          }

          return Stack(
            children: [
              AppGestureDetectorButton(
                onTap: () => _onTapImage(context),
                child: ProfileImage(url: userEntity.image, size: 135),
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
                        border: Border.all(color: context.customColor.border!),
                      ),
                      child: Icon(
                        Icons.camera_alt_outlined,
                        color: AppColors.gray,
                        size: 18.r,
                      ),
                    ),
                  ),
                ),
            ],
          );
        },
      ),
    );
  }
}
