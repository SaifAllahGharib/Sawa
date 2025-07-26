import 'package:flutter/cupertino.dart';
import 'package:intern_intelligence_social_media_application/core/extensions/number_extensions.dart';

import '../constants/app_assets.dart';
import 'app_asset_image.dart';
import 'app_network_image.dart';

class ProfileImage extends StatelessWidget {
  final double? size;
  final String? url;

  const ProfileImage({super.key, this.size, this.url});

  @override
  Widget build(BuildContext context) {
    return url == null
        ? AppAssetImage(
            image: AppAssets.profile,
            width: size?.h ?? 45.h,
            height: size?.h ?? 45.h,
            borderRadius: BorderRadius.circular(10000000.r),
          )
        : AppNetworkImage(
            image: url ?? '',
            width: size?.h ?? 45.h,
            height: size?.h ?? 45.h,
            borderRadius: BorderRadius.circular(10000000.r),
          );
  }
}
