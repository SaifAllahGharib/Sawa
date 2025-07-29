import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intern_intelligence_social_media_application/core/extensions/build_context_extensions.dart';
import 'package:intern_intelligence_social_media_application/core/extensions/number_extensions.dart';
import 'package:intern_intelligence_social_media_application/core/shared/cubits/media/media_state.dart';
import 'package:intern_intelligence_social_media_application/features/profile/presentation/widgets/display_image_profile.dart';

import '../../../../core/di/dependency_injection.dart';
import '../../../../core/shared/cubits/media/media_cubit.dart';
import '../../../../core/styles/app_styles.dart';
import '../../../../core/widgets/app_gesture_detector_button.dart';
import '../../../../core/widgets/app_padding_widget.dart';
import '../cubit/profile/profile_cubit.dart';

class CameraOrGalleryWidget extends StatelessWidget {
  const CameraOrGalleryWidget({super.key});

  void _clearAssets(BuildContext context) {
    context.read<MediaCubit>().clearPickedAssets();
  }

  void _pickedFromGallery(BuildContext context) {
    _clearAssets(context);
    context.read<MediaCubit>().pickImageFromGallery();
  }

  void _pickedFromCamera(BuildContext context) {
    _clearAssets(context);
    context.read<MediaCubit>().pickImageFromCamera();
  }

  void _handleState(BuildContext context, MediaState state) {
    if (state.pickedAssets.isNotEmpty) {
      final mediaCubit = context.read<MediaCubit>();
      final profileCubit = getIt<ProfileCubit>();
      context.navigator.push(
        PageRouteBuilder(
          opaque: false,
          barrierDismissible: true,
          barrierColor: Colors.black54,
          pageBuilder: (context, animation, secondaryAnimation) {
            return MultiBlocProvider(
              providers: [
                BlocProvider.value(value: mediaCubit),
                BlocProvider.value(value: profileCubit),
              ],
              child: const DisplayImageProfile(),
            );
          },
          transitionsBuilder: (_, animation, _, child) {
            return SlideTransition(
              position: Tween(
                begin: const Offset(0, 1),
                end: Offset.zero,
              ).animate(animation),
              child: child,
            );
          },
        ),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return BlocListener<MediaCubit, MediaState>(
      listener: (context, state) => _handleState(context, state),
      child: AppPaddingWidget(
        top: 0,
        bottom: 25.r,
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SizedBox(
              width: double.infinity,
              child: AppGestureDetectorButton(
                child: Text(
                  context.tr.gallery,
                  style: AppStyles.s20W600.copyWith(
                    color: context.customColor.textColor,
                  ),
                ),
                onTap: () => _pickedFromGallery(context),
              ),
            ),
            15.verticalSpace,
            AppGestureDetectorButton(
              child: Text(
                context.tr.camera,
                style: AppStyles.s20W600.copyWith(
                  color: context.customColor.textColor,
                ),
              ),
              onTap: () => _pickedFromCamera(context),
            ),
          ],
        ),
      ),
    );
  }
}
