import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../shared/cubits/video_player/video_player_cubit.dart';
import '../di/dependency_injection.dart';
import '../enums/video_type.dart';
import 'app_padding_widget.dart';
import 'app_scaffold.dart';
import 'init_video_widget.dart';

class AppVideoRunner extends StatelessWidget {
  final String path;
  final VideoType videoType;
  final bool showTopSec;

  const AppVideoRunner({
    super.key,
    required this.path,
    required this.videoType,
    this.showTopSec = true,
  });

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => getIt<VideoPlayerCubit>(),
      child: AppScaffold(
        child: AppPaddingWidget(
          left: 0,
          right: 0,
          child: InitVideoWidget(
            path: path,
            videoType: videoType,
            showTopSec: showTopSec,
          ),
        ),
      ),
    );
  }
}
