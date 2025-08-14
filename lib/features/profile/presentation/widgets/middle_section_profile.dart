import 'package:flutter/material.dart';

import '../../../../core/widgets/app_padding_widget.dart';
import '../../../user/domain/entity/user_entity.dart';
import './../../../../core/extensions/number_extensions.dart';
import 'bio_middle_section_profile.dart';
import 'image_middle_section_profile.dart';
import 'name_middle_section_profile.dart';

class MiddleSectionProfile extends StatelessWidget {
  final UserEntity user;
  final bool isMyProfile;

  const MiddleSectionProfile({
    super.key,
    required this.user,
    required this.isMyProfile,
  });

  @override
  Widget build(BuildContext context) {
    return SliverToBoxAdapter(
      child: AppPaddingWidget(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            ImageMiddleSectionProfile(
              userEntity: user,
              isMyProfile: isMyProfile,
            ),
            10.verticalSpace,
            NameMiddleSectionProfile(
              userEntity: user,
              isMyProfile: isMyProfile,
            ),
            5.verticalSpace,
            BioMiddleSectionProfile(userEntity: user, isMyProfile: isMyProfile),
          ],
        ),
      ),
    );
  }
}
