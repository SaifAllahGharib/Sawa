import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intern_intelligence_social_media_application/core/extensions/number_extensions.dart';
import 'package:intern_intelligence_social_media_application/core/helpers/date_time_helper.dart';
import 'package:intern_intelligence_social_media_application/core/utils/app_snack_bar.dart';
import 'package:intern_intelligence_social_media_application/features/home/domain/entities/post_entity.dart';
import 'package:intern_intelligence_social_media_application/features/profile/presentation/cubit/profile/profile_state.dart';

import '../../../../core/clients/firebase_client.dart';
import '../../../../core/di/dependency_injection.dart';
import '../../../home/presentation/widgets/post_card.dart';
import '../cubit/profile/profile_cubit.dart';

class BottomSectionProfile extends StatefulWidget {
  const BottomSectionProfile({super.key});

  @override
  State<BottomSectionProfile> createState() => _BottomSectionProfileState();
}

class _BottomSectionProfileState extends State<BottomSectionProfile> {
  List<PostEntity> _posts = [];

  @override
  void initState() {
    getUserPosts();
    super.initState();
  }

  void getUserPosts() {
    context.read<ProfileCubit>().getUserPosts(
      getIt<FirebaseClient>().auth.currentUser!.uid,
    );
  }

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<ProfileCubit, ProfileState>(
      listener: (context, state) {
        if (state is ProfileGetPostsState) {
          _posts = state.posts;
          AppSnackBar.showSuccess(context, 'Get posts');
        } else if (state is ProfileFailureState) {
          AppSnackBar.showError(context, 'Failure get posts');
        }
      },
      builder: (context, state) {
        if (state is ProfileLoadingState) {
          return const SliverToBoxAdapter(
            child: Center(child: CircularProgressIndicator()),
          );
        }

        return SliverList.builder(
          itemCount: _posts.length,
          itemBuilder: (context, index) {
            return Padding(
              padding: EdgeInsets.only(
                top: index == 0 ? 12.r : 16.r,
                bottom: index == 4 ? 16.r : 0,
              ),
              child: PostCard(
                image: '',
                name: "Saif",
                content: _posts[index].content,
                postedTime: DateTimeHelper.timeAgoSinceDate(
                  context,
                  _posts[index].createdAt,
                ),
                postImage:
                    'https://images.unsplash.com/photo-1506744038136-46273834b3fb',
              ),
            );
          },
        );
      },
    );
  }
}
