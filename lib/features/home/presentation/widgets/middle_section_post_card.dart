import 'package:flutter/material.dart';
import 'package:intern_intelligence_social_media_application/core/widgets/app_network_image.dart';

import '../../../../core/extensions/number_extensions.dart';
import '../../../../core/styles/app_styles.dart';
import '../../../../core/widgets/app_padding_widget.dart';

class MiddleSectionPostCard extends StatelessWidget {
  final String? content;
  final String? postImage;

  const MiddleSectionPostCard({
    super.key,
    required this.content,
    required this.postImage,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        if (content != null && content!.isNotEmpty)
          AppPaddingWidget(
            top: 0,
            bottom: 12.r,
            child: Text(
              content ?? '',
              style: AppStyles.s15W400.copyWith(
                color: Colors.black87,
                height: 1.4,
              ),
            ),
          ),
        if (postImage != null && postImage!.isNotEmpty)
          AppNetworkImage(image: postImage!),
      ],
    );
  }
}
