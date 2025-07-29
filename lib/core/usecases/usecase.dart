import 'dart:async';

import 'package:failure_handler/failure_handler.dart';

abstract class UseCase<Type, Params> {
  FutureOr<Result<AppFailure, Type>> call(Params params);
}
