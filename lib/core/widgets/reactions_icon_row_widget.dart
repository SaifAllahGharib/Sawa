import 'package:flutter/material.dart';
import 'package:sawa/core/extensions/build_context_extensions.dart';
import 'package:sawa/core/extensions/number_extensions.dart';
import 'package:sawa/features/home/domain/entities/reaction_entity.dart';

import '../../shared/cubits/locale_cubit.dart';
import '../di/dependency_injection.dart';
import '../styles/app_styles.dart';
import 'app_svg.dart';

class ReactionsIconRowWidget extends StatelessWidget {
  final List<String> icons;
  final List<ReactionEntity> reactions;

  const ReactionsIconRowWidget({
    super.key,
    required this.icons,
    required this.reactions,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        SizedBox(
          width: icons.length * 22.r,
          height: 25.r,
          child: Stack(
            clipBehavior: Clip.none,
            children: List.generate(icons.length, (index) {
              return Positioned(
                left: getIt<LocaleCubit>().isArabic ? null : index * 17.r,
                right: getIt<LocaleCubit>().isArabic ? index * 17.r : null,
                child: Container(
                  height: 25.r,
                  width: 25.r,
                  padding: EdgeInsets.all(3.r),
                  decoration: BoxDecoration(
                    color: context.theme.scaffoldBackgroundColor,
                    borderRadius: BorderRadius.circular(1000.r),
                  ),
                  child: AppSvg(
                    assetName: icons[index],
                    height: 17.h,
                    width: 17.h,
                  ),
                ),
              );
            }),
          ),
        ),
        2.horizontalSpace,
        if (reactions.length > 1)
          Text('+${reactions.length - 1}', style: AppStyles.s14W400),
      ],
    );
  }
}
