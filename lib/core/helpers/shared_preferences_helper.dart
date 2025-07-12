import 'package:intern_intelligence_social_media_application/core/clients/firebase_client.dart';
import 'package:intern_intelligence_social_media_application/core/di/dependency_injection.dart';
import 'package:intern_intelligence_social_media_application/core/routing/app_route_name.dart';
import 'package:logger/logger.dart';
import 'package:shared_preferences/shared_preferences.dart';

class SharedPreferencesHelper {
  final Logger _logger;
  late final SharedPreferences _prefs;

  SharedPreferencesHelper(this._logger);

  Future<void> init() async {
    _prefs = await SharedPreferences.getInstance();
  }

  String? getLanguageCode() {
    return _prefs.getString('languageCode');
  }

  Future<void> setLanguageCode(String code) async {
    await _prefs.setString('languageCode', code);
  }

  String? getTheme() => _prefs.getString('themeMode');

  Future<void> setTheme(String theme) async {
    await _prefs.setString('themeMode', theme);
  }

  Future<void> storeUser(Map<String, dynamic> user) async {
    for (var entry in user.entries) {
      await storeString(entry.key, entry.value.toString());
    }
  }

  String? getIdUser() => getString('uid');

  String? getNameUser() => getString('name');

  String? getEmailUser() => getString('email');

  String getInitRoute() {
    if (getIt<FirebaseClient>().auth.currentUser != null) {
      return AppRouteName.home;
    }
    return '/';
  }

  Future<bool> storeString(String key, String value) async {
    return await _safeWrite(
      () => _prefs.setString(key, value),
      'Error storing string',
    );
  }

  String? getString(String key) => _prefs.getString(key);

  Future<bool> clearAllData() async {
    return await _safeWrite(() => _prefs.clear(), 'Error clearing data');
  }

  Future<bool> _safeWrite(
    Future<bool> Function() operation,
    String errorMessage,
  ) async {
    try {
      return await operation();
    } catch (e, stacktrace) {
      _logger.e(errorMessage, error: e, stackTrace: stacktrace);
      return false;
    }
  }
}
