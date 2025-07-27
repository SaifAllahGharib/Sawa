import 'package:equatable/equatable.dart';
import 'package:intern_intelligence_social_media_application/features/profile/domain/entity/profile_entity.dart';

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

final class ProfileLoadingUpdateProfileState extends ProfileState {
  const ProfileLoadingUpdateProfileState();

  @override
  List<Object?> get props => [];
}

final class ProfileGetState extends ProfileState {
  final ProfileEntity profile;

  const ProfileGetState(this.profile);

  @override
  List<Object?> get props => [profile];
}

final class ProfileUpdateProfileState extends ProfileState {
  const ProfileUpdateProfileState();

  @override
  List<Object?> get props => [];
}

final class ProfileUpdateImageState extends ProfileState {
  const ProfileUpdateImageState();

  @override
  List<Object?> get props => [];
}

final class ProfileFailureState extends ProfileState {
  final String code;

  const ProfileFailureState(this.code);

  @override
  List<Object?> get props => [code];
}
