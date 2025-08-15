import 'package:flutter/material.dart';
import 'package:sawa/core/extensions/build_context_extensions.dart';
import 'package:sawa/core/extensions/number_extensions.dart';

import 'app_padding_widget.dart';
import 'like_button.dart';
import 'post_action_button.dart';
import 'reactions_icons_row.dart';

class BottomSectionPostCard extends StatelessWidget {
  final bool isPost;
  final String postId;

  const BottomSectionPostCard({
    super.key,
    this.isPost = false,
    this.postId = '',
  });

  @override
  Widget build(BuildContext context) {
    return AppPaddingWidget(
      child: Column(
        children: [
          if (isPost) ReactionsIconsRow(postId: postId),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              if (isPost)
                LikeButton(postId: postId)
              else
                PostActionButton(
                  icon: const Icon(
                    Icons.thumb_up_alt_outlined,
                    color: Colors.grey,
                    size: 20,
                  ),
                  label: context.tr.comment,
                  onPressed: null,
                ),
              10.horizontalSpace,
              PostActionButton(
                icon: const Icon(
                  Icons.comment_outlined,
                  color: Colors.grey,
                  size: 20,
                ),
                label: context.tr.comment,
                onPressed: isPost ? () {} : null,
              ),
              10.horizontalSpace,
              PostActionButton(
                icon: const Icon(
                  Icons.share_outlined,
                  color: Colors.grey,
                  size: 20,
                ),
                label: context.tr.share,
                onPressed: isPost ? () {} : null,
              ),
            ],
          ),
        ],
      ),
    );
  }
}
