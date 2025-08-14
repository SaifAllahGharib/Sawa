import 'package:failure_handler/failure_handler.dart';
import 'package:injectable/injectable.dart';
import 'package:sawa/core/usecases/usecase.dart';
import 'package:sawa/features/home/data/models/create_post_model.dart';
import 'package:sawa/features/home/domain/repositories/home_repository.dart';

@injectable
class CreatePostUseCase implements UseCase<void, CreatePostModel> {
  final IHomeRepository _iHomeRepository;

  CreatePostUseCase(this._iHomeRepository);

  @override
  FutureResult<void> call([CreatePostModel? createPostModel]) async {
    return await _iHomeRepository.createPost(createPostModel: createPostModel!);
  }
}
