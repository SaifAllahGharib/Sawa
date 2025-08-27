import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:sawa/core/di/dependency_injection.dart';

import '../../shared/cubits/reactions/reaction_cubit.dart';
import '../../shared/cubits/reactions/reactions_state.dart';
import '../enums/reaction_type.dart';
import '../utils/app_bottom_sheet.dart';
import 'app_gesture_detector_button.dart';
import 'list_user_reactions_post.dart';
import 'reactions_icon_row_widget.dart';

class ReactionsIconsRowPost extends StatelessWidget {
  const ReactionsIconsRowPost({super.key});

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
              child: ReactionsIconRowWidget(icons: icons, reactions: reactions),
            );
          },
        );
      },
    );
  }
}
