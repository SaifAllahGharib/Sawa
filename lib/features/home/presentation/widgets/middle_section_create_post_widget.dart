import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intern_intelligence_social_media_application/core/extensions/build_context_extensions.dart';
import 'package:intern_intelligence_social_media_application/core/extensions/number_extensions.dart';
import 'package:intern_intelligence_social_media_application/features/home/presentation/screens/display_selected_media.dart';

import '../../../../core/shared/cubits/media/media_cubit.dart';
import '../../../../core/shared/cubits/media/media_state.dart';
import '../../../../core/shared/cubits/validation/validation_cubit.dart';
import 'gallery_preview.dart';

class MiddleSectionCreatePostWidget extends StatefulWidget {
  const MiddleSectionCreatePostWidget({super.key});

  @override
  State<MiddleSectionCreatePostWidget> createState() =>
      _MiddleSectionCreatePostWidgetState();
}

class _MiddleSectionCreatePostWidgetState
    extends State<MiddleSectionCreatePostWidget> {
  late final TextEditingController _postController;

  @override
  void initState() {
    _postController = TextEditingController();
    super.initState();
  }

  @override
  dispose() {
    _postController.dispose();
    super.dispose();
  }

  void _handleEnableButtonState(MediaState state) {
    context.read<ValidationCubit>().validateField(
      'post',
      state.pickedAssets.isNotEmpty || _postController.text.isNotEmpty,
    );
  }

  void _pushToDisplaySelectedMedia(MediaCubit mediaCubit) {
    context.navigator.push(
      PageRouteBuilder(
        opaque: false,
        barrierDismissible: true,
        barrierColor: Colors.black54,
        pageBuilder: (_, _, _) => BlocProvider.value(
          value: mediaCubit,
          child: const DisplaySelectedMedia(),
        ),
        transitionsBuilder: (_, animation, _, child) {
          return SlideTransition(
            position: Tween(
              begin: const Offset(0, 1),
              end: Offset.zero,
            ).animate(animation),
            child: child,
          );
        },
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final mediaCubit = context.watch<MediaCubit>();
    final pickedAssets = mediaCubit.state.pickedAssets;

    return BlocListener<MediaCubit, MediaState>(
      listenWhen: (previous, current) =>
          previous.pickedAssets != current.pickedAssets,
      listener: (context, state) => _handleEnableButtonState(state),
      child: Expanded(
        child: ListView(
          padding: EdgeInsets.zero,
          children: [
            ConstrainedBox(
              constraints: BoxConstraints(
                minHeight: (pickedAssets.isNotEmpty) ? 100.h : 500.h,
                maxHeight: (pickedAssets.isNotEmpty) ? 200.h : 600.h,
              ),
              child: TextFormField(
                controller: _postController,
                expands: true,
                maxLines: null,
                minLines: null,
                decoration: InputDecoration(
                  hintText: context.tr.whateYouThinking,
                  border: InputBorder.none,
                  focusedBorder: InputBorder.none,
                  enabledBorder: InputBorder.none,
                  errorBorder: InputBorder.none,
                  disabledBorder: InputBorder.none,
                  focusedErrorBorder: InputBorder.none,
                  contentPadding: EdgeInsets.zero,
                  filled: false,
                ),
                keyboardType: TextInputType.multiline,
                onChanged: (value) {
                  context.read<ValidationCubit>().validateField(
                    'post',
                    value.isNotEmpty || pickedAssets.isNotEmpty,
                  );
                },
              ),
            ),
            if (pickedAssets.isNotEmpty) ...[
              15.verticalSpace,
              GalleryPreview(
                pickedAssets: pickedAssets,
                onDelete: (index) => mediaCubit.removePickedAsset(index),
                onClick: () => _pushToDisplaySelectedMedia(mediaCubit),
              ),
            ],
          ],
        ),
      ),
    );
  }
}
