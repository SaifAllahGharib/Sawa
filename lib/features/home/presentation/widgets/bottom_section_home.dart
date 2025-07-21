import 'package:flutter/material.dart';
import 'package:intern_intelligence_social_media_application/core/extensions/number_extensions.dart';
import 'package:intern_intelligence_social_media_application/features/home/presentation/widgets/post_card.dart';

class BottomSectionHome extends StatelessWidget {
  const BottomSectionHome({super.key});

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
          child: const PostCard(
            image: 'https://randomuser.me/api/portraits/men/75.jpg',
            name: 'name',
            postedTime: '16',
            postImage:
                'https://images.unsplash.com/photo-1506744038136-46273834b3fb',
          ),
        );
      },
    );
  }
}
