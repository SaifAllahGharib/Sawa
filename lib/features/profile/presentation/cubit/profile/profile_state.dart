import 'package:equatable/equatable.dart';
import 'package:intern_intelligence_social_media_application/features/home/domain/entities/post_entity.dart';

sealed class ProfileState extends Equatable {
  const ProfileState();

  @override
  List<Object?> get props => [];
}

final class ProfileInitState extends ProfileState {
  const ProfileInitState();

  @override
  List<Object?> get props => [];
}

final class ProfileLoadingState extends ProfileState {
  const ProfileLoadingState();

  @override
  List<Object?> get props => [];
}

final class ProfileGetPostsState extends ProfileState {
  final List<PostEntity> posts;

  const ProfileGetPostsState(this.posts);

  @override
  List<Object?> get props => [posts];
}

final class ProfileFailureState extends ProfileState {
  final String code;

  const ProfileFailureState(this.code);

  @override
  List<Object?> get props => [code];
}
