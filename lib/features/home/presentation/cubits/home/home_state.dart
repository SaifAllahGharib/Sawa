import 'package:equatable/equatable.dart';
import 'package:intern_intelligence_social_media_application/features/user/domain/entity/user_entity.dart';

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

final class HomeGetUserSuccessState extends HomeState {
  final UserEntity? user;

  const HomeGetUserSuccessState(this.user);

  @override
  List<Object?> get props => [user];
}

final class HomeFailureState extends HomeState {
  final String code;

  const HomeFailureState(this.code);

  @override
  List<Object?> get props => [code];
}
