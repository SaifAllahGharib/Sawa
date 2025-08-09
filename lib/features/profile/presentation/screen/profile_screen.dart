import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intern_intelligence_social_media_application/core/extensions/build_context_extensions.dart';
import 'package:intern_intelligence_social_media_application/features/profile/presentation/widgets/profile_loading.dart';

import '../../../../core/di/dependency_injection.dart';
import '../../../../core/helpers/shared_preferences_helper.dart';
import '../../../../core/utils/app_snack_bar.dart';
import '../../../../core/widgets/app_scaffold.dart';
import '../../../user/data/model/user_model.dart';
import '../../../user/domain/entity/user_entity.dart';
import '../../domain/entity/profile_entity.dart';
import '../cubit/profile/profile_cubit.dart';
import '../cubit/profile/profile_state.dart';
import '../widgets/app_bar_profile.dart';
import '../widgets/bottom_section_profile.dart';
import '../widgets/middle_section_profile.dart';

class ProfileScreen extends StatefulWidget {
  const ProfileScreen({super.key});

  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen>
    with AutomaticKeepAliveClientMixin {
  ProfileEntity? _profile;

  @override
  bool get wantKeepAlive => true;

  void _handleState(BuildContext context, ProfileState state) {
    if (state is ProfileGetState) {
      _profile = state.profile;
      getIt<SharedPreferencesHelper>().storeUser(
        UserModel.fromEntity(_profile!.user).toJson(),
      );
    } else if (state is ProfileLoadingActionPostState) {
      context.navigator.pop();
    } else if (state is ProfileDeletePostState) {
      AppSnackBar.showSuccess(context, context.tr.postDeleteSuccess);
    } else if (state is ProfileFailureState) {
      AppSnackBar.showError(context, context.tr.failureToGetProfile);
    }
  }

  Future<void> _getProfileOnRefresh() async {
    context.read<ProfileCubit>().getProfile();
  }

  @override
  Widget build(BuildContext context) {
    super.build(context);
    return AppScaffold(
      child: SizedBox(
        width: double.infinity,
        child: RefreshIndicator(
          color: context.theme.primaryColor,
          onRefresh: () async => await _getProfileOnRefresh(),
          child: BlocConsumer<ProfileCubit, ProfileState>(
            listener: (context, state) => _handleState(context, state),
            builder: (context, state) {
              if (state is ProfileLoadingState ||
                  state is ProfileLoadingActionPostState) {
                return const ProfileLoading();
              }

              return CustomScrollView(
                slivers: [
                  const AppBarProfile(),
                  MiddleSectionProfile(
                    user:
                        _profile?.user ??
                        const UserEntity(
                          id: '',
                          name: '',
                          image: '',
                          email: '',
                          bio: '',
                        ),
                  ),
                  SliverToBoxAdapter(
                    child: Divider(
                      height: 1,
                      color: context.customColor.border,
                    ),
                  ),
                  BottomSectionProfile(posts: _profile?.posts ?? []),
                ],
              );
            },
          ),
        ),
      ),
    );
  }
}
