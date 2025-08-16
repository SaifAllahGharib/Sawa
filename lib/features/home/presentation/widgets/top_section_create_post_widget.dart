import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:sawa/core/constants/app_assets.dart';
import 'package:sawa/core/extensions/build_context_extensions.dart';
import 'package:sawa/core/extensions/number_extensions.dart';
import 'package:sawa/core/widgets/app_svg.dart';
import 'package:sawa/shared/cubits/main/main_cubit.dart';

import '../../../../core/styles/app_styles.dart';
import '../../../../core/widgets/profile_image.dart';

class TopSectionCreatePostWidget extends StatelessWidget {
  const TopSectionCreatePostWidget({super.key});

  @override
  Widget build(BuildContext context) {
    final user = context.watch<MainCubit>().user;

    return Row(
      children: [
        ProfileImage(url: user.image, size: 40),
        10.horizontalSpace,
        Expanded(
          child: Text(
            user.name.toString(),
            style: AppStyles.s15W400,
            softWrap: true,
            maxLines: 1,
            overflow: TextOverflow.ellipsis,
          ),
        ),
        const Spacer(),
        AppSvg(
          assetName: AppAssets.world,
          height: 22.h,
          width: 22.h,
          colorFilter: ColorFilter.mode(
            context.customColor.icon!,
            BlendMode.srcIn,
          ),
        ),
      ],
    );
  }
}
