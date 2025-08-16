import 'package:flutter/material.dart';
import 'package:sawa/core/extensions/build_context_extensions.dart';
import 'package:sawa/core/extensions/number_extensions.dart';
import 'package:sawa/core/styles/app_colors.dart';

import '../constants/app_assets.dart';
import 'app_padding_widget.dart';
import 'app_svg.dart';
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
                  icon: _buildSvgIcon(
                    assetName: AppAssets.unLike,
                    color: AppColors.gray,
                  ),
                  label: context.tr.comment,
                  onPressed: null,
                ),
              10.horizontalSpace,
              PostActionButton(
                icon: _buildSvgIcon(
                  assetName: AppAssets.comment,
                  color: AppColors.gray,
                ),
                label: context.tr.comment,
                onPressed: isPost ? () {} : null,
              ),
              10.horizontalSpace,
              PostActionButton(
                icon: _buildSvgIcon(
                  assetName: AppAssets.share,
                  color: AppColors.gray,
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

  Widget _buildSvgIcon({required String assetName, required Color color}) {
    return AppSvg(
      assetName: assetName,
      colorFilter: ColorFilter.mode(color, BlendMode.srcIn),
      width: 25.r,
      height: 25.r,
    );
  }
}
