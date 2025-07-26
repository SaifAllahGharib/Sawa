import 'package:flutter/material.dart';
import 'package:intern_intelligence_social_media_application/features/home/domain/entities/post_entity.dart';

import '../../../../core/extensions/number_extensions.dart';
import '../../../../core/styles/app_styles.dart';
import '../../../../core/widgets/app_padding_widget.dart';
import '../../../../core/widgets/post_gallery_view_widget.dart';

class MiddleSectionPostCard extends StatelessWidget {
  final String? content;
  final PostEntity post;

  const MiddleSectionPostCard({
    super.key,
    required this.content,
    required this.post,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        if (content != null && content!.isNotEmpty)
          AppPaddingWidget(
            top: 0,
            bottom: 12.r,
            child: Text(
              content ?? '',
              style: AppStyles.s15W400.copyWith(
                color: Colors.black87,
                height: 1.4,
              ),
            ),
          ),
        if (post.media.isNotEmpty) PostGalleryViewWidget(post: post),
      ],
    );
  }
}
