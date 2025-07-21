import 'package:flutter/material.dart';
import 'package:intern_intelligence_social_media_application/core/extensions/build_context_extensions.dart';
import 'package:intern_intelligence_social_media_application/core/extensions/number_extensions.dart';

import '../../../../core/di/dependency_injection.dart';
import '../../../../core/helpers/shared_preferences_helper.dart';
import '../../../../core/styles/app_styles.dart';
import '../../../../core/widgets/profile_image.dart';

class TopSectionCreatePostWidget extends StatefulWidget {
  const TopSectionCreatePostWidget({super.key});

  @override
  State<TopSectionCreatePostWidget> createState() =>
      _TopSectionCreatePostWidgetState();
}

class _TopSectionCreatePostWidgetState
    extends State<TopSectionCreatePostWidget> {
  late final SharedPreferencesHelper _sharedPreferencesHelper;

  @override
  void initState() {
    _sharedPreferencesHelper = getIt<SharedPreferencesHelper>();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Row(
          children: [
            const ProfileImage(size: 40),
            10.horizontalSpace,
            Text(
              _sharedPreferencesHelper.getUserName() ?? '',
              style: AppStyles.s15W400,
            ),
          ],
        ),
        Icon(Icons.public, size: 25.r, color: context.customColor.icon),
      ],
    );
  }
}
