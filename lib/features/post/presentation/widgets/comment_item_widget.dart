import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:sawa/core/extensions/build_context_extensions.dart';
import 'package:sawa/core/extensions/number_extensions.dart';

import '../../../../core/di/dependency_injection.dart';
import '../../../../core/styles/app_styles.dart';
import '../../../../core/widgets/app_gesture_detector_button.dart';
import '../../../../core/widgets/app_padding_widget.dart';
import '../../../../core/widgets/app_read_more_text.dart';
import '../../../../core/widgets/profile_image.dart';
import '../cubits/reactions/reaction_cubit.dart';
import 'reactions_icons_row_comment.dart';

class CommentItemWidget extends StatelessWidget {
  const CommentItemWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider.value(
      value: getIt<ReactionCubit>()
        ..watchCommentReactions('0')
        ..watchUserCommentReaction('0'),
      child: AppPaddingWidget(
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
                        borderRadius: BorderRadius.circular(10.r),
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
                          color: context.customColor.textColor,
                        ),
                      ),
                      15.horizontalSpace,
                      AppGestureDetectorButton(
                        onTap: () {},
                        child: Text(
                          context.tr.reply,
                          style: AppStyles.s14W400.copyWith(
                            color: context.customColor.textColor,
                          ),
                        ),
                      ),
                      15.horizontalSpace,
                      AppGestureDetectorButton(
                        onTap: () {},
                        child: Text(
                          context.tr.like,
                          style: AppStyles.s14W400.copyWith(
                            color: context.customColor.textColor,
                          ),
                        ),
                      ),
                      const Spacer(),
                      const ReactionsIconsRowComment(),
                    ],
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
