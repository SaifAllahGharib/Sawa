import 'package:failure_handler/failure_handler.dart';

abstract class UseCase<Type, Params> {
  FutureResult<Type> call([Params? params]);
}
