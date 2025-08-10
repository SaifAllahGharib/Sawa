import 'package:failure_handler/failure_handler.dart';
import 'package:injectable/injectable.dart';
import 'package:intern_intelligence_social_media_application/features/home/domain/repositories/home_repository.dart';

import '../../../../core/usecases/usecase.dart';

@injectable
class AddReactionUseCase implements UseCase<void, List> {
  final IHomeRepository _iHomeRepository;

  AddReactionUseCase(this._iHomeRepository);

  @override
  FutureResult<void> call(List<dynamic> params) async {
    return await _iHomeRepository.addReaction(
      postId: params[0],
      type: params[1],
    );
  }
}
