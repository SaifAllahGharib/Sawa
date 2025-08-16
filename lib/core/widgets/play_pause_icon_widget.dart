import 'package:flutter/material.dart';
import 'package:sawa/core/constants/app_assets.dart';
import 'package:sawa/core/extensions/number_extensions.dart';
import 'package:sawa/core/widgets/app_svg.dart';

class PlayPauseIconWidget extends StatelessWidget {
  final bool isPlay;

  const PlayPauseIconWidget({super.key, this.isPlay = false});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Container(
        height: 50.h,
        width: 50.h,
        alignment: Alignment.center,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(1000.r),
          color: Colors.black.withValues(alpha: 0.3),
        ),
        child: Align(
          alignment: Alignment.center,
          child: SizedBox(
            height: 25.h,
            width: 25.h,
            child: AppSvg(
              assetName: isPlay ? AppAssets.pause2 : AppAssets.play,
              height: 25.r,
              width: 25.r,
              colorFilter: const ColorFilter.mode(
                Colors.white,
                BlendMode.srcIn,
              ),
            ),
          ),
        ),
      ),
    );
  }
}
