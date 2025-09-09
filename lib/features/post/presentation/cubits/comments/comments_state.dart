import 'package:equatable/equatable.dart';

import '../../../domain/entities/comment_response_entity.dart';

sealed class CommentsState extends Equatable {
  const CommentsState();

  @override
  List<Object?> get props => [];
}

final class CommentsInitState extends CommentsState {
  const CommentsInitState();
}

final class GetCommentsLoadingState extends CommentsState {
  const GetCommentsLoadingState();
}

final class AddCommentsLoadingState extends CommentsState {
  const AddCommentsLoadingState();
}

final class AddCommentState extends CommentsState {
  const AddCommentState();
}

final class GetCommentsState extends CommentsState {
  final List<CommentResponseEntity> comments;

  const GetCommentsState(this.comments);

  @override
  List<Object?> get props => [comments];
}

final class EnableSendCommentButtonState extends CommentsState {
  final bool enable;

  const EnableSendCommentButtonState(this.enable);

  @override
  List<Object?> get props => [enable];
}

final class CommentsFailureState extends CommentsState {
  final String code;

  const CommentsFailureState(this.code);

  @override
  List<Object?> get props => [code];
}
