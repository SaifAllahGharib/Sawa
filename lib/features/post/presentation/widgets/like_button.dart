import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:sawa/core/di/dependency_injection.dart';
import 'package:sawa/core/extensions/number_extensions.dart';
import 'package:sawa/core/extensions/string_extentions.dart';
import 'package:sawa/core/widgets/app_gesture_detector_button.dart';
import 'package:sawa/features/post/presentation/widgets/post_action_button.dart';

import '../../../../core/constants/app_assets.dart';
import '../../../../core/enums/reaction_type.dart';
import '../../../../core/widgets/app_svg.dart';
import '../cubits/reactions/reaction_cubit.dart';
import '../cubits/reactions/reactions_state.dart';
import 'reactions_popup_widget.dart';

class LikeButton extends StatelessWidget {
  final String postId;

  const LikeButton({super.key, required this.postId});

  void _showReactionsPopup(BuildContext context, Offset position) {
    final overlay = Overlay.of(context);
    late final OverlayEntry overlayEntry;

    overlayEntry = OverlayEntry(
      builder: (context) {
        return AppGestureDetectorButton(
          behavior: HitTestBehavior.translucent,
          onTap: () {
            if (overlayEntry.mounted) {
              overlayEntry.remove();
            }
          },
          child: Stack(
            children: [
              BlocProvider(
                create: (context) => getIt<ReactionCubit>(),
                child: ReactionsPopupWidget(
                  postId: postId,
                  position: position,
                  onClose: () {
                    if (overlayEntry.mounted) {
                      overlayEntry.remove();
                    }
                  },
                ),
              ),
            ],
          ),
        );
      },
    );

    overlay.insert(overlayEntry);
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<ReactionCubit, ReactionState>(
      buildWhen: (p, c) => p.userReactionResult != c.userReactionResult,
      builder: (context, state) {
        final reaction = state.userReactionResult?.when(
          failure: (_) => null,
          success: (reaction) => reaction,
        );

        final isLiked = reaction != null;
        final type = reaction?.type;

        return PostActionButton(
          icon: isLiked && type != null
              ? AppSvg(
                  assetName: ReactionType.fromValue(type).icon,
                  height: 20.r,
                  width: 20.r,
                )
              : AppSvg(
                  assetName: AppAssets.unLike,
                  colorFilter: const ColorFilter.mode(
                    Colors.grey,
                    BlendMode.srcIn,
                  ),
                  width: 20.r,
                  height: 20.r,
                ),
          label: ReactionType.fromValue(type ?? '').type.tr,
          onPressed: () =>
              context.read<ReactionCubit>().toggleLikeToPost(postId),
          onLongPress: () {
            final box = context.findRenderObject() as RenderBox;
            final position = box.localToGlobal(Offset.zero);
            _showReactionsPopup(context, position);
          },
        );
      },
    );
  }
}
