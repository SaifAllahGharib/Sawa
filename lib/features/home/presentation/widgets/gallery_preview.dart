import 'package:flutter/material.dart';
import 'package:sawa/core/extensions/number_extensions.dart';
import 'package:sawa/core/styles/app_styles.dart';
import 'package:sawa/core/widgets/app_file_image.dart';
import 'package:sawa/core/widgets/app_gesture_detector_button.dart';
import 'package:sawa/core/widgets/app_video_preview.dart';
import 'package:sawa/core/widgets/media_delete_button.dart';

import '../../../../core/enums/media_type.dart';
import '../../../../shared/entities/media_item.dart';

class GalleryPreview extends StatelessWidget {
  final List<MediaItem> pickedAssets;
  final void Function(int index) onDelete;
  final VoidCallback onClick;

  const GalleryPreview({
    super.key,
    required this.pickedAssets,
    required this.onDelete,
    required this.onClick,
  });

  @override
  Widget build(BuildContext context) {
    final count = pickedAssets.length;

    if (count == 0) return const SizedBox();

    return AppGestureDetectorButton(
      onTap: onClick,
      child: SizedBox(
        height: 500.h,
        child: switch (count) {
          1 => _buildSingleMedia(pickedAssets[0].path, 0, pickedAssets[0].type),
          2 || 3 => Row(
            children: List.generate(
              count,
              (i) => KeyedSubtree(
                key: ValueKey(pickedAssets[i].path),
                child: Expanded(
                  child: Padding(
                    padding: EdgeInsets.all(4.r),
                    child: _buildMediaCard(
                      pickedAssets[i].path,
                      i,
                      pickedAssets[i].type,
                      showOverlay: false,
                    ),
                  ),
                ),
              ),
            ),
          ),
          _ => GridView.builder(
            itemCount: count.clamp(0, 4),
            gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 2,
              crossAxisSpacing: 4.r,
              mainAxisSpacing: 4.r,
            ),
            itemBuilder: (_, i) => KeyedSubtree(
              key: ValueKey(pickedAssets[i].path),
              child: _buildMediaCard(
                pickedAssets[i].path,
                i,
                pickedAssets[i].type,
                showOverlay: i == 3 && count > 4,
                extraCount: count - 4,
              ),
            ),
          ),
        },
      ),
    );
  }

  Widget _buildSingleMedia(String path, int index, MediaType type) {
    return Padding(
      padding: EdgeInsets.all(6.r),
      child: _buildMediaCard(path, index, type, showOverlay: false),
    );
  }

  Widget _buildMediaCard(
    String path,
    int index,
    MediaType type, {
    required bool showOverlay,
    int extraCount = 0,
  }) {
    if (path.isEmpty) return const SizedBox.shrink();

    return Stack(
      fit: StackFit.expand,
      children: [
        ClipRRect(
          borderRadius: BorderRadius.circular(16.r),
          child: Container(
            decoration: BoxDecoration(
              boxShadow: [
                BoxShadow(
                  color: Colors.black.withValues(alpha: 0.15),
                  blurRadius: 8,
                  offset: Offset(0, 4.r),
                ),
              ],
            ),
            child: type == MediaType.image
                ? AppFileImage(
                    image: path,
                    width: double.infinity,
                    height: double.infinity,
                  )
                : AppVideoPreview(path: path),
          ),
        ),
        MediaDeleteButton(onClick: () => onDelete(index)),
        if (showOverlay)
          Container(
            decoration: BoxDecoration(
              color: Colors.black.withValues(alpha: 0.6),
              borderRadius: BorderRadius.circular(16.r),
            ),
            alignment: Alignment.center,
            child: Text(
              '+$extraCount',
              style: AppStyles.s28WB.copyWith(color: Colors.white),
            ),
          ),
      ],
    );
  }
}
