import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intern_intelligence_social_media_application/features/user/domain/entity/user_entity.dart';

import '../../../../core/utils/app_snack_bar.dart';
import '../../../../core/widgets/app_scaffold.dart';
import '../../../../core/widgets/posts_loading.dart';
import '../../../../shared/cubits/main/main_cubit.dart';
import '../../../../shared/cubits/main/main_state.dart';
import '../../../user/presentation/cubit/user/user_state.dart';
import '../../domain/entities/post_entity.dart';
import '../cubits/home/home_cubit.dart';
import '../cubits/home/home_state.dart';
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
  List<PostEntity> _posts = [];
  UserEntity? _user;

  @override
  bool get wantKeepAlive => true;

  @override
  void initState() {
    _postController = TextEditingController();

    _getUser();
    _getDefaultPosts();
    super.initState();
  }

  @override
  dispose() {
    _postController.dispose();
    super.dispose();
  }

  void _getUser() {
    context.read<MainCubit>().getUser();
  }

  void _getDefaultPosts() {
    context.read<HomeCubit>().getDefaultPosts();
  }

  void _handleState(UserState state) {
    if (state is UserSuccessState) {
      _user = state.user;
    } else if (state is UserFailureState) {
      AppSnackBar.showError(context, state.code);
    }
  }

  @override
  Widget build(BuildContext context) {
    super.build(context);
    return BlocConsumer<MainCubit, MainState>(
      listener: (context, state) => _handleState(state.userState),
      builder: (context, state) {
        return AppScaffold(
          child: RefreshIndicator(
            onRefresh: () async => _getDefaultPosts(),
            child: CustomScrollView(
              slivers: [
                const HomeAppBar(),
                TopSectionHome(user: _user),
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
        );
      },
    );
  }
}
