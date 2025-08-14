import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:sawa/core/extensions/build_context_extensions.dart';
import 'package:sawa/core/extensions/number_extensions.dart';
import 'package:sawa/features/home/presentation/screens/display_selected_media.dart';

import '../../../../shared/cubits/media/media_cubit.dart';
import '../../../../shared/cubits/media/media_state.dart';
import '../../../../shared/cubits/validation/validation_cubit.dart';
import 'gallery_preview.dart';

class MiddleSectionCreatePostWidget extends StatelessWidget {
  final TextEditingController postController;

  const MiddleSectionCreatePostWidget({
    super.key,
    required this.postController,
  });

  void _handleEnableButtonState(BuildContext context, MediaState state) {
    context.read<ValidationCubit>().validateField(
      'post',
      state.pickedAssets.isNotEmpty || postController.text.isNotEmpty,
    );
  }

  void _pushToDisplaySelectedMedia(
    BuildContext context,
    MediaCubit mediaCubit,
  ) {
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
      listener: (context, state) => _handleEnableButtonState(context, state),
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
                controller: postController,
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
                onTapOutside: (event) =>
                    FocusManager.instance.primaryFocus?.unfocus(),
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
                onClick: () => _pushToDisplaySelectedMedia(context, mediaCubit),
              ),
            ],
          ],
        ),
      ),
    );
  }
}
