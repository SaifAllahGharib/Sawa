import 'package:flutter/material.dart';
import 'package:intern_intelligence_social_media_application/core/extensions/build_context_extensions.dart';
import 'package:intern_intelligence_social_media_application/core/extensions/number_extensions.dart';
import 'package:intern_intelligence_social_media_application/core/widgets/app_gesture_detector_button.dart';
import 'package:intern_intelligence_social_media_application/core/widgets/app_padding_widget.dart';
import 'package:intern_intelligence_social_media_application/core/widgets/bottom_section_post_card.dart';
import 'package:intern_intelligence_social_media_application/features/home/domain/entities/post_entity.dart';

import 'app_network_image.dart';
import 'app_scaffold.dart';
import 'full_screen_gallery_widget.dart';
import 'top_section_post_card.dart';

class PostFullScreen extends StatelessWidget {
  final PostEntity post;

  const PostFullScreen({super.key, required this.post});

  @override
  Widget build(BuildContext context) {
    final images = post.media.map((e) => e.mediaUrl).toList();

    return AppScaffold(
      child: CustomScrollView(
        slivers: [
          SliverToBoxAdapter(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                TopSectionPostCard(
                  image: post.author!.image,
                  name: post.author!.name!,
                  postedTime: post.createdAt,
                ),
                10.verticalSpace,
                if (post.content.isNotEmpty) ...[
                  AppPaddingWidget(
                    top: 0,
                    bottom: 0,
                    child: Text(post.content),
                  ),
                  10.verticalSpace,
                ],
                const BottomSectionPostCard(),
              ],
            ),
          ),
          SliverList.builder(
            itemCount: images.length,
            itemBuilder: (context, index) {
              return Padding(
                padding: EdgeInsets.only(top: 15.r),
                child: AppGestureDetectorButton(
                  onTap: () => context.navigator.push(
                    MaterialPageRoute(
                      builder: (context) =>
                          FullScreenGalleryWidget(image: images[index]),
                    ),
                  ),
                  child: AppNetworkImage(
                    image: images[index],
                    borderRadius: BorderRadius.zero,
                  ),
                ),
              );
            },
          ),
        ],
      ),
    );
  }
}
