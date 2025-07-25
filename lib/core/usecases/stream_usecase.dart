import 'dart:async';

import 'package:failure_handler/failure_handler.dart';
import 'package:intern_intelligence_social_media_application/core/shared/models/result.dart';

abstract class StreamUseCase<Type, Params> {
  Stream<Result<AppFailure, Type>> call(Params params);
}
