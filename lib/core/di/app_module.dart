import 'package:dio/dio.dart';
import 'package:failure_handler/failure_handler.dart';
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

  @lazySingleton
  Dio get dio => DioClint.create();

  @lazySingleton
  ErrorHandler get errorHandler => errorHandlerGetIt<ErrorHandler>();
}
