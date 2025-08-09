import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intern_intelligence_social_media_application/core/utils/app_snack_bar.dart';
import 'package:intern_intelligence_social_media_application/core/widgets/posts_loading.dart';
import 'package:intern_intelligence_social_media_application/features/home/domain/entities/post_entity.dart';
import 'package:intern_intelligence_social_media_application/features/home/presentation/cubits/home/home_cubit.dart';
import 'package:intern_intelligence_social_media_application/features/home/presentation/cubits/home/home_state.dart';

import '../../../../core/di/dependency_injection.dart';
import '../../../../core/helpers/shared_preferences_helper.dart';
import '../../../../core/shared/cubits/main/main_cubit.dart';
import '../../../../core/shared/cubits/main/main_state.dart';
import '../../../../core/user/data/model/user_model.dart';
import '../../../../core/user/presentation/cubit/user/user_state.dart';
import '../../../../core/widgets/app_scaffold.dart';
import '../widgets/bottom_section_home.dart';
import '../widgets/home_app_bar.dart';
import '../widgets/top_section_home.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen>
    with AutomaticKeepAliveClientMixin {
  late final TextEditingController _postController;
  late final SharedPreferencesHelper _sharedPreferencesHelper;
  List<PostEntity> _posts = [];

  @override
  bool get wantKeepAlive => true;

  @override
  void initState() {
    _postController = TextEditingController();
    _sharedPreferencesHelper = getIt<SharedPreferencesHelper>();

    _getDefaultPosts();
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

  void _getDefaultPosts() {
    context.read<HomeCubit>().getDefaultPosts();
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
    super.build(context);
    return BlocListener<MainCubit, MainState>(
      listener: (context, state) => _handleState(state.userState),
      child: AppScaffold(
        child: RefreshIndicator(
          onRefresh: () async => _getDefaultPosts(),
          child: CustomScrollView(
            slivers: [
              const HomeAppBar(),
              const TopSectionHome(),
              BlocConsumer<HomeCubit, HomeState>(
                listener: (context, state) {
                  if (state is HomeGetDefaultPostsState) {
                    _posts = state.posts;
                  } else if (state is HomeFailureState) {
                    AppSnackBar.showError(context, state.code);
                  }
                },
                builder: (context, state) {
                  if (state is HomeLoadingState) {
                    return const PostsLoading();
                  }

                  return BottomSectionHome(posts: _posts);
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}
