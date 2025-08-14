import 'package:failure_handler/failure_handler.dart';

import '../../../features/home/domain/entities/reaction_entity.dart';

class ReactionState {
  final Result<AppFailure, List<ReactionEntity>>? reactionsResult;
  final Result<AppFailure, ReactionEntity?>? userReactionResult;

  const ReactionState({
    required this.reactionsResult,
    required this.userReactionResult,
  });

  factory ReactionState.initial() {
    return const ReactionState(reactionsResult: null, userReactionResult: null);
  }

  ReactionState copyWith({
    Result<AppFailure, List<ReactionEntity>>? reactionsResult,
    Result<AppFailure, ReactionEntity?>? userReactionResult,
  }) {
    return ReactionState(
      reactionsResult: reactionsResult ?? this.reactionsResult,
      userReactionResult: userReactionResult ?? this.userReactionResult,
    );
  }
}
