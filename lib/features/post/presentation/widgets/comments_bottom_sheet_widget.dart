import 'package:flutter/material.dart';
import 'package:sawa/core/extensions/number_extensions.dart';

import 'comment_item_widget.dart';
import 'comment_text_field.dart';

class CommentsBottomSheetWidget extends StatelessWidget {
  const CommentsBottomSheetWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Expanded(
          child: ListView.builder(
            itemCount: 10,
            itemBuilder: (context, index) {
              return const CommentItemWidget();
            },
          ),
        ),
        10.verticalSpace,
        CommentTextField(onTapSend: () {}),
      ],
    );
  }
}
