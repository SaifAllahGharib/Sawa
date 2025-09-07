import 'package:failure_handler/failure_handler.dart';

import '../../../../user/domain/entity/user_entity.dart';
import '../../../domain/entities/reaction_entity.dart';

class ReactionState {
  final Result<AppFailure, List<ReactionEntity>>? reactionsResult;
  final Result<AppFailure, ReactionEntity?>? userReactionResult;
  final bool isLoading;
  final List<UserEntity> users;

  const ReactionState({
    required this.reactionsResult,
    required this.userReactionResult,
    required this.isLoading,
    required this.users,
  });

  factory ReactionState.initial() {
    return const ReactionState(
      reactionsResult: null,
      userReactionResult: null,
      isLoading: false,
      users: [],
    );
  }

  ReactionState copyWith({
    Result<AppFailure, List<ReactionEntity>>? reactionsResult,
    Result<AppFailure, ReactionEntity?>? userReactionResult,
    bool? isLoading,
    List<UserEntity> users = const [],
  }) {
    return ReactionState(
      reactionsResult: reactionsResult ?? this.reactionsResult,
      userReactionResult: userReactionResult ?? this.userReactionResult,
      isLoading: isLoading ?? this.isLoading,
      users: users.isEmpty ? this.users : users,
    );
  }
}
