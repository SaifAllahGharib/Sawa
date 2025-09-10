import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../core/enums/reaction_type.dart';
import '../cubits/reactions/reaction_cubit.dart';
import '../cubits/reactions/reactions_state.dart';
import 'reactions_icon_row_widget.dart';

class ReactionsIconsRowComment extends StatelessWidget {
  const ReactionsIconsRowComment({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<ReactionCubit, ReactionState>(
      buildWhen: (p, c) => p.reactionsCommentResult != c.reactionsCommentResult,
      builder: (context, state) {
        final result = state.reactionsCommentResult;
        if (result == null) return const SizedBox.shrink();

        return result.when(
          failure: (_) => const SizedBox.shrink(),
          success: (reactions) {
            if (reactions.isEmpty) return const SizedBox.shrink();

            final icons = reactions
                .map((e) => ReactionType.fromValue(e.type).icon)
                .toSet()
                .toList();

            return ReactionsIconRowWidget(icons: icons, reactions: reactions);
          },
        );
      },
    );
  }
}
