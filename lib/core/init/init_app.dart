import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

import '../../features/auth/presentation/cubits/auth/auth_cubit.dart';
import '../../firebase_options.dart';
import '../di/dependency_injection.dart';
import '../helpers/shared_preferences_helper.dart';
import 'set_portrait_orientation.dart';

Future<void> initializeApp() async {
  WidgetsFlutterBinding.ensureInitialized();
  setPortraitOrientation();
  setupDependencyInjection();

  await Future.wait([
    Supabase.initialize(
      url: 'https://llxfwyxarmesaregkaby.supabase.co',
      anonKey:
          'eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJpc3MiOiJzdXBhYmFzZSIsInJlZiI6ImxseGZ3eXhhcm1lc2FyZWdrYWJ5Iiwicm9sZSI6ImFub24iLCJpYXQiOjE3NTIwNzA5NDAsImV4cCI6MjA2NzY0Njk0MH0.qccTMS0FisDLGZm4AqSdGee-H5jriqUOrnjoojOk5pI',
    ),
    Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform),
    dotenv.load(),
    getIt<SharedPreferencesHelper>().init(),
  ]);

  getIt<AuthCubit>().checkAuthStatus();
}
