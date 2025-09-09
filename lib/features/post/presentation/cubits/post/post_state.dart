import 'package:equatable/equatable.dart';

import '../../../../post/domain/entities/post_entity.dart';
import '../../../domain/entities/reaction_entity.dart';

sealed class PostState extends Equatable {
  const PostState();

  @override
  List<Object?> get props => [];
}

final class PostInitState extends PostState {
  const PostInitState();
}

final class PostLoadingState extends PostState {
  const PostLoadingState();

  @override
  List<Object?> get props => [];
}

final class PostCreatePostSuccessState extends PostState {
  const PostCreatePostSuccessState();

  @override
  List<Object?> get props => [];
}

final class PostGetDefaultPostsState extends PostState {
  final List<PostEntity> posts;

  const PostGetDefaultPostsState(this.posts);

  @override
  List<Object?> get props => [posts];
}

final class PostUploadPostMediaSuccessState extends PostState {
  final List<String> mediaPaths;

  const PostUploadPostMediaSuccessState(this.mediaPaths);

  @override
  List<Object?> get props => [mediaPaths];
}

final class PostDeletePostSuccessState extends PostState {
  const PostDeletePostSuccessState();

  @override
  List<Object?> get props => [];
}

final class PostAddReactionState extends PostState {
  const PostAddReactionState();

  @override
  List<Object?> get props => [];
}

final class PostRemoveReactionState extends PostState {
  const PostRemoveReactionState();

  @override
  List<Object?> get props => [];
}

final class PostGetUserReactionState extends PostState {
  final ReactionEntity? reaction;

  const PostGetUserReactionState(this.reaction);

  @override
  List<Object?> get props => [reaction];
}

final class PostFailureState extends PostState {
  final String code;

  const PostFailureState(this.code);

  @override
  List<Object?> get props => [code];
}
