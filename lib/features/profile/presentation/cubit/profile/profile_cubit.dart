import 'package:bloc/bloc.dart';
import 'package:intern_intelligence_social_media_application/core/usecases/get_user_posts_usecase.dart';

import 'profile_state.dart';

class ProfileCubit extends Cubit<ProfileState> {
  final GetUserPostsUseCase _getUserPostsUseCase;

  ProfileCubit(this._getUserPostsUseCase) : super(const ProfileInitState());

  Stream<void> getUserPosts(String uId) async* {
    emit(const ProfileLoadingState());

    await for (final result in _getUserPostsUseCase(uId)) {
      result.when(
        failure: (failure) => emit(ProfileFailureState(failure.code)),
        success: (posts) => emit(ProfileGetPostsState(posts)),
      );
    }
  }
}
