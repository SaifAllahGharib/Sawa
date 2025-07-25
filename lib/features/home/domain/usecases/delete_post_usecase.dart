import 'package:failure_handler/src/models/app_failure.dart';
import 'package:intern_intelligence_social_media_application/core/shared/models/result.dart';
import 'package:intern_intelligence_social_media_application/core/usecases/usecase.dart';
import 'package:intern_intelligence_social_media_application/features/home/domain/repositories/home_repository.dart';

class DeletePostUseCase implements UseCase<void, List<String>> {
  final IHomeRepository _iHomeRepository;

  DeletePostUseCase(this._iHomeRepository);

  @override
  Future<Result<AppFailure, void>> call(List<String> params) async {
    return await _iHomeRepository.deletePost(params[0], params[1]);
  }
}
