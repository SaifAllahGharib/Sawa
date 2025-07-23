import 'package:flutter/cupertino.dart';
import 'package:intern_intelligence_social_media_application/core/di/dependency_injection.dart';
import 'package:intern_intelligence_social_media_application/core/extensions/number_extensions.dart';
import 'package:intern_intelligence_social_media_application/core/helpers/shared_preferences_helper.dart';

import '../constants/app_assets.dart';
import 'app_asset_image.dart';
import 'app_network_image.dart';

class ProfileImage extends StatelessWidget {
  final double? size;

  const ProfileImage({super.key, this.size});

  @override
  Widget build(BuildContext context) {
    return getIt<SharedPreferencesHelper>().getUserImage() == null
        ? AppAssetImage(
            image: AppAssets.profile,
            width: size?.h ?? 45.h,
            height: size?.h ?? 45.h,
            borderRadius: BorderRadius.circular(10000000.r),
          )
        : AppNetworkImage(
            image: getIt<SharedPreferencesHelper>().getUserImage() ?? '',
            width: size?.h ?? 45.h,
            height: size?.h ?? 45.h,
            borderRadius: BorderRadius.circular(10000000.r),
          );
  }
}
