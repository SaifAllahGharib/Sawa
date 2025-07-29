import 'package:failure_handler/failure_handler.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

import '../../firebase_options.dart';
import '../di/dependency_injection.dart';
import '../helpers/shared_preferences_helper.dart';
import 'set_portrait_orientation.dart';

Future<void> initializeApp() async {
  WidgetsFlutterBinding.ensureInitialized();
  setPortraitOrientation();
  setupDependencyInjection();
  registerFailureHandlerDependencies();

  await dotenv.load();

  await Future.wait([
    Supabase.initialize(
      url: dotenv.get('SUPABASE_URL'),
      anonKey: dotenv.get('SUPABASE_KEY'),
    ),
    Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform),
    getIt<SharedPreferencesHelper>().init(),
  ]);
}
