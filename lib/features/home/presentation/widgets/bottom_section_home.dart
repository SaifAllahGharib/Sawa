import 'package:flutter/material.dart';
import 'package:intern_intelligence_social_media_application/core/extensions/number_extensions.dart';
import 'package:intern_intelligence_social_media_application/core/widgets/post_card.dart';
import 'package:intern_intelligence_social_media_application/features/home/domain/entities/post_entity.dart';

class BottomSectionHome extends StatelessWidget {
  final PostEntity post;

  const BottomSectionHome({super.key, required this.post});

  @override
  Widget build(BuildContext context) {
    return SliverList.builder(
      itemCount: 5,
      itemBuilder: (context, index) {
        return Padding(
          padding: EdgeInsets.only(
            top: index == 0 ? 12.r : 16.r,
            bottom: index == 4 ? 16.r : 0,
          ),
          child: PostCard(
            image: 'https://randomuser.me/api/portraits/men/75.jpg',
            name: 'name',
            postedTime: DateTime.now(),
            post: post,
          ),
        );
      },
    );
  }
}
