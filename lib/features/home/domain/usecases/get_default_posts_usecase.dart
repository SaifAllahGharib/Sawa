import 'package:failure_handler/failure_handler.dart';
import 'package:injectable/injectable.dart';
import 'package:sawa/core/usecases/no_params.dart';
import 'package:sawa/core/usecases/usecase.dart';
import 'package:sawa/features/home/domain/entities/post_entity.dart';
import 'package:sawa/features/home/domain/repositories/home_repository.dart';

@injectable
class GetDefaultPostsUseCase implements UseCase<List<PostEntity>, NoParams> {
  final IHomeRepository _iHomeRepository;

  GetDefaultPostsUseCase(this._iHomeRepository);

  @override
  FutureResult<List<PostEntity>> call([NoParams? params]) async {
    return await _iHomeRepository.getDefaultPosts();
  }
}
