import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:sawa/core/extensions/build_context_extensions.dart';
import 'package:sawa/core/extensions/number_extensions.dart';
import 'package:sawa/core/styles/app_colors.dart';
import 'package:sawa/core/widgets/app_gesture_detector_button.dart';
import 'package:sawa/features/post/presentation/cubits/post/post_cubit.dart';
import 'package:sawa/features/post/presentation/cubits/post/post_state.dart';

import '../../../../core/constants/app_assets.dart';
import '../../../../core/widgets/app_padding_widget.dart';
import '../../../../core/widgets/app_svg.dart';

class CommentTextField extends StatelessWidget {
  final VoidCallback onTapSend;

  const CommentTextField({super.key, required this.onTapSend});

  @override
  Widget build(BuildContext context) {
    return AppPaddingWidget(
      top: 0,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        spacing: 10.w,
        children: [
          Expanded(
            child: TextFormField(
              keyboardType: TextInputType.multiline,
              minLines: 1,
              maxLines: 5,
              decoration: InputDecoration(hintText: context.tr.comment),
              onTapOutside: (event) =>
                  FocusManager.instance.primaryFocus?.unfocus(),
              onChanged: (value) {
                context.read<PostCubit>().enableSendComment(value);
              },
            ),
          ),
          BlocBuilder<PostCubit, PostState>(
            buildWhen: (previous, current) =>
                current is EnableSendCommentButtonState,
            builder: (context, state) {
              final enabled = state is EnableSendCommentButtonState
                  ? state.enabled
                  : false;

              return AppGestureDetectorButton(
                onTap: enabled ? onTapSend : () {},
                child: AppSvg(
                  assetName: AppAssets.send,
                  height: 35.h,
                  width: 35.h,
                  colorFilter: ColorFilter.mode(
                    enabled ? context.theme.primaryColor : AppColors.gray,
                    BlendMode.srcIn,
                  ),
                ),
              );
            },
          ),
        ],
      ),
    );
  }
}
