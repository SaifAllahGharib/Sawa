import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:sawa/core/extensions/build_context_extensions.dart';
import 'package:sawa/core/extensions/number_extensions.dart';
import 'package:sawa/features/post/domain/entities/comment_response_entity.dart';

import '../../../../core/di/dependency_injection.dart';
import '../../../../core/helpers/date_time_helper.dart';
import '../../../../core/styles/app_styles.dart';
import '../../../../core/widgets/app_gesture_detector_button.dart';
import '../../../../core/widgets/app_padding_widget.dart';
import '../../../../core/widgets/app_read_more_text.dart';
import '../../../../core/widgets/profile_image.dart';
import '../cubits/reactions/reaction_cubit.dart';
import 'reactions_icons_row_comment.dart';

class CommentItemWidget extends StatefulWidget {
  final CommentResponseEntity comment;

  const CommentItemWidget({super.key, required this.comment});

  @override
  State<CommentItemWidget> createState() => _CommentItemWidgetState();
}

class _CommentItemWidgetState extends State<CommentItemWidget> {
  late final Stream<String> _timeStream;

  @override
  void initState() {
    super.initState();
    _timeStream = Stream.periodic(
      const Duration(microseconds: 1),
      (_) => _getTimeAgo(),
    );
  }

  String _getTimeAgo() {
    return DateTimeHelper.timeAgoSinceDate(context, widget.comment.createdAt);
  }

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
            ProfileImage(url: widget.comment.user.image),
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
                      child: AppReadMoreText(
                        numberOfLines: 5,
                        content: widget.comment.content,
                      ),
                    ),
                  ),
                  10.verticalSpace,
                  Row(
                    children: [
                      StreamBuilder<String>(
                        stream: _timeStream,
                        builder: (context, snapshot) {
                          return Text(
                            snapshot.data.toString(),
                            maxLines: 1,
                            overflow: TextOverflow.ellipsis,
                            style: AppStyles.s14W400.copyWith(
                              color: context.customColor.textColor,
                            ),
                          );
                        },
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
