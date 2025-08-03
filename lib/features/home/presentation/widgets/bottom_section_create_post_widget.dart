import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intern_intelligence_social_media_application/core/extensions/build_context_extensions.dart';
import 'package:intern_intelligence_social_media_application/core/extensions/number_extensions.dart';
import 'package:intern_intelligence_social_media_application/core/widgets/app_button_loading.dart';

import '../../../../core/clients/firebase_client.dart';
import '../../../../core/di/dependency_injection.dart';
import '../../../../core/shared/cubits/media/media_cubit.dart';
import '../../../../core/shared/cubits/media/media_state.dart';
import '../../../../core/shared/cubits/validation/validation_cubit.dart';
import '../../../../core/shared/cubits/validation/validation_state.dart';
import '../../../../core/shared/models/media_item.dart';
import '../../../../core/utils/app_bottom_sheet.dart';
import '../../../../core/utils/app_snack_bar.dart';
import '../../../../core/widgets/app_button.dart';
import '../../../../core/widgets/app_gesture_detector_button.dart';
import '../../domain/entities/post_entity.dart';
import '../cubits/home/home_cubit.dart';
import '../cubits/home/home_state.dart';
import 'image_and_video_from_camera_or_gallery_widget_bottom_sheet.dart';

class BottomSectionCreatePostWidget extends StatelessWidget {
  final TextEditingController postController;

  const BottomSectionCreatePostWidget({
    super.key,
    required this.postController,
  });

  void _createPost(BuildContext context, List<MediaItem> pickedAssets) {
    context.read<HomeCubit>().createPost(
      PostEntity(
        authorId: getIt<FirebaseClient>().auth.currentUser!.uid,
        content: postController.text,
        isPublic: true,
        createdAt: DateTime.now(),
      ),
      pickedAssets,
    );
  }

  void _onTapSelectMedia(BuildContext context) {
    final mediaCubit = context.read<MediaCubit>();
    AppBottomSheet.showModal(context, (context) {
      return BlocProvider.value(
        value: mediaCubit,
        child: const ImageAndVideoFromCameraOrGalleryWidgetBottomSheet(),
      );
    });
  }

  void _handleState(BuildContext context, HomeState state) {
    if (state is HomeCreatePostSuccessState) {
      context.navigator.pop();
      AppSnackBar.showSuccess(context, context.tr.postCreatedSuccessfully);
    } else if (state is HomeFailureState) {
      final code = state.code;
      if (code == 'Post creation failed' ||
          code == 'Failed to upload media to table') {
        AppSnackBar.showError(context, context.tr.postCreationFailed);
      } else {
        AppSnackBar.showError(context, code);
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Expanded(
          child: BlocBuilder<ValidationCubit, ValidationState>(
            builder: (context, enableButtonState) {
              return BlocBuilder<MediaCubit, MediaState>(
                builder: (context, mediaState) {
                  return BlocConsumer<HomeCubit, HomeState>(
                    listener: (context, state) => _handleState(context, state),
                    builder: (context, state) {
                      if (state is HomeLoadingState) {
                        return const AppButtonLoading();
                      }

                      return AppButton(
                        enabled: enableButtonState.enableButton,
                        onClick: () =>
                            _createPost(context, mediaState.pickedAssets),
                        text: context.tr.post,
                      );
                    },
                  );
                },
              );
            },
          ),
        ),
        10.horizontalSpace,
        AppGestureDetectorButton(
          onTap: () => _onTapSelectMedia(context),
          child: Icon(
            Icons.image_outlined,
            size: 30.r,
            color: context.customColor.icon,
          ),
        ),
      ],
    );
  }
}
