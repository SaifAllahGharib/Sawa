import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:injectable/injectable.dart';
import 'package:sawa/features/profile/domain/usecases/update_profile_image_usecase.dart';

import '../../../../../core/utils/enums.dart';
import '../../../../../shared/models/media_model.dart';
import '../../../domain/usecases/get_profile_usecase.dart';
import '../../../domain/usecases/profile_delete_post_usecase.dart';
import '../../../domain/usecases/update_profile_bio_usecase.dart';
import '../../../domain/usecases/update_profile_name_usecase.dart';
import 'profile_state.dart';

@singleton
class ProfileCubit extends Cubit<ProfileState> {
  final UpdateProfileNameUseCase _updateProfileNameUseCase;
  final GetProfileUseCase _getProfileUseCase;
  final ProfileDeletePostUseCase _profileDeletePostUseCase;
  final UpdateProfileBioUseCase _updateProfileBioUseCase;
  final UpdateProfileImageUseCase _updateProfileImageUseCase;

  ProfileCubit(
    this._updateProfileNameUseCase,
    this._getProfileUseCase,
    this._profileDeletePostUseCase,
    this._updateProfileBioUseCase,
    this._updateProfileImageUseCase,
  ) : super(const ProfileState());

  void getProfile(String uId) async {
    emit(
      state.copyWith(
        isLoading: true,
        errorCode: null,
        updateType: ProfileUpdateType.none,
      ),
    );

    final result = await _getProfileUseCase(uId);

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

    final result = await _updateProfileNameUseCase(newName);

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

    final result = await _updateProfileBioUseCase(newBio);

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

    final result = await _profileDeletePostUseCase(postId);

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

    final result = await _updateProfileImageUseCase(mediaModel);

    result.when(
      failure: (failure) =>
          emit(state.copyWith(isLoading: false, errorCode: failure.code)),
      success: (_) => emit(
        state.copyWith(isLoading: false, updateType: ProfileUpdateType.image),
      ),
    );
  }
}
