import 'package:flutter/material.dart';
import 'package:intern_intelligence_social_media_application/core/extensions/build_context_extensions.dart';
import 'package:intern_intelligence_social_media_application/core/extensions/number_extensions.dart';

import '../styles/app_styles.dart';
import 'app_gesture_detector_button.dart';
import 'app_padding_widget.dart';

class MorePostWidget extends StatelessWidget {
  final VoidCallback? onClickDelete;
  final VoidCallback? onClickEdit;

  const MorePostWidget({
    super.key,
    required this.onClickDelete,
    required this.onClickEdit,
  });

  @override
  Widget build(BuildContext context) {
    return AppPaddingWidget(
      top: 0,
      bottom: 25.r,
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          SizedBox(
            width: double.infinity,
            child: AppGestureDetectorButton(
              onTap: onClickDelete ?? () {},
              child: Text(context.tr.delete, style: AppStyles.s18W500),
            ),
          ),
          15.verticalSpace,
          SizedBox(
            width: double.infinity,
            child: AppGestureDetectorButton(
              onTap: onClickEdit ?? () {},
              child: Text(context.tr.edit, style: AppStyles.s18W500),
            ),
          ),
        ],
      ),
    );
  }
}
