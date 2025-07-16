import 'package:flutter/material.dart';

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
            label: 'Like',
            onPressed: () {},
          ),
          ActionButton(
            icon: Icons.comment_outlined,
            label: 'Comment',
            onPressed: () {},
          ),
          ActionButton(
            icon: Icons.share_outlined,
            label: 'Share',
            onPressed: () {},
          ),
        ],
      ),
    );
  }
}
