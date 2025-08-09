import 'package:equatable/equatable.dart';

import '../../../domain/entity/user_entity.dart';

sealed class UserState extends Equatable {
  const UserState();

  @override
  List<Object?> get props => [];
}

final class UserInitialState extends UserState {
  const UserInitialState();

  @override
  List<Object?> get props => [];
}

final class UserLoadingState extends UserState {
  const UserLoadingState();

  @override
  List<Object?> get props => [];
}

final class UserSuccessState extends UserState {
  final UserEntity user;

  const UserSuccessState(this.user);

  @override
  List<Object?> get props => [user];
}

final class UserFailureState extends UserState {
  final String code;

  const UserFailureState(this.code);

  @override
  List<Object?> get props => [code];
}
