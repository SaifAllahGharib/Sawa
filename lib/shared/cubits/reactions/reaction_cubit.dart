import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:injectable/injectable.dart';

import '../../../core/constants/reaction_type.dart';
import '../../../core/usecases/reaction_params.dart';
import '../../../features/home/domain/usecases/add_reaction_use_case.dart';
import '../../../features/home/domain/usecases/get_reaction_use_case.dart';
import '../../../features/home/domain/usecases/get_user_reaction_use_case.dart';
import '../../../features/home/domain/usecases/get_users_reaction_to_post_with_reactions.dart';
import '../../../features/home/domain/usecases/remove_reaction_use_case.dart';
import 'reactions_state.dart';

@injectable
class ReactionCubit extends Cubit<ReactionState> {
  final AddReactionUseCase _addReaction;
  final RemoveReactionUseCase _removeReaction;
  final GetReactionUseCase _getReactions;
  final GetUserReactionUseCase _getUserReaction;
  final GetUsersReactionToPostWithReactions
  _getUsersReactionToPostWithReactions;

  ReactionCubit(
    this._addReaction,
    this._removeReaction,
    this._getReactions,
    this._getUserReaction,
    this._getUsersReactionToPostWithReactions,
  ) : super(ReactionState.initial());

  void watchReactions(String postId) {
    _getReactions(postId).listen((result) {
      emit(state.copyWith(reactionsResult: result));
    });
  }

  void watchUserReaction(String postId) {
    _getUserReaction(postId).listen((result) {
      emit(state.copyWith(userReactionResult: result));
    });
  }

  Future<void> addReactionFun(String postId, ReactionType type) async {
    await _addReaction(ReactionParams(postId: postId, type: type));
  }

  Future<void> _removeReactionFun(String postId) async {
    await _removeReaction(postId);
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
    final result = await _getUsersReactionToPostWithReactions(uIds);

    result.when(
      failure: (failure) => emit(state.copyWith(users: [], isLoading: false)),
      success: (users) => emit(state.copyWith(users: users, isLoading: false)),
    );
  }
}
