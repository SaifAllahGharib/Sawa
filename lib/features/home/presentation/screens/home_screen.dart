import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intern_intelligence_social_media_application/core/clients/firebase_client.dart';
import 'package:intern_intelligence_social_media_application/core/di/dependency_injection.dart';
import 'package:intern_intelligence_social_media_application/core/widgets/app_remove_focus.dart';
import 'package:intern_intelligence_social_media_application/core/widgets/app_scaffold.dart';
import 'package:intern_intelligence_social_media_application/features/user/data/model/user_model.dart';
import 'package:intern_intelligence_social_media_application/features/user/presentation/cubit/user/user_state.dart';

import '../../../../core/helpers/shared_preferences_helper.dart';
import '../../../user/presentation/cubit/user/user_cubit.dart';
import '../widgets/bottom_section_home.dart';
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
    final userName = _sharedPreferencesHelper.getUserId();
    final userEmail = _sharedPreferencesHelper.getUserId();

    return userId != null &&
        userName != null &&
        userEmail != null &&
        userId.isNotEmpty &&
        userName.isNotEmpty &&
        userEmail.isNotEmpty;
  }

  void _getUser() {
    if (!_userExistsInLocalStorage) {
      context.read<UserCubit>().getUser(
        getIt<FirebaseClient>().auth.currentUser!.uid,
      );
    }
  }

  void _handleState(UserState state) {
    if (state is UserSuccessState) {
      getIt<SharedPreferencesHelper>().storeUser(
        UserModel.fromEntity(state.user).toJson(),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return BlocListener<UserCubit, UserState>(
      listener: (context, state) => _handleState(state),
      child: const AppScaffold(
        child: AppRemoveFocus(
          child: CustomScrollView(
            slivers: [HomeAppBar(), TopSectionHome(), BottomSectionHome()],
          ),
        ),
      ),
    );
  }
}
