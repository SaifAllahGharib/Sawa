import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:sawa/core/extensions/build_context_extensions.dart';
import 'package:sawa/core/extensions/number_extensions.dart';
import 'package:sawa/core/services/navigation/navigation_service.dart';
import 'package:sawa/core/utils/app_snack_bar.dart';
import 'package:sawa/core/widgets/app_loading_widget.dart';
import 'package:sawa/features/post/domain/entities/comment_response_entity.dart';
import 'package:sawa/features/post/presentation/cubits/comments/comments_cubit.dart';

import '../cubits/comments/comments_state.dart';
import 'comment_item_widget.dart';
import 'comment_text_field.dart';

class CommentsBottomSheetWidget extends StatefulWidget {
  final String postId;

  const CommentsBottomSheetWidget({super.key, required this.postId});

  @override
  State<CommentsBottomSheetWidget> createState() =>
      _CommentsBottomSheetWidgetState();
}

class _CommentsBottomSheetWidgetState extends State<CommentsBottomSheetWidget> {
  List<CommentResponseEntity> _comments = [];

  @override
  void initState() {
    context.read<CommentsCubit>().getComments(widget.postId);
    super.initState();
  }

  void _handleState(CommentsState state) {
    if (state is GetCommentsState) {
      _comments = state.comments;
    } else if (state is CommentsFailureState) {
      NavigationService.I.pop();
      AppSnackBar.showError(context, 'field to get Comments');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Expanded(
          child: BlocConsumer<CommentsCubit, CommentsState>(
            listener: (context, state) => _handleState(state),
            builder: (context, state) {
              if (state is GetCommentsLoadingState) {
                return const AppLoadingWidget();
              }

              if (_comments.isEmpty) {
                return Center(child: Text(context.tr.empty));
              }

              return ListView.builder(
                itemCount: _comments.length,
                itemBuilder: (context, index) {
                  return CommentItemWidget(comment: _comments[index]);
                },
              );
            },
          ),
        ),
        10.verticalSpace,
        CommentTextField(postId: widget.postId),
      ],
    );
  }
}
