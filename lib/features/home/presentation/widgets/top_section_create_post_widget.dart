import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intern_intelligence_social_media_application/core/extensions/build_context_extensions.dart';
import 'package:intern_intelligence_social_media_application/core/extensions/number_extensions.dart';
import 'package:intern_intelligence_social_media_application/shared/cubits/main/main_cubit.dart';

import '../../../../core/styles/app_styles.dart';
import '../../../../core/widgets/profile_image.dart';
import '../../../user/domain/entity/user_entity.dart';
import '../../../user/presentation/cubit/user/user_state.dart';

class TopSectionCreatePostWidget extends StatelessWidget {
  const TopSectionCreatePostWidget({super.key});

  @override
  Widget build(BuildContext context) {
    final mainState = context.watch<MainCubit>().state;
    final userState = mainState.userState;

    UserEntity? user;
    if (userState is UserSuccessState) {
      user = userState.user;
    }

    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Row(
          children: [
            if (user != null) ProfileImage(url: user.image, size: 40),
            10.horizontalSpace,
            if (user != null)
              Text(user.name.toString(), style: AppStyles.s15W400),
          ],
        ),
        Icon(Icons.public, size: 25.r, color: context.customColor.icon),
      ],
    );
  }
}
