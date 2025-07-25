import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intern_intelligence_social_media_application/core/extensions/build_context_extensions.dart';
import 'package:intern_intelligence_social_media_application/core/shared/cubits/validation/validation_cubit.dart';
import 'package:intern_intelligence_social_media_application/core/widgets/app_scaffold.dart';

import '../../../../core/utils/app_snack_bar.dart';
import '../../../home/domain/entities/post_entity.dart';
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

class _ProfileScreenState extends State<ProfileScreen> {
  List<PostEntity> _posts = [];

  void _handleState(BuildContext context, ProfileState state) {
    if (state is ProfileGetPostsState) {
      _posts = state.posts;
    } else if (state is ProfileFailureState) {
      AppSnackBar.showError(context, context.tr.failureToGetPosts);
    }
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => ValidationCubit(requiredFields: {'changeName'}),
      child: AppScaffold(
        child: SizedBox(
          width: double.infinity,
          child: CustomScrollView(
            slivers: [
              const AppBarProfile(),
              const MiddleSectionProfile(),
              SliverToBoxAdapter(
                child: Divider(height: 1, color: context.customColor.border),
              ),
              BlocConsumer<ProfileCubit, ProfileState>(
                listener: (context, state) => _handleState(context, state),
                builder: (context, state) {
                  if (state is ProfileLoadingState) {
                    return SliverToBoxAdapter(
                      child: Column(
                        children: [
                          Center(
                            child: CircularProgressIndicator(
                              color: context.theme.primaryColor,
                            ),
                          ),
                        ],
                      ),
                    );
                  }

                  return BottomSectionProfile(posts: _posts);
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}
