import 'package:flutter/material.dart';
import 'package:intern_intelligence_social_media_application/core/extensions/build_context_extensions.dart';
import 'package:intern_intelligence_social_media_application/core/extensions/number_extensions.dart';
import 'package:intern_intelligence_social_media_application/core/widgets/app_gesture_detector_button.dart';
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
    final imagePaths = post.media.map((e) => e.mediaUrl).toList();

    switch (count) {
      case 0:
        return const SizedBox();
      case 1:
        return _buildSingleImage(
          context: context,
          post: post,
          path: imagePaths.first,
        );
      case 2:
        return Row(
          children: imagePaths.map((path) {
            return Expanded(
              child: Padding(
                padding: EdgeInsets.all(4.r),
                child: _buildImage(context: context, path: path, post: post),
              ),
            );
          }).toList(),
        );
      case 3 || 4:
        return AppGestureDetectorButton(
          onTap: () => _openImageViewer(context: context, post: post),
          child: Row(
            children: List.generate(count, (index) {
              return Expanded(
                child: Container(
                  height: index % 2 == 1 ? 350.h : 280.h,
                  padding: EdgeInsets.all(4.r),
                  child: AppNetworkImage(
                    image: imagePaths[index],
                    borderRadius: BorderRadius.circular(12.r),
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
            final path = imagePaths[i];
            return Stack(
              children: [
                _buildImage(context: context, path: path, post: post),
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

  Widget _buildSingleImage({
    required BuildContext context,
    required PostEntity post,
    required String path,
  }) {
    return AppGestureDetectorButton(
      onTap: () => _openImageViewer(context: context, post: post),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(16),
        child: AppNetworkImage(image: path, width: double.infinity),
      ),
    );
  }

  Widget _buildImage({
    required BuildContext context,
    required String path,
    required PostEntity post,
  }) {
    return AppGestureDetectorButton(
      onTap: () => _openImageViewer(context: context, post: post),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(12),
        child: AppNetworkImage(
          image: path,
          width: double.infinity,
          height: double.infinity,
        ),
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
        onTap: () => _openImageViewer(context: context, post: post),
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

  void _openImageViewer({
    required BuildContext context,
    required PostEntity post,
  }) {
    context.navigator.push(
      MaterialPageRoute(builder: (_) => PostFullScreen(post: post)),
    );
  }
}
