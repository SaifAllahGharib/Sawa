import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:sawa/core/extensions/build_context_extensions.dart';
import 'package:sawa/core/extensions/number_extensions.dart';
import 'package:sawa/core/styles/app_colors.dart';

import '../../shared/cubits/reactions/reaction_cubit.dart';
import '../constants/app_assets.dart';
import '../di/dependency_injection.dart';
import 'app_padding_widget.dart';
import 'app_svg.dart';
import 'like_button.dart';
import 'post_action_button.dart';
import 'reactions_icons_row.dart';

class BottomSectionPostCard extends StatelessWidget {
  final String postId;

  const BottomSectionPostCard({super.key, required this.postId});

  @override
  Widget build(BuildContext context) {
    return BlocProvider.value(
      value: getIt<ReactionCubit>()
        ..watchReactions(postId)
        ..watchUserReaction(postId),
      child: AppPaddingWidget(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            ReactionsIconsRow(postId: postId),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                LikeButton(postId: postId),
                10.horizontalSpace,
                PostActionButton(
                  icon: _buildSvgIcon(
                    assetName: AppAssets.comment,
                    color: AppColors.gray,
                  ),
                  label: context.tr.comment,
                  onPressed: () {},
                ),
                10.horizontalSpace,
                PostActionButton(
                  icon: _buildSvgIcon(
                    assetName: AppAssets.share,
                    color: AppColors.gray,
                  ),
                  label: context.tr.share,
                  onPressed: () {},
                ),
              ],
            ),
          ],
        ),
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
