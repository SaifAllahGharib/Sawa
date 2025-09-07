import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:injectable/injectable.dart';

import '../../../data/models/create_post_model.dart';
import '../../../domain/repositories/i_post_repository.dart';
import 'post_state.dart';

@injectable
class PostCubit extends Cubit<PostState> {
  final IPostRepository _iPostRepository;

  bool _enableSendCommentButton = false;

  PostCubit(this._iPostRepository) : super(const PostInitState());

  Future<void> createPost({required CreatePostModel createPostModel}) async {
    emit(const PostLoadingState());

    final result = await _iPostRepository.createPost(
      createPostModel: createPostModel,
    );

    result.when(
      failure: (failure) => emit(PostFailureState(failure.code)),
      success: (_) => emit(const PostCreatePostSuccessState()),
    );
  }

  Future<void> getDefaultPosts() async {
    emit(const PostLoadingState());
    final result = await _iPostRepository.getDefaultPosts();

    result.when(
      failure: (failure) => emit(PostFailureState(failure.code)),
      success: (posts) => emit(PostGetDefaultPostsState(posts)),
    );
  }

  Future<void> deletePost(String postId) async {
    final result = await _iPostRepository.deletePost(postId: postId);

    result.when(
      failure: (failure) => emit(PostFailureState(failure.code)),
      success: (_) => emit(const PostDeletePostSuccessState()),
    );
  }

  void enableSendComment(String value) {
    _enableSendCommentButton = value.isNotEmpty;
    emit(EnableSendCommentButtonState(_enableSendCommentButton));
  }

  bool get enableSendCommentButton => _enableSendCommentButton;
}
