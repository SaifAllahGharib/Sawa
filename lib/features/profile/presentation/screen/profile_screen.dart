import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../core/extensions/build_context_extensions.dart';
import '../../../../core/utils/app_snack_bar.dart';
import '../../../../core/widgets/app_scaffold.dart';
import '../../../../core/widgets/posts_loading.dart';
import '../../../../shared/cubits/main/main_cubit.dart';
import '../../../user/domain/entity/user_entity.dart';
import '../../../user/presentation/cubit/user/user_state.dart';
import '../../domain/entity/profile_entity.dart';
import '../cubit/profile/profile_cubit.dart';
import '../cubit/profile/profile_state.dart';
import '../widgets/app_bar_profile.dart';
import '../widgets/bottom_section_profile.dart';
import '../widgets/middle_section_profile.dart';

class ProfileScreen extends StatefulWidget {
  final String uId;

  const ProfileScreen({super.key, required this.uId});

  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen>
    with AutomaticKeepAliveClientMixin {
  UserEntity? user;
  ProfileEntity? _profile;

  @override
  bool get wantKeepAlive => true;

  @override
  void initState() {
    _getProfile();
    super.initState();
  }

  void _handleState(BuildContext context, ProfileState state) {
    if (state is ProfileGetState) {
      _profile = state.profile;
    } else if (state is ProfileLoadingActionPostState) {
      context.navigator.pop();
    } else if (state is ProfileDeletePostState) {
      AppSnackBar.showSuccess(context, context.tr.postDeleteSuccess);
    } else if (state is ProfileFailureState) {
      AppSnackBar.showError(context, context.tr.failureToGetProfile);
    }
  }

  void _getProfile() {
    context.read<ProfileCubit>().getProfile(widget.uId);
  }

  @override
  Widget build(BuildContext context) {
    super.build(context);

    final mainState = context.watch<MainCubit>().state;
    final userState = mainState.userState;
    UserEntity? user;
    if (userState is UserSuccessState) {
      user = userState.user;
    }

    return AppScaffold(
      child: SizedBox(
        width: double.infinity,
        child: RefreshIndicator(
          color: context.theme.primaryColor,
          onRefresh: () async => _getProfile(),
          child: CustomScrollView(
            slivers: [
              if (user != null && widget.uId == user.id!) const AppBarProfile(),
              if (user != null)
                MiddleSectionProfile(
                  isMyProfile: widget.uId == user.id!,
                  user: user,
                ),
              if (user != null)
                SliverToBoxAdapter(
                  child: Divider(height: 1, color: context.customColor.border),
                ),
              if (user != null)
                BlocConsumer<ProfileCubit, ProfileState>(
                  listener: (context, state) => _handleState(context, state),
                  builder: (context, state) {
                    final String uId = widget.uId;
                    final String logUId = user!.id!;

                    if (state is ProfileLoadingState ||
                        state is ProfileLoadingActionPostState) {
                      return const PostsLoading();
                    }

                    return BottomSectionProfile(
                      posts: _profile?.posts ?? [],
                      isMyProfile: uId == logUId,
                    );
                  },
                ),
            ],
          ),
        ),
      ),
    );
  }
}
