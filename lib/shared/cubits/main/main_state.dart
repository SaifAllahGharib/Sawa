import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';

import '../../../../features/auth/presentation/cubits/auth/auth_state.dart';
import '../../../features/user/presentation/cubit/user/user_state.dart';

class MainState extends Equatable {
  final ThemeMode themeMode;
  final Locale locale;
  final AuthState authState;
  final UserState userState;

  const MainState({
    required this.themeMode,
    required this.locale,
    required this.authState,
    required this.userState,
  });

  MainState copyWith({
    ThemeMode? themeMode,
    Locale? locale,
    AuthState? authState,
    UserState? userState,
  }) {
    return MainState(
      themeMode: themeMode ?? this.themeMode,
      locale: locale ?? this.locale,
      authState: authState ?? this.authState,
      userState: userState ?? this.userState,
    );
  }

  @override
  List<Object?> get props => [themeMode, locale, authState, userState];
}
