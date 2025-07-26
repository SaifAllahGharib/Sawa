import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intern_intelligence_social_media_application/core/utils/app_snack_bar.dart';

import '../../../../core/di/dependency_injection.dart';
import '../../../../core/helpers/shared_preferences_helper.dart';
import '../../../../core/shared/cubits/main/main_cubit.dart';
import '../../../../core/shared/cubits/main/main_state.dart';
import '../../../../core/user/data/model/user_model.dart';
import '../../../../core/user/presentation/cubit/user/user_state.dart';
import '../../../../core/widgets/app_remove_focus.dart';
import '../../../../core/widgets/app_scaffold.dart';
import '../widgets/home_app_bar.dart';
import '../widgets/top_section_home.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  late final TextEditingController _postController;
  late final SharedPreferencesHelper _sharedPreferencesHelper;

  @override
  void initState() {
    _postController = TextEditingController();
    _sharedPreferencesHelper = getIt<SharedPreferencesHelper>();

    _getUser();
    super.initState();
  }

  @override
  dispose() {
    _postController.dispose();
    super.dispose();
  }

  bool get _userExistsInLocalStorage {
    final userId = _sharedPreferencesHelper.getUserId();
    final userName = _sharedPreferencesHelper.getUserName();
    final userEmail = _sharedPreferencesHelper.getUserEmail();

    return userId != null &&
        userName != null &&
        userEmail != null &&
        userId.isNotEmpty &&
        userName.isNotEmpty &&
        userEmail.isNotEmpty;
  }

  void _getUser() {
    if (!_userExistsInLocalStorage) {
      context.read<MainCubit>().getUser();
    }
  }

  void _handleState(UserState state) {
    if (state is UserSuccessState) {
      getIt<SharedPreferencesHelper>().storeUser(
        UserModel.fromEntity(state.user).toJson(),
      );
    } else if (state is UserFailureState) {
      AppSnackBar.showError(context, state.code);
    }
  }

  @override
  Widget build(BuildContext context) {
    return BlocListener<MainCubit, MainState>(
      listener: (context, state) => _handleState(state.userState),
      child: const AppScaffold(
        child: AppRemoveFocus(
          child: CustomScrollView(
            slivers: [
              HomeAppBar(), TopSectionHome(),
              // BottomSectionHome()
            ],
          ),
        ),
      ),
    );
  }
}
