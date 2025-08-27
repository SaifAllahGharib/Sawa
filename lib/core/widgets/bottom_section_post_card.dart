import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:sawa/core/extensions/build_context_extensions.dart';
import 'package:sawa/core/extensions/number_extensions.dart';
import 'package:sawa/core/styles/app_colors.dart';
import 'package:sawa/core/utils/app_bottom_sheet.dart';
import 'package:sawa/core/widgets/app_gesture_detector_button.dart';
import 'package:sawa/core/widgets/app_read_more_text.dart';
import 'package:sawa/core/widgets/profile_image.dart';

import '../../shared/cubits/reactions/reaction_cubit.dart';
import '../constants/app_assets.dart';
import '../di/dependency_injection.dart';
import '../styles/app_styles.dart';
import 'app_padding_widget.dart';
import 'app_svg.dart';
import 'like_button.dart';
import 'post_action_button.dart';
import 'reactions_icons_row_post.dart';

class BottomSectionPostCard extends StatelessWidget {
  final String postId;

  const BottomSectionPostCard({super.key, required this.postId});

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
                  onPressed: () {
                    AppBottomSheet.show(context, (context) {
                      return ListView.builder(
                        itemCount: 10,
                        itemBuilder: (context, index) {
                          return AppPaddingWidget(
                            top: 0,
                            child: Row(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                const ProfileImage(),
                                10.horizontalSpace,
                                Expanded(
                                  child: Column(
                                    mainAxisSize: MainAxisSize.min,
                                    children: [
                                      Flexible(
                                        fit: FlexFit.loose,
                                        child: Container(
                                          padding: EdgeInsets.all(10.r),
                                          width: double.infinity,
                                          decoration: BoxDecoration(
                                            color: context.customColor.overlay,
                                            borderRadius: BorderRadius.circular(
                                              10.r,
                                            ),
                                          ),
                                          child: const AppReadMoreText(
                                            numberOfLines: 5,
                                            content:
                                                'سيبتاسخيبسمنيبهخسيبتسيSdfsdfhnsllakshflashflkasfhoaosjfhalksfhalksfhlaksfسيبسيبسيبسيخهابخهسيبSdfoiisdflskdhlkashflkashflkashflkasfhla',
                                          ),
                                        ),
                                      ),
                                      10.verticalSpace,
                                      Row(
                                        children: [
                                          Text(
                                            '2 ${context.tr.h}',
                                            style: AppStyles.s14W400.copyWith(
                                              color:
                                                  context.customColor.textColor,
                                            ),
                                          ),
                                          15.horizontalSpace,
                                          AppGestureDetectorButton(
                                            onTap: () {},
                                            child: Text(
                                              context.tr.reply,
                                              style: AppStyles.s14W400.copyWith(
                                                color: context
                                                    .customColor
                                                    .textColor,
                                              ),
                                            ),
                                          ),
                                          15.horizontalSpace,
                                          AppGestureDetectorButton(
                                            onTap: () {},
                                            child: Text(
                                              context.tr.like,
                                              style: AppStyles.s14W400.copyWith(
                                                color: context
                                                    .customColor
                                                    .textColor,
                                              ),
                                            ),
                                          ),
                                          const Spacer(),
                                          Row(
                                            children: [
                                              const AppSvg(
                                                assetName: AppAssets.like,
                                              ),
                                              const AppSvg(
                                                assetName: AppAssets.care,
                                              ),
                                              const AppSvg(
                                                assetName: AppAssets.angry,
                                              ),
                                              const AppSvg(
                                                assetName: AppAssets.love,
                                              ),
                                            ],
                                          ),
                                        ],
                                      ),
                                    ],
                                  ),
                                ),
                              ],
                            ),
                          );
                        },
                      );
                    });
                  },
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
