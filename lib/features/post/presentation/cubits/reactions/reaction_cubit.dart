import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:injectable/injectable.dart';

import '../../../../../core/enums/reaction_type.dart';
import '../../../domain/repositories/i_post_repository.dart';
import 'reactions_state.dart';

@injectable
class ReactionCubit extends Cubit<ReactionState> {
  final IPostRepository _iPostRepository;

  ReactionCubit(this._iPostRepository) : super(ReactionState.initial());

  void watchPostReactions(String postId) {
    _iPostRepository.getPostReactions(postId: postId).listen((result) {
      emit(state.copyWith(reactionsResult: result));
    });
  }

  void watchUserPostReaction(String postId) {
    _iPostRepository.getUserPostReaction(postId: postId).listen((result) {
      emit(state.copyWith(userReactionResult: result));
    });
  }

  Future<void> addReactionToPost(String postId, ReactionType type) async {
    await _iPostRepository.addReaction(postId: postId, type: type);
  }

  Future<void> _removeReactionFromPost(String postId) async {
    await _iPostRepository.removeReaction(postId: postId);
  }

  void toggleLikeToPost(String postId) {
    final current = state.userReactionResult?.when(
      failure: (_) => null,
      success: (r) => r,
    );

    if (current != null) {
      _removeReactionFromPost(postId);
    } else {
      addReactionToPost(postId, ReactionType.like);
    }
  }

  Future<void> getUsersReactionToPostWithReactions(List<String> uIds) async {
    emit(state.copyWith(isLoading: true));
    final result = await _iPostRepository.getUsersReactedToPostWithReaction(
      uIds: uIds,
    );

    result.when(
      failure: (failure) => emit(state.copyWith(users: [], isLoading: false)),
      success: (users) => emit(state.copyWith(users: users, isLoading: false)),
    );
  }

  void watchCommentReactions(String commentId) {
    _iPostRepository.getCommentReactions(commentId: commentId).listen((result) {
      emit(state.copyWith(reactionsCommentResult: result));
    });
  }

  void watchUserCommentReaction(String commentId) {
    _iPostRepository.getUserCommentReaction(commentId: commentId).listen((
      result,
    ) {
      emit(state.copyWith(userReactionCommentResult: result));
    });
  }

  Future<void> addReactionToComment(String commentId, ReactionType type) async {
    await _iPostRepository.addReactionToComment(
      commentId: commentId,
      type: type,
    );
  }

  Future<void> _removeReactionFromComment(String commentId) async {
    await _iPostRepository.removeReactionFromComment(commentId: commentId);
  }

  void toggleLikeToComment(String commentId) {
    final current = state.userReactionCommentResult?.when(
      failure: (_) => null,
      success: (r) => r,
    );

    if (current != null) {
      _removeReactionFromComment(commentId);
    } else {
      addReactionToComment(commentId, ReactionType.like);
    }
  }
}
