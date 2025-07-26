import 'dart:async';

import 'package:failure_handler/src/models/app_failure.dart';

import '../../../../core/shared/models/result.dart';
import '../../../../core/usecases/usecase.dart';
import '../repository/profile_repository.dart';

class UpdateProfileNameUseCase extends UseCase<void, String> {
  final IProfileRepository _iProfileRepository;

  UpdateProfileNameUseCase(this._iProfileRepository);

  @override
  FutureOr<Result<AppFailure, void>> call(String newName) async {
    return await _iProfileRepository.updateProfileName(newName);
  }
}
