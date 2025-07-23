import 'package:flutter/material.dart';
import 'package:intern_intelligence_social_media_application/core/extensions/build_context_extensions.dart';
import 'package:intern_intelligence_social_media_application/core/widgets/app_asset_image.dart';
import 'package:intern_intelligence_social_media_application/core/widgets/app_network_image.dart';

import '../../../../core/constants/app_assets.dart';
import '../../../../core/extensions/number_extensions.dart';
import '../../../../core/styles/app_styles.dart';
import '../../../../core/widgets/app_padding_widget.dart';

class TopSectionPostCard extends StatelessWidget {
  final String? image;
  final String name;
  final String postedTime;

  const TopSectionPostCard({
    super.key,
    required this.image,
    required this.name,
    required this.postedTime,
  });

  @override
  Widget build(BuildContext context) {
    return AppPaddingWidget(
      top: 12.r,
      bottom: 8.r,
      child: Row(
        children: [
          if (image != null && image!.isNotEmpty)
            AppNetworkImage(
              image: image ?? '',
              width: 45.h,
              height: 45.h,
              borderRadius: BorderRadius.circular(100.r),
            )
          else
            AppAssetImage(
              image: AppAssets.profile,
              width: 45.h,
              height: 45.h,
              borderRadius: BorderRadius.circular(100.r),
            ),
          12.horizontalSpace,
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  name,
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                  style: AppStyles.s16W600.copyWith(
                    color: context.customColor.textColor,
                  ),
                ),
                Text(
                  postedTime,
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                  style: AppStyles.s14W400.copyWith(
                    color: context.customColor.textColor,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
