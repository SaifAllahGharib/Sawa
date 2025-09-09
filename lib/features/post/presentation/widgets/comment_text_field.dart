import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:sawa/core/extensions/build_context_extensions.dart';
import 'package:sawa/core/extensions/number_extensions.dart';
import 'package:sawa/core/styles/app_colors.dart';
import 'package:sawa/core/widgets/app_gesture_detector_button.dart';
import 'package:sawa/core/widgets/app_loading_widget.dart';
import 'package:sawa/features/post/presentation/cubits/comments/comments_cubit.dart';
import 'package:sawa/features/post/presentation/cubits/comments/comments_state.dart';

import '../../../../core/constants/app_assets.dart';
import '../../../../core/widgets/app_padding_widget.dart';
import '../../../../core/widgets/app_svg.dart';
import '../../data/models/comment_request_model.dart';

class CommentTextField extends StatefulWidget {
  final String postId;

  const CommentTextField({super.key, required this.postId});

  @override
  State<CommentTextField> createState() => _CommentTextFieldState();
}

class _CommentTextFieldState extends State<CommentTextField> {
  late final TextEditingController _controller;

  @override
  void initState() {
    _controller = TextEditingController();
    super.initState();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  void _addComment() {
    final cubit = context.read<CommentsCubit>();

    cubit.addComment(
      CommentRequestModel(
        postId: widget.postId,
        content: _controller.text.trimLeft().trimRight(),
      ),
    );
    cubit.resetButtonState();
    _controller.clear();
  }

  void _enableButton(String value) {
    context.read<CommentsCubit>().enableSendComment(value);
  }

  @override
  Widget build(BuildContext context) {
    return AppPaddingWidget(
      top: 0,
      child: BlocBuilder<CommentsCubit, CommentsState>(
        builder: (context, state) {
          final enabled = state is EnableSendCommentButtonState
              ? state.enable
              : false;

          if (state is AddCommentsLoadingState) {
            return const AppLoadingWidget();
          }

          return Row(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            spacing: 10.w,
            children: [
              Expanded(
                child: TextFormField(
                  controller: _controller,
                  keyboardType: TextInputType.multiline,
                  minLines: 1,
                  maxLines: 5,
                  decoration: InputDecoration(hintText: context.tr.comment),
                  onTapOutside: (event) =>
                      FocusManager.instance.primaryFocus?.unfocus(),
                  onChanged: _enableButton,
                ),
              ),
              AppGestureDetectorButton(
                onTap: enabled ? () => _addComment() : () {},
                child: AppSvg(
                  assetName: AppAssets.send,
                  height: 35.h,
                  width: 35.h,
                  colorFilter: ColorFilter.mode(
                    enabled ? context.theme.primaryColor : AppColors.gray,
                    BlendMode.srcIn,
                  ),
                ),
              ),
            ],
          );
        },
      ),
    );
  }
}
