import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';

import '../../firebase_options.dart';
import '../di/dependency_injection.dart';
import '../helpers/shared_preferences_helper.dart';
import 'set_portrait_orientation.dart';

Future<void> initializeApp() async {
  WidgetsFlutterBinding.ensureInitialized();
  setPortraitOrientation();
  setupDependencyInjection();

  await Future.wait([
    Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform),
    dotenv.load(),
    getIt<SharedPreferencesHelper>().init(),
  ]);
}
