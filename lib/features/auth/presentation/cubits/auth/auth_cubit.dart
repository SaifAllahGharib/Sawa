import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:injectable/injectable.dart';
import 'package:intern_intelligence_social_media_application/core/clients/firebase_client.dart';
import 'package:intern_intelligence_social_media_application/core/usecases/no_params.dart';
import 'package:intern_intelligence_social_media_application/features/auth/domain/usecases/logout_usecase.dart';

import 'auth_state.dart';

@singleton
class AuthCubit extends Cubit<AuthState> {
  final FirebaseClient _firebaseClient;
  final LogoutUseCase _logoutUseCase;

  AuthCubit(this._firebaseClient, this._logoutUseCase)
    : super(AuthState.unauthenticated());

  void checkAuthStatus() {
    final user = _firebaseClient.auth.currentUser;
    if (user != null) {
      emit(AuthState.authenticated());
    } else {
      emit(AuthState.unauthenticated());
    }
  }

  void logout() async {
    final result = await _logoutUseCase(const NoParams());

    result.when(
      failure: (failure) => emit(AuthState.error()),
      success: (success) => emit(AuthState.unauthenticated()),
    );
  }
}
