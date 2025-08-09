import 'package:bloc/bloc.dart';
import 'package:injectable/injectable.dart';
import 'package:intern_intelligence_social_media_application/core/usecases/no_params.dart';
import 'package:intern_intelligence_social_media_application/features/home/domain/entities/media_entity.dart';
import 'package:intern_intelligence_social_media_application/features/profile/domain/usecases/upload_profile_image_usecase.dart';

import '../../../domain/usecases/get_profile_usecase.dart';
import '../../../domain/usecases/profile_delete_post_usecase.dart';
import '../../../domain/usecases/update_profile_name_usecase.dart';
import 'profile_state.dart';

@injectable
class ProfileCubit extends Cubit<ProfileState> {
  final UpdateProfileNameUseCase _updateProfileNameUseCase;
  final GetProfileUseCase _getProfileUseCase;
  final UploadProfileImageUseCase _uploadProfileImageUseCase;
  final ProfileDeletePostUseCase _profileDeletePostUseCase;

  ProfileCubit(
    this._updateProfileNameUseCase,
    this._getProfileUseCase,
    this._uploadProfileImageUseCase,
    this._profileDeletePostUseCase,
  ) : super(const ProfileInitState());

  void getProfile() async {
    emit(const ProfileLoadingState());

    final result = await _getProfileUseCase(const NoParams());

    result.when(
      failure: (failure) => emit(ProfileFailureState(failure.code)),
      success: (posts) => emit(ProfileGetState(posts)),
    );
  }

  void changeName(String newName) async {
    emit(const ProfileLoadingUpdateProfileState());
    final result = await _updateProfileNameUseCase(newName);

    result.when(
      failure: (failure) => emit(ProfileFailureState(failure.code)),
      success: (_) => emit(const ProfileUpdateProfileState()),
    );
  }

  void uploadProfileImage(MediaEntity media) async {
    emit(const ProfileLoadingUpdateProfileState());
    final result = await _uploadProfileImageUseCase(media);

    result.when(
      failure: (failure) => emit(ProfileFailureState(failure.code)),
      success: (_) => emit(const ProfileUpdateProfileState()),
    );
  }

  void deletePost(String postId) async {
    emit(const ProfileLoadingActionPostState());

    final result = await _profileDeletePostUseCase(postId);

    result.when(
      failure: (failure) => emit(ProfileFailureState(failure.code)),
      success: (success) {
        emit(const ProfileDeletePostState());
        getProfile();
      },
    );
  }
}
