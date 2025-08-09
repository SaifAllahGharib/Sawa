import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intern_intelligence_social_media_application/core/extensions/build_context_extensions.dart';
import 'package:intern_intelligence_social_media_application/core/extensions/number_extensions.dart';
import 'package:intern_intelligence_social_media_application/core/styles/app_styles.dart';
import 'package:intern_intelligence_social_media_application/features/home/domain/entities/post_entity.dart';
import 'package:intern_intelligence_social_media_application/features/profile/presentation/cubit/profile/profile_cubit.dart';

import '../../../../core/widgets/post_card.dart';

class BottomSectionProfile extends StatelessWidget {
  final List<PostEntity> posts;

  const BottomSectionProfile({super.key, required this.posts});

  void _deletePost(BuildContext context, String postId) {
    context.read<ProfileCubit>().deletePost(postId);
  }

  @override
  Widget build(BuildContext context) {
    if (posts.isEmpty) {
      return SliverToBoxAdapter(
        child: Container(
          height: 400.h,
          alignment: Alignment.center,
          child: Text(context.tr.noPosts, style: AppStyles.s20W600),
        ),
      );
    }

    return SliverList.builder(
      itemCount: posts.length,
      itemBuilder: (context, index) {
        return Padding(
          padding: EdgeInsets.only(
            top: index == 0 ? 12.r : 16.r,
            bottom: index == 4 ? 16.r : 0,
          ),
          child: PostCard(
            image: posts[index].author!.image,
            name: posts[index].author!.name!,
            content: posts[index].content,
            postedTime: posts[index].createdAt,
            post: posts[index],
            isProfile: true,
            onClickDelete: () => _deletePost(context, posts[index].id!),
          ),
        );
      },
    );
  }
}
