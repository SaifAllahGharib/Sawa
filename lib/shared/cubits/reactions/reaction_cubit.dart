import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:injectable/injectable.dart';
import 'package:sawa/features/home/domain/repositories/home_repository.dart';

import '../../../core/constants/reaction_type.dart';
import 'reactions_state.dart';

@injectable
class ReactionCubit extends Cubit<ReactionState> {
  final IHomeRepository _iHomeRepository;

  ReactionCubit(this._iHomeRepository) : super(ReactionState.initial());

  void watchPostReactions(String postId) {
    _iHomeRepository.getPostReactions(postId: postId).listen((result) {
      emit(state.copyWith(reactionsResult: result));
    });
  }

  void watchUserPostReaction(String postId) {
    _iHomeRepository.getUserPostReaction(postId: postId).listen((result) {
      emit(state.copyWith(userReactionResult: result));
    });
  }

  Future<void> addReactionFun(String postId, ReactionType type) async {
    await _iHomeRepository.addReaction(postId: postId, type: type);
  }

  Future<void> _removeReactionFun(String postId) async {
    await _iHomeRepository.removeReaction(postId: postId);
  }

  void toggleLike(String postId) {
    final current = state.userReactionResult?.when(
      failure: (_) => null,
      success: (r) => r,
    );

    if (current != null) {
      _removeReactionFun(postId);
    } else {
      addReactionFun(postId, ReactionType.like);
    }
  }

  Future<void> getUsersReactionToPostWithReactions(List<String> uIds) async {
    emit(state.copyWith(isLoading: true));
    final result = await _iHomeRepository.getUsersReactedToPostWithReaction(
      uIds: uIds,
    );

    result.when(
      failure: (failure) => emit(state.copyWith(users: [], isLoading: false)),
      success: (users) => emit(state.copyWith(users: users, isLoading: false)),
    );
  }
}
