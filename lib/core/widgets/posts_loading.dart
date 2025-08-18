import 'package:flutter/material.dart';
import 'package:sawa/core/extensions/number_extensions.dart';
import 'package:sawa/core/widgets/app_placeholder.dart';
import 'package:sawa/core/widgets/bottom_section_post_card.dart';

class PostsLoading extends StatelessWidget {
  const PostsLoading({super.key});

  @override
  Widget build(BuildContext context) {
    return SliverList.builder(
      itemCount: 5,
      itemBuilder: (context, index) {
        return Container(
          margin: EdgeInsets.symmetric(horizontal: 12.r),
          padding: EdgeInsets.only(
            top: index == 0 ? 12.r : 16.r,
            bottom: index == 4 ? 16.r : 0,
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                children: [
                  AppPlaceholder(
                    width: 45.h,
                    height: 45.h,
                    borderRadius: BorderRadius.circular(1000.r),
                  ),
                  12.horizontalSpace,
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      AppPlaceholder(width: 130.w, height: 15.h),
                      10.verticalSpace,
                      AppPlaceholder(width: 50.w, height: 15.h),
                    ],
                  ),
                ],
              ),
              15.verticalSpace,
              AppPlaceholder(width: double.infinity, height: 15.h),
              10.verticalSpace,
              AppPlaceholder(width: double.infinity, height: 400.h),
              const BottomSectionPostCard(),
            ],
          ),
        );
      },
    );
  }
}
