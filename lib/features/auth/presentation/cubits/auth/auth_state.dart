import '../../../../../core/utils/enums.dart';

class AuthState {
  final AuthStatus status;

  const AuthState._(this.status);

  factory AuthState.authenticated() =>
      const AuthState._(AuthStatus.authenticated);

  factory AuthState.unauthenticated() =>
      const AuthState._(AuthStatus.unauthenticated);

  factory AuthState.error() => const AuthState._(AuthStatus.error);
}
