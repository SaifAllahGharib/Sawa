import 'dart:io';

import 'package:flutter/material.dart';
import 'package:intern_intelligence_social_media_application/core/extensions/number_extensions.dart';
import 'package:intern_intelligence_social_media_application/core/shared/models/media_item.dart';
import 'package:intern_intelligence_social_media_application/core/styles/app_colors.dart';
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
          1 => _buildSingle(pickedAssets[0].path, 0, false),
          2 || 3 => Row(
            children: List.generate(
              count,
              (i) => Expanded(
                child: Padding(
                  padding: EdgeInsets.all(2.r),
                  child: _buildImageWithDelete(pickedAssets[i].path, i, false),
                ),
              ),
            ),
          ),
          _ => GridView.builder(
            itemCount: count.clamp(0, 4),
            gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 2,
              crossAxisSpacing: 2.r,
              mainAxisSpacing: 2.r,
            ),
            itemBuilder: (_, i) => Stack(
              fit: StackFit.expand,
              children: [
                ?_buildImageWithDelete(pickedAssets[i].path, i, false),
                if (i == 3 && count > 4)
                  Container(
                    color: Colors.black.withValues(alpha: 0.5),
                    alignment: Alignment.center,
                    child: Text(
                      '+${count - 4}',
                      style: const TextStyle(color: Colors.white, fontSize: 24),
                    ),
                  ),
              ],
            ),
          ),
        },
      ),
    );
  }

  Widget _buildLoading() {
    return Container(
      color: AppColors.gray.withValues(alpha: 0.5),
      child: const Center(child: CircularProgressIndicator()),
    );
  }

  Widget _buildSingle(String path, int index, bool isLoading) {
    if (path.isNotEmpty) {
      return Stack(
        fit: StackFit.expand,
        children: [
          Image.file(File(path), fit: BoxFit.cover),
          _buildDeleteButton(index),
          if (isLoading) _buildLoading(),
        ],
      );
    }

    return const SizedBox.shrink();
  }

  Widget? _buildImageWithDelete(String path, int index, bool isLoading) {
    if (path.isNotEmpty) {
      return Stack(
        fit: StackFit.expand,
        children: [
          Image.file(File(path), fit: BoxFit.cover),
          _buildDeleteButton(index),
          if (isLoading) _buildLoading(),
        ],
      );
    }
    return null;
  }

  Widget _buildDeleteButton(int index) {
    return DeleteButton(onClick: () => onDelete(index));
  }
}
