import 'package:equatable/equatable.dart';
import 'package:intern_intelligence_social_media_application/features/home/domain/entities/post_entity.dart';
import 'package:intern_intelligence_social_media_application/features/home/domain/entities/reaction_entity.dart';

sealed class HomeState extends Equatable {
  const HomeState();

  @override
  List<Object?> get props => [];
}

final class HomeInitState extends HomeState {
  const HomeInitState();

  @override
  List<Object?> get props => [];
}

final class HomeLoadingState extends HomeState {
  const HomeLoadingState();

  @override
  List<Object?> get props => [];
}

final class HomeCreatePostSuccessState extends HomeState {
  const HomeCreatePostSuccessState();

  @override
  List<Object?> get props => [];
}

final class HomeGetDefaultPostsState extends HomeState {
  final List<PostEntity> posts;

  const HomeGetDefaultPostsState(this.posts);

  @override
  List<Object?> get props => [posts];
}

final class HomeUploadPostMediaSuccessState extends HomeState {
  final List<String> mediaPaths;

  const HomeUploadPostMediaSuccessState(this.mediaPaths);

  @override
  List<Object?> get props => [mediaPaths];
}

final class HomeDeletePostSuccessState extends HomeState {
  const HomeDeletePostSuccessState();

  @override
  List<Object?> get props => [];
}

final class HomeAddReactionState extends HomeState {
  const HomeAddReactionState();

  @override
  List<Object?> get props => [];
}

final class HomeRemoveReactionState extends HomeState {
  const HomeRemoveReactionState();

  @override
  List<Object?> get props => [];
}

final class HomeGetUserReactionState extends HomeState {
  final ReactionEntity? reaction;

  const HomeGetUserReactionState(this.reaction);

  @override
  List<Object?> get props => [reaction];
}

final class HomeFailureState extends HomeState {
  final String code;

  const HomeFailureState(this.code);

  @override
  List<Object?> get props => [code];
}
