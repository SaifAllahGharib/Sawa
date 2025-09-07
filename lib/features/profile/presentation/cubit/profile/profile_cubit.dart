import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:injectable/injectable.dart';
import 'package:sawa/features/profile/domain/repository/profile_repository.dart';

import '../../../../../core/enums/profile_update_type.dart';
import '../../../../post/data/models/media_model.dart';
import 'profile_state.dart';

@singleton
class ProfileCubit extends Cubit<ProfileState> {
  final IProfileRepository _iProfileRepository;

  ProfileCubit(this._iProfileRepository) : super(const ProfileState());

  void getProfile(String uId) async {
    emit(
      state.copyWith(
        isLoading: true,
        errorCode: null,
        updateType: ProfileUpdateType.none,
      ),
    );

    final result = await _iProfileRepository.getProfile(uId: uId);

    result.when(
      failure: (failure) =>
          emit(state.copyWith(isLoading: false, errorCode: failure.code)),
      success: (profile) =>
          emit(state.copyWith(isLoading: false, profile: profile)),
    );
  }

  void changeName(String newName) async {
    emit(
      state.copyWith(
        isLoading: true,
        updateType: ProfileUpdateType.name,
        errorCode: null,
      ),
    );

    final result = await _iProfileRepository.updateProfileName(
      newName: newName,
    );

    result.when(
      failure: (failure) {
        emit(
          state.copyWith(
            isLoading: false,
            errorCode: failure.code,
            updateType: ProfileUpdateType.name,
          ),
        );
      },
      success: (_) {
        emit(
          state.copyWith(
            isLoading: false,
            errorCode: null,
            updateType: ProfileUpdateType.name,
          ),
        );
      },
    );
  }

  void changeBio(String newBio) async {
    emit(
      state.copyWith(
        isLoading: true,
        updateType: ProfileUpdateType.bio,
        errorCode: null,
      ),
    );

    final result = await _iProfileRepository.updateProfileBio(newBio: newBio);

    result.when(
      failure: (failure) =>
          emit(state.copyWith(isLoading: false, errorCode: failure.code)),
      success: (_) => emit(
        state.copyWith(isLoading: false, updateType: ProfileUpdateType.bio),
      ),
    );
  }

  void deletePost(String uId, String postId) async {
    emit(
      state.copyWith(isLoading: true, updateType: ProfileUpdateType.deletePost),
    );

    final result = await _iProfileRepository.deletePost(postId: postId);

    result.when(
      failure: (failure) =>
          emit(state.copyWith(isLoading: false, errorCode: failure.code)),
      success: (success) {
        emit(
          state.copyWith(
            isLoading: false,
            updateType: ProfileUpdateType.deletePost,
          ),
        );
        getProfile(uId);
      },
    );
  }

  void updateProfileImage(MediaModel mediaModel) async {
    emit(
      state.copyWith(
        isLoading: true,
        updateType: ProfileUpdateType.image,
        errorCode: null,
      ),
    );

    final result = await _iProfileRepository.updateProfileImage(
      mediaModel: mediaModel,
    );

    result.when(
      failure: (failure) =>
          emit(state.copyWith(isLoading: false, errorCode: failure.code)),
      success: (_) => emit(
        state.copyWith(isLoading: false, updateType: ProfileUpdateType.image),
      ),
    );
  }
}
