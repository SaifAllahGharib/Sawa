import 'package:failure_handler/failure_handler.dart';
import 'package:injectable/injectable.dart';
import 'package:intern_intelligence_social_media_application/core/usecases/usecase.dart';
import 'package:intern_intelligence_social_media_application/features/home/domain/repositories/home_repository.dart';

@injectable
class DeletePostUseCase implements UseCase<void, List<String>> {
  final IHomeRepository _iHomeRepository;

  DeletePostUseCase(this._iHomeRepository);

  @override
  FutureResult<void> call(List<String> params) async {
    return await _iHomeRepository.deletePost(params[0], params[1]);
  }
}
