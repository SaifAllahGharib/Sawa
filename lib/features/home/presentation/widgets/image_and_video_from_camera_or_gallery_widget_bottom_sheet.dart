import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intern_intelligence_social_media_application/core/extensions/build_context_extensions.dart';
import 'package:intern_intelligence_social_media_application/core/extensions/number_extensions.dart';

import '../../../../core/styles/app_colors.dart';
import '../../../../core/styles/app_styles.dart';
import '../../../../core/widgets/app_gesture_detector_button.dart';
import '../../../../core/widgets/app_padding_widget.dart';
import '../../../../shared/cubits/media/media_cubit.dart';

class ImageAndVideoFromCameraOrGalleryWidgetBottomSheet
    extends StatelessWidget {
  const ImageAndVideoFromCameraOrGalleryWidgetBottomSheet({super.key});

  @override
  Widget build(BuildContext context) {
    return AppPaddingWidget(
      top: 0,
      bottom: 25.r,
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SizedBox(
            width: double.infinity,
            child: AppGestureDetectorButton(
              onTap: () => context.read<MediaCubit>().pickMultipleImages(),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(context.tr.imageFromGallery, style: AppStyles.s20W600),
                  10.verticalSpace,
                  Divider(
                    height: 1,
                    color: AppColors.gray.withValues(alpha: 0.4),
                  ),
                ],
              ),
            ),
          ),
          20.verticalSpace,
          SizedBox(
            width: double.infinity,
            child: AppGestureDetectorButton(
              onTap: () => context.read<MediaCubit>().pickImageFromCamera(),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(context.tr.imageFromCamera, style: AppStyles.s20W600),
                  10.verticalSpace,
                  Divider(
                    height: 1,
                    color: AppColors.gray.withValues(alpha: 0.4),
                  ),
                ],
              ),
            ),
          ),
          20.verticalSpace,
          SizedBox(
            width: double.infinity,
            child: AppGestureDetectorButton(
              onTap: () => context.read<MediaCubit>().pickVideoFromGallery(),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(context.tr.videoFromGallery, style: AppStyles.s20W600),
                  10.verticalSpace,
                  Divider(
                    height: 1,
                    color: AppColors.gray.withValues(alpha: 0.4),
                  ),
                ],
              ),
            ),
          ),
          20.verticalSpace,
          SizedBox(
            width: double.infinity,
            child: AppGestureDetectorButton(
              onTap: () => context.read<MediaCubit>().pickVideoFromCamera(),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(context.tr.videoFromCamera, style: AppStyles.s20W600),
                  10.verticalSpace,
                  Divider(
                    height: 1,
                    color: AppColors.gray.withValues(alpha: 0.4),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
