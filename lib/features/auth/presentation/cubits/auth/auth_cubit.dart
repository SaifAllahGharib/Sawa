import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:injectable/injectable.dart';
import 'package:sawa/core/clients/firebase_client.dart';
import 'package:sawa/features/auth/domain/repositories/auth_repository.dart';

import 'auth_state.dart';

@singleton
class AuthCubit extends Cubit<AuthState> {
  final FirebaseClient _firebaseClient;
  final IAuthRepository _iAuthRepository;

  AuthCubit(this._firebaseClient, this._iAuthRepository)
    : super(AuthState.unauthenticated());

  void checkAuthStatus() {
    final user = _firebaseClient.auth.currentUser;
    if (user != null && user.emailVerified) {
      emit(AuthState.authenticated());
    } else {
      emit(AuthState.unauthenticated());
    }
  }

  void logout() async {
    final result = await _iAuthRepository.logout();

    result.when(
      failure: (failure) => emit(AuthState.error()),
      success: (success) => emit(AuthState.unauthenticated()),
    );
  }
}
