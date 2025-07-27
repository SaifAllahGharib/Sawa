import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intern_intelligence_social_media_application/core/extensions/build_context_extensions.dart';
import 'package:intern_intelligence_social_media_application/core/extensions/number_extensions.dart';
import 'package:intern_intelligence_social_media_application/core/shared/cubits/media/media_cubit.dart';
import 'package:intern_intelligence_social_media_application/core/shared/cubits/media/media_state.dart';
import 'package:intern_intelligence_social_media_application/core/styles/app_styles.dart';
import 'package:intern_intelligence_social_media_application/core/utils/enums.dart';
import 'package:intern_intelligence_social_media_application/core/widgets/app_back_button.dart';
import 'package:intern_intelligence_social_media_application/core/widgets/app_file_image.dart';
import 'package:intern_intelligence_social_media_application/core/widgets/app_gesture_detector_button.dart';
import 'package:intern_intelligence_social_media_application/core/widgets/app_padding_widget.dart';
import 'package:intern_intelligence_social_media_application/core/widgets/app_scaffold.dart';
import 'package:intern_intelligence_social_media_application/core/widgets/app_video_preview.dart';
import 'package:intern_intelligence_social_media_application/core/widgets/app_video_runner.dart';

import '../widgets/delete_button.dart';

class DisplaySelectedMedia extends StatelessWidget {
  const DisplaySelectedMedia({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<MediaCubit, MediaState>(
      builder: (context, state) {
        return AppScaffold(
          child: Column(
            children: [
              AppPaddingWidget(
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Row(
                      children: [
                        const AppBackButton(),
                        10.horizontalSpace,
                        Text(
                          context.tr.edit,
                          style: AppStyles.s17W500.copyWith(
                            color: context.customColor.textColor,
                          ),
                        ),
                      ],
                    ),
                    AppGestureDetectorButton(
                      onTap: () => context.navigator.pop(),
                      child: Text(context.tr.ok, style: AppStyles.s17W500),
                    ),
                  ],
                ),
              ),
              Expanded(
                child: ListView.builder(
                  itemCount: state.pickedAssets.length,
                  itemBuilder: (context, index) {
                    final mediaItem = state.pickedAssets[index];
                    return Column(
                      children: [
                        Stack(
                          children: [
                            if (mediaItem.path.isNotEmpty)
                              if (mediaItem.type == MediaType.image)
                                AppFileImage(
                                  image: mediaItem.path,
                                  width: double.infinity,
                                )
                              else
                                SizedBox(
                                  height: 400.r,
                                  child: AppGestureDetectorButton(
                                    onTap: () {
                                      context.navigator.push(
                                        MaterialPageRoute(
                                          builder: (context) => AppVideoRunner(
                                            path: mediaItem.path,
                                            videoType: VideoType.file,
                                          ),
                                        ),
                                      );
                                    },
                                    child: AppVideoPreview(
                                      path: mediaItem.path,
                                      videoType: VideoType.file,
                                    ),
                                  ),
                                ),
                            DeleteButton(
                              onClick: () => context
                                  .read<MediaCubit>()
                                  .removePickedAsset(index),
                            ),
                          ],
                        ),
                        20.verticalSpace,
                      ],
                    );
                  },
                ),
              ),
            ],
          ),
        );
      },
    );
  }
}
