import 'dart:async';

import 'package:failure_handler/failure_handler.dart';

abstract class StreamUseCase<Type, Params> {
  Stream<Result<AppFailure, Type>> call(Params params);
}
