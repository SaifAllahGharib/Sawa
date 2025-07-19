import 'package:flutter/material.dart';
import 'package:intern_intelligence_social_media_application/core/extensions/build_context_extensions.dart';

import '../../../../core/extensions/number_extensions.dart';
import '../../../../core/styles/app_colors.dart';
import 'bottom_section_post_card.dart';
import 'middle_section_post_card.dart';
import 'top_section_post_card.dart';

class PostCard extends StatelessWidget {
  final String? image;
  final String name;
  final String postedTime;
  final String? content;
  final String? postImage;

  const PostCard({
    super.key,
    required this.image,
    required this.name,
    required this.postedTime,
    this.content,
    this.postImage,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.symmetric(horizontal: 12.r),
      decoration: BoxDecoration(
        color: context.theme.scaffoldBackgroundColor,
        borderRadius: BorderRadius.circular(16.r),
        boxShadow: [
          BoxShadow(
            color: AppColors.gray.withValues(alpha: 0.1),
            blurRadius: 1,
            offset: const Offset(0.7, 0.7),
          ),
          BoxShadow(
            color: AppColors.gray.withValues(alpha: 0.1),
            blurRadius: 1,
            offset: const Offset(-0.7, -0.7),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          TopSectionPostCard(image: image, name: name, postedTime: postedTime),
          MiddleSectionPostCard(content: content, postImage: postImage),
          const BottomSectionPostCard(),
        ],
      ),
    );
  }
}
