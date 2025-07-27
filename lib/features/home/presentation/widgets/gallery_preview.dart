import 'package:flutter/material.dart';
import 'package:intern_intelligence_social_media_application/core/extensions/number_extensions.dart';
import 'package:intern_intelligence_social_media_application/core/shared/models/media_item.dart';
import 'package:intern_intelligence_social_media_application/core/styles/app_styles.dart';
import 'package:intern_intelligence_social_media_application/core/widgets/app_file_image.dart';
import 'package:intern_intelligence_social_media_application/core/widgets/app_gesture_detector_button.dart';

import 'delete_button.dart';

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
          1 => _buildSingleImage(pickedAssets[0].path, 0),
          2 || 3 => Row(
            children: List.generate(
              count,
              (i) => Expanded(
                child: Padding(
                  padding: EdgeInsets.all(4.r),
                  child: _buildImageCard(pickedAssets[i].path, i),
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
            itemBuilder: (_, i) => Stack(
              fit: StackFit.expand,
              children: [
                _buildImageCard(pickedAssets[i].path, i),
                if (i == 3 && count > 4) _buildOverlayMore(context, count - 4),
              ],
            ),
          ),
        },
      ),
    );
  }

  Widget _buildSingleImage(String path, int index) {
    return Padding(
      padding: EdgeInsets.all(6.r),
      child: _buildImageCard(path, index),
    );
  }

  Widget _buildImageCard(String path, int index) {
    if (path.isEmpty) return const SizedBox.shrink();

    return Stack(
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
            child: AppFileImage(
              image: path,
              width: double.infinity,
              height: double.infinity,
            ),
          ),
        ),
        Positioned(
          top: 8.r,
          right: 8.r,
          child: DeleteButton(onClick: () => onDelete(index)),
        ),
      ],
    );
  }

  Widget _buildOverlayMore(BuildContext context, int extraCount) {
    return Container(
      decoration: BoxDecoration(
        color: Colors.black.withValues(alpha: 0.6),
        borderRadius: BorderRadius.circular(16.r),
      ),
      alignment: Alignment.center,
      child: Text(
        '+$extraCount',
        style: AppStyles.s28WB.copyWith(color: Colors.white),
      ),
    );
  }
}
