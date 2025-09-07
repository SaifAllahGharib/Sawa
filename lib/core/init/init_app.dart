import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

import '../../firebase_options.dart';
import '../../shared/cubits/main/main_cubit.dart';
import '../di/dependency_injection.dart';
import 'set_portrait_orientation.dart';

Future<void> initializeApp() async {
  WidgetsFlutterBinding.ensureInitialized();
  setPortraitOrientation();

  await Future.wait([
    dotenv.load(),
    Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform),
  ]);

  await Future.wait([
    configureDependencies(),
    Supabase.initialize(
      url: dotenv.get('SUPABASE_URL'),
      anonKey: dotenv.get('SUPABASE_KEY'),
    ),
  ]);

  getIt<MainCubit>().checkAuthStatus();
}
