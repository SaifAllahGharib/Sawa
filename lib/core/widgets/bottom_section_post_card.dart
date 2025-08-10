import 'package:failure_handler/failure_handler.dart';
import 'package:flutter/material.dart';
import 'package:intern_intelligence_social_media_application/core/di/dependency_injection.dart';
import 'package:intern_intelligence_social_media_application/core/extensions/build_context_extensions.dart';
import 'package:intern_intelligence_social_media_application/core/extensions/number_extensions.dart';
import 'package:intern_intelligence_social_media_application/core/styles/app_colors.dart';
import 'package:intern_intelligence_social_media_application/core/styles/app_styles.dart';
import 'package:intern_intelligence_social_media_application/core/widgets/app_gesture_detector_button.dart';
import 'package:intern_intelligence_social_media_application/features/home/domain/usecases/add_reaction_use_case.dart';
import 'package:intern_intelligence_social_media_application/features/home/domain/usecases/get_reaction_use_case.dart';
import 'package:intern_intelligence_social_media_application/features/home/domain/usecases/get_user_reaction_use_case.dart';
import 'package:intern_intelligence_social_media_application/features/home/domain/usecases/remove_reaction_use_case.dart';

import '../../features/home/domain/entities/reaction_entity.dart';
import '../utils/app_bottom_sheet.dart';
import '../utils/enums.dart';
import 'app_padding_widget.dart';
import 'post_action_button.dart';

class BottomSectionPostCard extends StatelessWidget {
  final bool isPost;
  final String? postId;

  const BottomSectionPostCard({super.key, this.isPost = false, this.postId});

  void _onClickLike(BuildContext context, bool isLiked) {
    if (isLiked) {
      _removeReaction();
    } else {
      _addReaction();
    }
  }

  void _addReaction() async {
    await getIt<AddReactionUseCase>().call([postId!, ReactionType.like]);
  }

  void _removeReaction() async {
    await getIt<RemoveReactionUseCase>().call(postId!);
  }

  void _getReaction(BuildContext context, List<String> users) {
    AppBottomSheet.show(context, (context) => ReactionListWidget(users: users));
  }

  @override
  Widget build(BuildContext context) {
    return AppPaddingWidget(
      child: Column(
        children: [
          if (isPost)
            StreamBuilder<Result<AppFailure, List<ReactionEntity>>>(
              stream: getIt<GetReactionUseCase>().call(postId!),
              builder: (context, snapshot) {
                if (!snapshot.hasData) {
                  return const SizedBox.shrink();
                }

                final result = snapshot.data!;

                return result.when(
                  failure: (failure) => const SizedBox.shrink(),
                  success: (reactions) {
                    if (reactions.isEmpty) return const SizedBox.shrink();

                    ;

                    return AppGestureDetectorButton(
                      onTap: () => _getReaction(
                        context,
                        reactions.map((e) => e.userId).toList(),
                      ),
                      child: Row(
                        children: [
                          Icon(
                            Icons.thumb_up_alt_rounded,
                            color: Colors.blue,
                            size: 20.r,
                          ),
                          2.horizontalSpace,
                          if (reactions.length != 1)
                            Text(
                              '+${reactions.length - 1}',
                              style: AppStyles.s14W400,
                            ),
                        ],
                      ),
                    );
                  },
                );
              },
            ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              if (isPost)
                StreamBuilder<Result<AppFailure, ReactionEntity?>>(
                  stream: getIt<GetUserReactionUseCase>().call(postId!),
                  builder: (context, snapshot) {
                    if (!snapshot.hasData) {
                      return _buildReactionButton(context, false);
                    }

                    final result = snapshot.data!;

                    return result.when(
                      failure: (failure) =>
                          _buildReactionButton(context, false),
                      success: (reaction) {
                        return _buildReactionButton(context, reaction != null);
                      },
                    );
                  },
                )
              else
                _buildReactionButton(context, false),
              10.horizontalSpace,
              PostActionButton(
                iconColor: AppColors.gray,
                icon: Icons.comment_outlined,
                label: context.tr.comment,
                onPressed: isPost ? () {} : null,
              ),
              10.horizontalSpace,
              PostActionButton(
                iconColor: AppColors.gray,
                icon: Icons.share_outlined,
                label: context.tr.share,
                onPressed: isPost ? () {} : null,
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildReactionButton(BuildContext context, bool isLiked) {
    return PostActionButton(
      icon: isLiked ? Icons.thumb_up_alt_rounded : Icons.thumb_up_alt_outlined,
      iconColor: isLiked ? Colors.blue : AppColors.gray,
      label: context.tr.like,
      onPressed: isPost ? () => _onClickLike(context, isLiked) : null,
    );
  }
}

class ReactionListWidget extends StatelessWidget {
  final List<String> users;

  const ReactionListWidget({super.key, required this.users});

  @override
  Widget build(BuildContext context) {
    return AppPaddingWidget(
      child: Column(
        children: [
          Expanded(
            child: ListView.builder(
              itemCount: users.length,
              itemBuilder: (context, index) {
                return Text(users[index]);
              },
            ),
          ),
        ],
      ),
    );
  }
}
