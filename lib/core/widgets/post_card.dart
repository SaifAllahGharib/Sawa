import 'package:flutter/material.dart';
import 'package:intern_intelligence_social_media_application/core/extensions/build_context_extensions.dart';

import '../../features/home/domain/entities/post_entity.dart';
import '../extensions/number_extensions.dart';
import '../styles/app_colors.dart';
import 'bottom_section_post_card.dart';
import 'middle_section_post_card.dart';
import 'top_section_post_card.dart';

class PostCard extends StatefulWidget {
  final String? image;
  final String name;
  final DateTime postedTime;
  final String? content;
  final PostEntity post;
  final bool isProfile;
  final VoidCallback? onClickDelete;
  final VoidCallback? onClickEdit;

  const PostCard({
    super.key,
    required this.image,
    required this.name,
    required this.postedTime,
    this.content,
    required this.post,
    this.isProfile = false,
    this.onClickDelete,
    this.onClickEdit,
  });

  @override
  State<PostCard> createState() => _PostCardState();
}

class _PostCardState extends State<PostCard> {
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
          TopSectionPostCard(
            name: widget.name,
            postedTime: widget.postedTime,
            authorImage: widget.post.author!.image,
            isProfile: widget.isProfile,
            onClickDelete: widget.onClickDelete,
            onClickEdit: widget.onClickEdit,
          ),
          10.verticalSpace,
          MiddleSectionPostCard(content: widget.content, post: widget.post),
          BottomSectionPostCard(
            onClickLike: () {},
            onClickComment: () {},
            onClickShare: () {},
          ),
        ],
      ),
    );
  }
}
