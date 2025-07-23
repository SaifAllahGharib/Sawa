import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:flutter/material.dart';
import 'package:intern_intelligence_social_media_application/core/clients/firebase_client.dart';
import 'package:intern_intelligence_social_media_application/core/shared/cubits/locale_cubit.dart';
import 'package:intern_intelligence_social_media_application/core/shared/cubits/theme_cubit.dart';
import 'package:intern_intelligence_social_media_application/features/auth/presentation/cubits/auth/auth_cubit.dart';
import 'package:intern_intelligence_social_media_application/features/user/presentation/cubit/user/user_cubit.dart';

import 'main_state.dart';

class MainCubit extends Cubit<MainState> {
  final ThemeCubit _themeCubit;
  final LocaleCubit _localeCubit;
  final AuthCubit _authCubit;
  final UserCubit _userCubit;
  final FirebaseClient _firebaseClient;

  late final StreamSubscription _themeSub;
  late final StreamSubscription _localeSub;
  late final StreamSubscription _userSub;

  MainCubit(
    this._themeCubit,
    this._localeCubit,
    this._authCubit,
    this._userCubit,
    this._firebaseClient,
  ) : super(
        MainState(
          themeMode: _themeCubit.state,
          locale: _localeCubit.state,
          authState: _authCubit.state,
          userState: _userCubit.state,
        ),
      ) {
    _themeSub = _themeCubit.stream.listen(
      (theme) => emit(state.copyWith(themeMode: theme)),
    );
    _localeSub = _localeCubit.stream.listen(
      (locale) => emit(state.copyWith(locale: locale)),
    );
    _userSub = _userCubit.stream.listen(
      (user) => emit(state.copyWith(userState: user)),
    );

    Future.microtask(() => _authCubit.checkAuthStatus());
  }

  void changeTheme(ThemeMode themeMode) => _themeCubit.toggle(themeMode);

  void changeLocale(String languageCode) =>
      _localeCubit.setLocale(languageCode);

  void getUser() => _userCubit.getUser(_firebaseClient.auth.currentUser!.uid);

  @override
  Future<void> close() {
    _themeSub.cancel();
    _localeSub.cancel();
    _userSub.cancel();
    return super.close();
  }
}
