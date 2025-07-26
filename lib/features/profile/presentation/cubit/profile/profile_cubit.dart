import 'package:bloc/bloc.dart';
import 'package:intern_intelligence_social_media_application/core/usecases/no_params.dart';

import '../../../domain/usecases/get_profile_usecase.dart';
import '../../../domain/usecases/update_profile_name_usecase.dart';
import 'profile_state.dart';

class ProfileCubit extends Cubit<ProfileState> {
  final UpdateProfileNameUseCase _updateProfileNameUseCase;
  final GetProfileUseCase _getProfileUseCase;

  ProfileCubit(this._updateProfileNameUseCase, this._getProfileUseCase)
    : super(const ProfileInitState());

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
      success: (success) => emit(const ProfileUpdateNameState()),
    );
  }
}
