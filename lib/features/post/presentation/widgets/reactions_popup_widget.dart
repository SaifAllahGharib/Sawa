import 'package:flutter/material.dart';
import 'package:sawa/core/di/dependency_injection.dart';
import 'package:sawa/core/extensions/build_context_extensions.dart';
import 'package:sawa/core/extensions/number_extensions.dart';
import 'package:sawa/shared/cubits/locale_cubit.dart';

import '../../../../core/enums/reaction_type.dart';
import '../../../../core/widgets/app_gesture_detector_button.dart';
import '../../../../core/widgets/app_svg.dart';

class ReactionsPopupWidget extends StatefulWidget {
  final Offset position;
  final String targetId;
  final void Function(ReactionType reaction) onTapReaction;
  final VoidCallback onClose;

  const ReactionsPopupWidget({
    super.key,
    required this.position,
    required this.targetId,
    required this.onClose,
    required this.onTapReaction,
  });

  @override
  State<ReactionsPopupWidget> createState() => _ReactionsPopupWidgetState();
}

class _ReactionsPopupWidgetState extends State<ReactionsPopupWidget>
    with SingleTickerProviderStateMixin {
  late final AnimationController _controller;
  late final Animation<Offset> _slideAnimation;

  @override
  void initState() {
    _initControllers();
    _onClose();

    super.initState();
  }

  void _initControllers() {
    _controller = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 100),
      reverseDuration: const Duration(milliseconds: 100),
    );

    _slideAnimation = Tween<Offset>(begin: Offset(0, 0.3.h), end: Offset.zero)
        .animate(
          CurvedAnimation(
            parent: _controller,
            curve: Curves.easeOut,
            reverseCurve: Curves.easeIn,
          ),
        );

    _controller.forward();
  }

  void _onClose() {
    Future.delayed(const Duration(seconds: 3), () {
      if (mounted) {
        _close();
      }
    });
  }

  Future<void> _close() async {
    await _controller.reverse();
    if (mounted) widget.onClose();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final bool isArabic = getIt<LocaleCubit>().isArabic;
    return Positioned(
      left: isArabic ? null : 15.r,
      right: isArabic ? 15.r : null,
      top: widget.position.dy - 50.r,
      child: Material(
        color: Colors.transparent,
        child: SlideTransition(
          position: _slideAnimation,
          child: Container(
            padding: EdgeInsets.symmetric(horizontal: 8.r, vertical: 6.r),
            decoration: BoxDecoration(
              color: context.theme.scaffoldBackgroundColor,
              borderRadius: BorderRadius.circular(40),
              border: Border.all(color: context.customColor.border, width: 1.r),
            ),
            child: Row(
              mainAxisSize: MainAxisSize.min,
              children: ReactionType.values.map((reaction) {
                return AppGestureDetectorButton(
                  onTap: () {
                    widget.onTapReaction(reaction);
                    _close();
                  },
                  child: Padding(
                    padding: EdgeInsets.symmetric(horizontal: 4.r),
                    child: AppSvg(
                      assetName: reaction.icon,
                      height: 30.h,
                      width: 30.h,
                    ),
                  ),
                );
              }).toList(),
            ),
          ),
        ),
      ),
    );
  }
}
