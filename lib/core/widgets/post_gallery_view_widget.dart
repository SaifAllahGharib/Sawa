import 'package:flutter/material.dart';
import 'package:intern_intelligence_social_media_application/core/extensions/build_context_extensions.dart';
import 'package:intern_intelligence_social_media_application/core/extensions/number_extensions.dart';
import 'package:intern_intelligence_social_media_application/core/utils/enums.dart';
import 'package:intern_intelligence_social_media_application/core/widgets/app_gesture_detector_button.dart';
import 'package:intern_intelligence_social_media_application/core/widgets/app_video_preview.dart';
import 'package:intern_intelligence_social_media_application/core/widgets/app_video_runner.dart';
import 'package:intern_intelligence_social_media_application/core/widgets/full_screen_gallery_widget.dart';
import 'package:intern_intelligence_social_media_application/features/home/domain/entities/post_entity.dart';

import '../styles/app_styles.dart';
import 'app_network_image.dart';
import 'post_full_screen.dart';

class PostGalleryViewWidget extends StatelessWidget {
  final PostEntity post;

  const PostGalleryViewWidget({super.key, required this.post});

  @override
  Widget build(BuildContext context) {
    final count = post.media.length;
    final mediaPaths = post.media.map((e) => e.mediaUrl).toList();
    final mediaTypes = post.media.map((e) => e.mediaType).toList();

    switch (count) {
      case 0:
        return const SizedBox();
      case 1:
        return _buildSingleMedia(
          context: context,
          post: post,
          path: mediaPaths.first,
          mediaType: mediaTypes.first,
        );
      case 2:
        return Row(
          children: List.generate(mediaPaths.length, (index) {
            return Expanded(
              child: Padding(
                padding: EdgeInsets.all(4.r),
                child: _buildMedia(
                  context: context,
                  path: mediaPaths[index],
                  post: post,
                  index: index,
                  mediaTypes: mediaTypes,
                ),
              ),
            );
          }),
        );
      case 3 || 4:
        return AppGestureDetectorButton(
          onTap: () => _openMediaViewer(context: context, post: post),
          child: Row(
            children: List.generate(count, (index) {
              return Expanded(
                child: Container(
                  height: index % 2 == 1 ? 350.h : 280.h,
                  padding: EdgeInsets.all(4.r),
                  child: _buildMedia(
                    context: context,
                    index: index,
                    mediaTypes: mediaTypes,
                    post: post,
                    path: mediaPaths[index],
                  ),
                ),
              );
            }),
          ),
        );
      case _:
        return GridView.builder(
          shrinkWrap: true,
          physics: const NeverScrollableScrollPhysics(),
          itemCount: count.clamp(0, 4),
          padding: EdgeInsets.all(4.r),
          gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 2,
            mainAxisSpacing: 4.r,
            crossAxisSpacing: 4.r,
          ),
          itemBuilder: (_, i) {
            final path = mediaPaths[i];
            return Stack(
              children: [
                _buildMedia(
                  context: context,
                  path: path,
                  post: post,
                  index: i,
                  mediaTypes: mediaTypes,
                ),
                if (i == 3)
                  _buildOverlayMore(
                    context: context,
                    extraCount: count - 4,
                    post: post,
                  ),
              ],
            );
          },
        );
    }
  }

  Widget _buildSingleMedia({
    required BuildContext context,
    required PostEntity post,
    required String path,
    required String mediaType,
  }) {
    return ClipRRect(
      borderRadius: BorderRadius.circular(16.r),
      child: mediaType == MediaType.image.toString()
          ? AppGestureDetectorButton(
              onTap: () => _openSingleMediaViewer(
                context: context,
                media: path,
                mediaType: mediaType,
              ),
              child: AppNetworkImage(image: path, width: double.infinity),
            )
          : SizedBox(
              width: double.infinity,
              height: 600.h,
              child: AppVideoRunner(
                path: path,
                videoType: VideoType.network,
                showTopSec: false,
              ),
            ),
    );
  }

  Widget _buildMedia({
    required BuildContext context,
    required String path,
    required PostEntity post,
    required int index,
    required List<String> mediaTypes,
  }) {
    return AppGestureDetectorButton(
      onTap: () => _openMediaViewer(context: context, post: post),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(12),
        child: mediaTypes[index] == MediaType.image.toString()
            ? AppNetworkImage(
                image: path,
                width: double.infinity,
                height: double.infinity,
              )
            : AppVideoPreview(path: path),
      ),
    );
  }

  Widget _buildOverlayMore({
    required BuildContext context,
    required int extraCount,
    required PostEntity post,
  }) {
    return Positioned.fill(
      child: AppGestureDetectorButton(
        onTap: () => _openMediaViewer(context: context, post: post),
        child: Container(
          decoration: BoxDecoration(
            color: Colors.black.withValues(alpha: 0.6),
            borderRadius: BorderRadius.circular(12.r),
          ),
          alignment: Alignment.center,
          child: Text(
            '+$extraCount',
            style: AppStyles.s26WB.copyWith(color: Colors.white),
          ),
        ),
      ),
    );
  }

  void _openSingleMediaViewer({
    required BuildContext context,
    required String media,
    required String mediaType,
  }) {
    context.navigator.push(
      PageRouteBuilder(
        pageBuilder: (context, animation, secondaryAnimation) =>
            FullScreenGalleryWidget(media: media, mediaType: mediaType),
      ),
    );
  }

  void _openMediaViewer({
    required BuildContext context,
    required PostEntity post,
  }) {
    context.navigator.push(
      PageRouteBuilder(
        pageBuilder: (context, animation, secondaryAnimation) =>
            PostFullScreen(post: post),
      ),
    );
  }
}
