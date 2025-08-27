import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:sawa/core/extensions/build_context_extensions.dart';
import 'package:sawa/core/extensions/number_extensions.dart';
import 'package:sawa/core/styles/app_styles.dart';
import 'package:sawa/core/widgets/app_back_button.dart';
import 'package:sawa/core/widgets/app_file_image.dart';
import 'package:sawa/core/widgets/app_gesture_detector_button.dart';
import 'package:sawa/core/widgets/app_padding_widget.dart';
import 'package:sawa/core/widgets/app_scaffold.dart';
import 'package:sawa/core/widgets/app_video_preview.dart';
import 'package:sawa/core/widgets/app_video_runner.dart';

import '../../../../core/enums/media_type.dart';
import '../../../../core/enums/video_type.dart';
import '../../../../core/services/navigation/navigation_service.dart';
import '../../../../core/widgets/media_delete_button.dart';
import '../../../../shared/cubits/media/media_cubit.dart';
import '../../../../shared/cubits/media/media_state.dart';

class DisplaySelectedMedia extends StatelessWidget {
  const DisplaySelectedMedia({super.key});

  @override
  Widget build(BuildContext context) {
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
                  onTap: () => NavigationService.I.pop(),
                  child: Text(context.tr.ok, style: AppStyles.s17W500),
                ),
              ],
            ),
          ),
          Expanded(
            child: BlocBuilder<MediaCubit, MediaState>(
              builder: (context, state) {
                return ListView.builder(
                  itemCount: state.pickedAssets.length,
                  itemBuilder: (context, index) {
                    final mediaItemPath = state.pickedAssets[index].path;
                    final mediaItemType = state.pickedAssets[index].type;

                    return KeyedSubtree(
                      key: ValueKey(mediaItemPath),
                      child: Column(
                        children: [
                          Stack(
                            children: [
                              if (mediaItemPath.isNotEmpty)
                                if (mediaItemType == MediaType.image)
                                  AppFileImage(
                                    image: mediaItemPath,
                                    width: double.infinity,
                                  )
                                else
                                  SizedBox(
                                    height: 400.r,
                                    child: AppGestureDetectorButton(
                                      onTap: () async {
                                        await NavigationService.I.push(
                                          MaterialPageRoute(
                                            builder: (context) =>
                                                AppVideoRunner(
                                                  path: mediaItemPath,
                                                  videoType: VideoType.file,
                                                ),
                                          ),
                                        );
                                      },
                                      child: AppVideoPreview(
                                        path: mediaItemPath,
                                      ),
                                    ),
                                  ),
                              MediaDeleteButton(
                                onClick: () => context
                                    .read<MediaCubit>()
                                    .removePickedAsset(index),
                              ),
                            ],
                          ),
                          20.verticalSpace,
                        ],
                      ),
                    );
                  },
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}
