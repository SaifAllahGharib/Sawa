import 'package:flutter/material.dart';
import 'package:sawa/core/extensions/build_context_extensions.dart';
import 'package:sawa/core/extensions/number_extensions.dart';
import 'package:sawa/core/styles/app_styles.dart';
import 'package:sawa/core/widgets/post_card.dart';
import 'package:sawa/features/home/domain/entities/post_entity.dart';

class BottomSectionHome extends StatelessWidget {
  final List<PostEntity> posts;

  const BottomSectionHome({super.key, required this.posts});

  @override
  Widget build(BuildContext context) {
    if (posts.isEmpty) {
      return SliverToBoxAdapter(
        child: SizedBox(
          height: 500.h,
          child: Center(
            child: Text(context.tr.noPosts, style: AppStyles.s20W600),
          ),
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
            image: posts[index].author.image,
            name: posts[index].author.name,
            postedTime: posts[index].createdAt,
            content: posts[index].content,
            post: posts[index],
          ),
        );
      },
    );
  }
}
