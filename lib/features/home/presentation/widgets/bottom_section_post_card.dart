import 'package:flutter/material.dart';
import 'package:intern_intelligence_social_media_application/core/extensions/build_context_extensions.dart';

import '../../../../core/widgets/app_padding_widget.dart';
import 'action_button.dart';

class BottomSectionPostCard extends StatelessWidget {
  const BottomSectionPostCard({super.key});

  @override
  Widget build(BuildContext context) {
    return AppPaddingWidget(
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          ActionButton(
            icon: Icons.favorite_border,
            label: context.tr.like,
            onPressed: () {},
          ),
          ActionButton(
            icon: Icons.comment_outlined,
            label: context.tr.comment,
            onPressed: () {},
          ),
          ActionButton(
            icon: Icons.share_outlined,
            label: context.tr.share,
            onPressed: () {},
          ),
        ],
      ),
    );
  }
}
