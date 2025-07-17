import 'package:flutter/material.dart';
import 'package:intern_intelligence_social_media_application/core/extensions/number_extensions.dart';

import '../../../home/presentation/widgets/post_card.dart';

class BottomSectionProfile extends StatelessWidget {
  const BottomSectionProfile({super.key});

  @override
  Widget build(BuildContext context) {
    return SliverList.builder(
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
