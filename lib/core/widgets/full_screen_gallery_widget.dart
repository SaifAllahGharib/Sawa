import 'package:flutter/material.dart';
import 'package:intern_intelligence_social_media_application/core/extensions/build_context_extensions.dart';
import 'package:intern_intelligence_social_media_application/core/extensions/number_extensions.dart';
import 'package:intern_intelligence_social_media_application/core/utils/enums.dart';
import 'package:intern_intelligence_social_media_application/core/widgets/app_gesture_detector_button.dart';
import 'package:intern_intelligence_social_media_application/core/widgets/app_padding_widget.dart';
import 'package:intern_intelligence_social_media_application/core/widgets/app_scaffold.dart';
import 'package:intern_intelligence_social_media_application/core/widgets/app_video_runner.dart';

import 'app_network_image.dart';

class FullScreenGalleryWidget extends StatelessWidget {
  final String media;
  final String mediaType;

  const FullScreenGalleryWidget({
    super.key,
    required this.media,
    required this.mediaType,
  });

  @override
  Widget build(BuildContext context) {
    return AppScaffold(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          AppPaddingWidget(
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                AppGestureDetectorButton(
                  onTap: () => context.navigator.pop(),
                  child: Icon(
                    Icons.close,
                    size: 24.r,
                    color: context.customColor.icon,
                  ),
                ),
                Icon(
                  Icons.install_mobile,
                  size: 24.r,
                  color: context.customColor.icon,
                ),
              ],
            ),
          ),
          Expanded(
            child: InteractiveViewer(
              child: Center(
                child: mediaType == MediaType.image.toString()
                    ? AppNetworkImage(image: media)
                    : AppVideoRunner(
                        path: media,
                        videoType: VideoType.network,
                        showTopSec: false,
                      ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
