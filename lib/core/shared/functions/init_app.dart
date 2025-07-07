import 'package:flutter/material.dart';

import '../../di/dependency_injection.dart';
import '../helpers/shared_preferences_helper.dart';
import 'set_portrait_orientation.dart';

Future<void> initializeApp() async {
  WidgetsFlutterBinding.ensureInitialized();
  setPortraitOrientation();
  setupDependencyInjection();

  await getIt<SharedPreferencesHelper>().init();

  await getIt<SharedPreferencesHelper>().saveInitialLocaleIfNotSet(
    WidgetsBinding.instance.platformDispatcher.locale,
  );
}
