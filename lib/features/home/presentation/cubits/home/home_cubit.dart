import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intern_intelligence_social_media_application/features/user/domain/usecase/get_user_use_case.dart';

import 'home_state.dart';

class HomeCubit extends Cubit<HomeState> {
  final GetUserUseCase _getUserUseCase;

  HomeCubit(this._getUserUseCase) : super(const HomeInitState());

  void getUser(String uId) async {
    final result = await _getUserUseCase(uId);

    result.when(
      failure: (failure) => emit(HomeFailureState(failure.code)),
      success: (user) => emit(HomeGetUserSuccessState(user)),
    );
  }
}
