import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:injectable/injectable.dart';

import '../../core/helpers/shared_preferences_helper.dart';

@singleton
class LocaleCubit extends Cubit<Locale> {
  final SharedPreferencesHelper _prefs;

  LocaleCubit(this._prefs) : super(Locale(_prefs.getLanguageCode()));

  void setLocale(String languageCode) async {
    if (languageCode != state.languageCode) {
      await _prefs.setLanguageCode(languageCode);
      emit(Locale(languageCode));
    }
  }
}
