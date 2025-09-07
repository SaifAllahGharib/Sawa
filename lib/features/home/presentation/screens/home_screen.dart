import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../core/utils/app_snack_bar.dart';
import '../../../../core/widgets/app_scaffold.dart';
import '../../../../shared/cubits/main/main_cubit.dart';
import '../../../../shared/cubits/main/main_state.dart';
import '../../../post/domain/entities/post_entity.dart';
import '../../../post/presentation/cubits/post/post_cubit.dart';
import '../../../post/presentation/cubits/post/post_state.dart';
import '../../../post/presentation/widgets/posts_loading.dart';
import '../../../user/presentation/cubit/user/user_state.dart';
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
    context.read<PostCubit>().getDefaultPosts();
  }

  void _handleState(UserState state) {
    if (state is UserFailureState) {
      AppSnackBar.showError(context, state.code);
    }
  }

  void _handlePostsState(PostState state) {
    if (state is PostGetDefaultPostsState) {
      _posts = state.posts;
    } else if (state is PostFailureState) {
      AppSnackBar.showError(context, state.code);
    } else if (state is PostCreatePostSuccessState) {
      _getDefaultPosts();
    } else if (state is PostDeletePostSuccessState) {
      _getDefaultPosts();
    }
  }

  @override
  Widget build(BuildContext context) {
    super.build(context);
    return AppScaffold(
      child: RefreshIndicator(
        onRefresh: () async => _getDefaultPosts(),
        child: CustomScrollView(
          physics: const AlwaysScrollableScrollPhysics(),
          slivers: [
            const HomeAppBar(),
            BlocConsumer<MainCubit, MainState>(
              listener: (context, state) => _handleState(state.userState),
              builder: (context, state) {
                final user = context.watch<MainCubit>().user;
                return TopSectionHome(user: user);
              },
            ),
            BlocConsumer<PostCubit, PostState>(
              listener: (context, state) => _handlePostsState(state),
              builder: (context, state) {
                if (state is PostLoadingState) {
                  return const PostsLoading();
                }

                return BottomSectionHome(posts: _posts);
              },
            ),
          ],
        ),
      ),
    );
  }
}
