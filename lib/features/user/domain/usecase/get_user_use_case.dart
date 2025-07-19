import 'package:failure_handler/src/models/app_failure.dart';
import 'package:intern_intelligence_social_media_application/core/shared/models/result.dart';
import 'package:intern_intelligence_social_media_application/core/usecases/usecase.dart';
import 'package:intern_intelligence_social_media_application/features/user/domain/entity/user_entity.dart';

import '../repository/user_repository.dart';

class GetUserUseCase implements UseCase<UserEntity?, String> {
  final IUserRepository _userRepository;

  GetUserUseCase(this._userRepository);

  @override
  Future<Result<AppFailure, UserEntity?>> call(String uId) async {
    return await _userRepository.getUser(uId);
  }
}
