import 'package:dio/dio.dart';
import 'package:failure_handler/failure_handler.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:image_picker/image_picker.dart';
import 'package:injectable/injectable.dart';
import 'package:logger/logger.dart';

import '../clients/dio_client.dart';
import '../helpers/shared_preferences_helper.dart';

@module
abstract class AppModule {
  @lazySingleton
  Logger get logger => Logger();

  @preResolve
  @LazySingleton()
  Future<SharedPreferencesHelper> providePrefsHelper(Logger logger) async {
    final helper = SharedPreferencesHelper(logger);
    await helper.init();
    return helper;
  }

  @lazySingleton
  ImagePicker get imagePicker => ImagePicker();

  @singleton
  FirebaseAuth get firebaseAuth => FirebaseAuth.instance;

  @singleton
  FirebaseDatabase get firebaseDatabase => FirebaseDatabase.instance;

  @lazySingleton
  Dio get dio => DioClint.create();

  @lazySingleton
  DioErrorMapper get dioErrorMapper => const DioErrorMapper();

  @lazySingleton
  FirebaseErrorMapper get firebaseErrorMapper => const FirebaseErrorMapper();

  @lazySingleton
  SupabaseErrorMapper get supabaseErrorMapper => const SupabaseErrorMapper();

  @lazySingleton
  DefaultErrorMapper get defaultErrorMapper => const DefaultErrorMapper();

  @lazySingleton
  ErrorLogger get errorLogger => const ErrorLogger();

  @lazySingleton
  ErrorHandler get errorHandler => ErrorHandler([
    dioErrorMapper,
    firebaseErrorMapper,
    supabaseErrorMapper,
    defaultErrorMapper,
  ], errorLogger);
}
