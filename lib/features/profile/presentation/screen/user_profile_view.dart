import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:sawa/core/extensions/build_context_extensions.dart';

import '../cubit/profile/profile_cubit.dart';
import '../cubit/profile/profile_state.dart';
import '../widgets/bottom_section_profile.dart';
import '../widgets/middle_section_profile.dart';
import '../widgets/profile_loading.dart';

class UserProfileView extends StatelessWidget {
  final void Function(BuildContext context, ProfileState state) handleState;

  const UserProfileView({super.key, required this.handleState});

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<ProfileCubit, ProfileState>(
      listener: handleState,
      builder: (context, state) {
        if (state.isLoading) {
          return const ProfileLoading();
        }

        return CustomScrollView(
          physics: const AlwaysScrollableScrollPhysics(),
          slivers: [
            MiddleSectionProfile(isMyProfile: false, user: state.profile!.user),
            SliverToBoxAdapter(
              child: Divider(height: 1, color: context.customColor.border),
            ),
            BottomSectionProfile(
              posts: state.profile!.posts,
              isMyProfile: false,
            ),
          ],
        );
      },
    );
  }
}
