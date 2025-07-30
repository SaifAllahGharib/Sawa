import 'package:failure_handler/failure_handler.dart';

abstract class StreamUseCase<Type, Params> {
  StreamResult<Type> call(Params params);
}
