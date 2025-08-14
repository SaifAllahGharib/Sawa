import 'package:failure_handler/failure_handler.dart';
import 'package:injectable/injectable.dart';

import '../../../../core/usecases/usecase.dart';
import '../entity/profile_entity.dart';
import '../repository/profile_repository.dart';

@injectable
class GetProfileUseCase implements UseCase<ProfileEntity, String> {
  final IProfileRepository _iProfileRepository;

  GetProfileUseCase(this._iProfileRepository);

  @override
  FutureResult<ProfileEntity> call([String? uId]) async {
    return await _iProfileRepository.getProfile(uId: uId!);
  }
}
