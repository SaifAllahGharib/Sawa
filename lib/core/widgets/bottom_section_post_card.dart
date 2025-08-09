import 'package:flutter/material.dart';
import 'package:intern_intelligence_social_media_application/core/extensions/build_context_extensions.dart';

import 'app_padding_widget.dart';
import 'post_action_button.dart';

class BottomSectionPostCard extends StatelessWidget {
  final VoidCallback onClickLike;
  final VoidCallback onClickComment;
  final VoidCallback onClickShare;

  const BottomSectionPostCard({
    super.key,
    required this.onClickLike,
    required this.onClickComment,
    required this.onClickShare,
  });

  @override
  Widget build(BuildContext context) {
    return AppPaddingWidget(
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          PostActionButton(
            icon: Icons.favorite_border,
            label: context.tr.like,
            onPressed: onClickLike,
          ),
          PostActionButton(
            icon: Icons.comment_outlined,
            label: context.tr.comment,
            onPressed: onClickComment,
          ),
          PostActionButton(
            icon: Icons.share_outlined,
            label: context.tr.share,
            onPressed: onClickShare,
          ),
        ],
      ),
    );
  }
}
