import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:sawa/core/di/dependency_injection.dart';
import 'package:sawa/core/extensions/build_context_extensions.dart';
import 'package:sawa/core/extensions/number_extensions.dart';
import 'package:sawa/shared/cubits/locale_cubit.dart';

import '../../shared/cubits/reactions/reaction_cubit.dart';
import '../../shared/cubits/reactions/reactions_state.dart';
import '../constants/reaction_type.dart';
import '../styles/app_styles.dart';
import '../utils/app_bottom_sheet.dart';
import 'app_gesture_detector_button.dart';
import 'app_svg.dart';
import 'list_user_reactions_post.dart';

class ReactionsIconsRow extends StatelessWidget {
  final String postId;

  const ReactionsIconsRow({super.key, required this.postId});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<ReactionCubit, ReactionState>(
      buildWhen: (p, c) => p.reactionsResult != c.reactionsResult,
      builder: (context, state) {
        final result = state.reactionsResult;
        if (result == null) return const SizedBox.shrink();

        return result.when(
          failure: (_) => const SizedBox.shrink(),
          success: (reactions) {
            if (reactions.isEmpty) return const SizedBox.shrink();

            final icons = reactions
                .map((e) => ReactionType.fromValue(e.type).icon)
                .toSet()
                .toList();

            return AppGestureDetectorButton(
              onTap: () => AppBottomSheet.show(
                context,
                (_) => BlocProvider(
                  create: (context) => getIt<ReactionCubit>(),
                  child: ListUserReactionsPost(
                    users: reactions.map((e) => e.userId).toList(),
                    reactions: reactions,
                  ),
                ),
              ),
              child: Row(
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
                          left: getIt<LocaleCubit>().isArabic
                              ? null
                              : index * 17.r,
                          right: getIt<LocaleCubit>().isArabic
                              ? index * 17.r
                              : null,
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
              ),
            );
          },
        );
      },
    );
  }
}
