import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:sawa/core/extensions/build_context_extensions.dart';
import 'package:sawa/core/styles/app_styles.dart';
import 'package:sawa/core/utils/enums.dart';

import '../../../../core/widgets/posts_loading.dart';
import '../../../user/domain/entity/user_entity.dart';
import '../cubit/profile/profile_cubit.dart';
import '../cubit/profile/profile_state.dart';
import '../widgets/app_bar_profile.dart';
import '../widgets/bottom_section_profile.dart';
import '../widgets/middle_section_profile.dart';

class MyProfileView extends StatelessWidget {
  final UserEntity userEntity;
  final void Function(BuildContext context, ProfileState state) handleState;

  const MyProfileView({
    super.key,
    required this.userEntity,
    required this.handleState,
  });

  @override
  Widget build(BuildContext context) {
    return CustomScrollView(
      physics: const AlwaysScrollableScrollPhysics(),
      slivers: [
        const AppBarProfile(),
        MiddleSectionProfile(isMyProfile: true, user: userEntity),
        SliverToBoxAdapter(
          child: Divider(height: 1, color: context.customColor.border),
        ),
        BlocConsumer<ProfileCubit, ProfileState>(
          listener: handleState,
          builder: (context, state) {
            if (state.isLoading && state.updateType == ProfileUpdateType.none) {
              return const PostsLoading();
            }

            if (state.profile != null) {
              return BottomSectionProfile(
                posts: state.profile!.posts,
                isMyProfile: true,
              );
            }

            return SliverToBoxAdapter(
              child: SizedBox(
                height: MediaQuery.of(context).size.height * 0.5,
                child: Center(
                  child: Text(context.tr.noPosts, style: AppStyles.s18W500),
                ),
              ),
            );
          },
        ),
      ],
    );
  }
}
