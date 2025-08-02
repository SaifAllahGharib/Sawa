import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intern_intelligence_social_media_application/core/utils/enums.dart';
import 'package:intern_intelligence_social_media_application/core/widgets/app_scaffold.dart';
import 'package:intern_intelligence_social_media_application/core/widgets/init_video_widget.dart';

import '../di/dependency_injection.dart';
import '../shared/cubits/video_player/video_player_cubit.dart';
import 'app_padding_widget.dart';

class AppVideoRunner extends StatelessWidget {
  final String path;
  final VideoType videoType;

  const AppVideoRunner({
    super.key,
    required this.path,
    required this.videoType,
  });

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => getIt<VideoPlayerCubit>(),
      child: AppScaffold(
        child: AppPaddingWidget(
          left: 0,
          right: 0,
          child: InitVideoWidget(path: path, videoType: videoType),
        ),
      ),
    );
  }
}
