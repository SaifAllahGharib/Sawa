import 'package:flutter/material.dart';
import 'package:intern_intelligence_social_media_application/core/extensions/number_extensions.dart';
import 'package:intern_intelligence_social_media_application/features/home/domain/entities/post_entity.dart';

import '../../../home/presentation/widgets/post_card.dart';

class BottomSectionProfile extends StatelessWidget {
  final List<PostEntity> posts;

  const BottomSectionProfile({super.key, required this.posts});

  @override
  Widget build(BuildContext context) {
    return SliverList.builder(
      itemCount: posts.length,
      itemBuilder: (context, index) {
        return Padding(
          padding: EdgeInsets.only(
            top: index == 0 ? 12.r : 16.r,
            bottom: index == 4 ? 16.r : 0,
          ),
          child: PostCard(
            image: '',
            name: 'Saif',
            content: posts[index].content,
            postedTime: posts[index].createdAt,
            postImage: posts[index].media.isNotEmpty
                ? posts[index].media[0].mediaUrl
                : null,
          ),
        );
      },
    );
  }
}
