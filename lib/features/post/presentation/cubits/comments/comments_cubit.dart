import 'package:bloc/bloc.dart';
import 'package:injectable/injectable.dart';

import '../../../data/models/comment_request_model.dart';
import '../../../domain/repositories/i_post_repository.dart';
import 'comments_state.dart';

@injectable
class CommentsCubit extends Cubit<CommentsState> {
  final IPostRepository _iPostRepository;

  bool _enableSendCommentButton = false;

  CommentsCubit(this._iPostRepository) : super(const CommentsInitState());

  Future<void> addComment(CommentRequestModel comment) async {
    emit(const AddCommentsLoadingState());
    final result = await _iPostRepository.addComment(comment: comment);

    result.when(
      failure: (failure) => emit(CommentsFailureState(failure.code)),
      success: (_) => emit(const AddCommentState()),
    );
  }

  Future<void> getComments(String postId) async {
    emit(const GetCommentsLoadingState());
    final result = await _iPostRepository.getComments(postId: postId);

    result.when(
      failure: (failure) => emit(CommentsFailureState(failure.code)),
      success: (comments) => emit(GetCommentsState(comments)),
    );
  }

  void enableSendComment(String value) {
    _enableSendCommentButton = value.isNotEmpty;
    emit(EnableSendCommentButtonState(_enableSendCommentButton));
  }

  void resetButtonState() {
    _enableSendCommentButton = false;
    emit(EnableSendCommentButtonState(_enableSendCommentButton));
  }

  bool get enableSendCommentButton => _enableSendCommentButton;
}
