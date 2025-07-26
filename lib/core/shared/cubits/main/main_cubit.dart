import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../features/auth/presentation/cubits/auth/auth_cubit.dart';
import '../../../clients/firebase_client.dart';
import '../../../user/presentation/cubit/user/user_cubit.dart';
import '../locale_cubit.dart';
import '../theme_cubit.dart';
import 'main_state.dart';

class MainCubit extends Cubit<MainState> {
  final ThemeCubit _themeCubit;
  final LocaleCubit _localeCubit;
  final AuthCubit _authCubit;
  final UserCubit _userCubit;
  final FirebaseClient _firebaseClient;

  late final StreamSubscription _themeSub;
  late final StreamSubscription _localeSub;
  late final StreamSubscription _authSub;
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
    _authSub = _authCubit.stream.listen(
      (auth) => emit(state.copyWith(authState: auth)),
    );
    _userSub = _userCubit.stream.listen(
      (user) => emit(state.copyWith(userState: user)),
    );
  }

  void checkAuthStatus() => _authCubit.checkAuthStatus();

  void changeTheme(ThemeMode themeMode) => _themeCubit.toggle(themeMode);

  void changeLocale(String languageCode) =>
      _localeCubit.setLocale(languageCode);

  void getUser() => _userCubit.getUser(_firebaseClient.auth.currentUser!.uid);

  @override
  Future<void> close() {
    _themeSub.cancel();
    _localeSub.cancel();
    _authSub.cancel();
    _userSub.cancel();
    return super.close();
  }
}
