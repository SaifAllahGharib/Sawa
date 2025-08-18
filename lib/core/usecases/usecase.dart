import 'package:failure_handler/failure_handler.dart';

abstract class UseCase<T, P> {
  FutureResult<T> call([P? params]);
}
