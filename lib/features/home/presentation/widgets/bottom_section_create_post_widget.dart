import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:sawa/core/constants/app_assets.dart';
import 'package:sawa/core/widgets/app_svg.dart';
import 'package:sawa/features/home/data/models/create_post_model.dart';
import 'package:sawa/shared/models/media_model.dart';

import '../../../../../../core/extensions/build_context_extensions.dart';
import '../../../../../../core/extensions/number_extensions.dart';
import '../../../../core/clients/firebase_client.dart';
import '../../../../core/di/dependency_injection.dart';
import '../../../../core/utils/app_bottom_sheet.dart';
import '../../../../core/utils/app_snack_bar.dart';
import '../../../../core/widgets/app_button.dart';
import '../../../../core/widgets/app_button_loading.dart';
import '../../../../core/widgets/app_gesture_detector_button.dart';
import '../../../../shared/cubits/media/media_cubit.dart';
import '../../../../shared/cubits/media/media_state.dart';
import '../../../../shared/cubits/validation/validation_cubit.dart';
import '../../../../shared/cubits/validation/validation_state.dart';
import '../../../../shared/entities/media_item.dart';
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
    final createPostModel = CreatePostModel(
      authorId: getIt<FirebaseClient>().auth.currentUser!.uid,
      content: postController.text,
      isPublic: true,
      createdAt: DateTime.now(),
      media: pickedAssets
          .map((e) => MediaModel(path: e.path, type: e.type.toString()))
          .toList(),
    );

    context.read<HomeCubit>().createPost(createPostModel: createPostModel);
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
          child: AppSvg(
            assetName: AppAssets.image,
            width: 35.r,
            height: 35.r,
            colorFilter: ColorFilter.mode(
              context.customColor.icon!,
              BlendMode.srcIn,
            ),
          ),
        ),
      ],
    );
  }
}
