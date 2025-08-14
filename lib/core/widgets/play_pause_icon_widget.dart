import 'package:flutter/material.dart';
import 'package:sawa/core/extensions/number_extensions.dart';

class PlayPauseIconWidget extends StatelessWidget {
  final bool isPlay;

  const PlayPauseIconWidget({super.key, this.isPlay = false});

  @override
  Widget build(BuildContext context) {
    return Align(
      alignment: Alignment.center,
      child: Container(
        height: 50.h,
        width: 50.h,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(1000.r),
          color: Colors.black.withValues(alpha: 0.3),
        ),
        child: Icon(
          isPlay ? Icons.pause_rounded : Icons.play_arrow_rounded,
          size: 35.r,
          color: Colors.white,
        ),
      ),
    );
  }
}
