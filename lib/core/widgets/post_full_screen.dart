import 'package:flutter/material.dart';
import 'package:sawa/core/extensions/build_context_extensions.dart';
import 'package:sawa/core/extensions/number_extensions.dart';
import 'package:sawa/core/utils/enums.dart';
import 'package:sawa/core/widgets/app_gesture_detector_button.dart';
import 'package:sawa/core/widgets/app_padding_widget.dart';
import 'package:sawa/core/widgets/app_video_preview.dart';
import 'package:sawa/core/widgets/bottom_section_post_card.dart';
import 'package:sawa/features/home/domain/entities/post_entity.dart';

import 'app_network_image.dart';
import 'app_scaffold.dart';
import 'full_screen_gallery_widget.dart';
import 'top_section_post_card.dart';

class PostFullScreen extends StatelessWidget {
  final PostEntity post;

  const PostFullScreen({super.key, required this.post});

  @override
  Widget build(BuildContext context) {
    final media = post.media.map((e) => e.mediaUrl).toList();
    final mediaTypes = post.media.map((e) => e.mediaType).toList();

    return AppScaffold(
      child: CustomScrollView(
        slivers: [
          SliverToBoxAdapter(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                TopSectionPostCard(
                  authorImage: post.author.image,
                  name: post.author.name,
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
            itemCount: media.length,
            itemBuilder: (context, index) {
              return Padding(
                padding: EdgeInsets.only(top: 15.r),
                child: AppGestureDetectorButton(
                  onTap: () => context.navigator.push(
                    PageRouteBuilder(
                      pageBuilder: (context, animation, secondaryAnimation) {
                        return FullScreenGalleryWidget(
                          media: media[index],
                          mediaType: mediaTypes[index],
                        );
                      },
                    ),
                  ),
                  child: mediaTypes[index] == MediaType.image.toString()
                      ? AppNetworkImage(
                          image: media[index],
                          borderRadius: BorderRadius.zero,
                        )
                      : SizedBox(
                          height: 400.h,
                          child: AppVideoPreview(path: media[index]),
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
