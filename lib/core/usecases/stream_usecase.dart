import 'package:failure_handler/failure_handler.dart';

abstract class StreamUseCase<T, P> {
  StreamResult<T> call(P params);
}
