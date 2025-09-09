import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:sawa/core/extensions/build_context_extensions.dart';
import 'package:sawa/core/extensions/number_extensions.dart';
import 'package:sawa/features/post/presentation/cubits/comments/comments_cubit.dart';
import 'package:sawa/features/post/presentation/widgets/comments_bottom_sheet_widget.dart';

import '../../../../core/constants/app_assets.dart';
import '../../../../core/di/dependency_injection.dart';
import '../../../../core/styles/app_colors.dart';
import '../../../../core/utils/app_bottom_sheet.dart';
import '../../../../core/widgets/app_padding_widget.dart';
import '../../../../core/widgets/app_svg.dart';
import '../cubits/reactions/reaction_cubit.dart';
import 'like_button.dart';
import 'post_action_button.dart';
import 'reactions_icons_row_post.dart';

class BottomSectionPostCard extends StatelessWidget {
  final String postId;

  const BottomSectionPostCard({super.key, required this.postId});

  void _showCommentBottomSheet(BuildContext context) {
    AppBottomSheet.show(context, (context) {
      return BlocProvider(
        create: (context) => getIt<CommentsCubit>(),
        child: CommentsBottomSheetWidget(postId: postId),
      );
    });
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider.value(
      value: getIt<ReactionCubit>()
        ..watchPostReactions(postId)
        ..watchUserPostReaction(postId),
      child: AppPaddingWidget(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const ReactionsIconsRowPost(),
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
                  onPressed: () => _showCommentBottomSheet(context),
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
