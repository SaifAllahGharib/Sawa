import 'package:equatable/equatable.dart';

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

final class HomeFailureState extends HomeState {
  final String code;

  const HomeFailureState(this.code);

  @override
  List<Object?> get props => [code];
}
