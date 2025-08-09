import 'dart:async';

import 'package:flutter/material.dart';
import 'package:intern_intelligence_social_media_application/core/extensions/build_context_extensions.dart';
import 'package:intern_intelligence_social_media_application/core/utils/app_bottom_sheet.dart';
import 'package:intern_intelligence_social_media_application/core/widgets/app_gesture_detector_button.dart';
import 'package:intern_intelligence_social_media_application/core/widgets/profile_image.dart';

import '../extensions/number_extensions.dart';
import '../helpers/date_time_helper.dart';
import '../styles/app_styles.dart';
import 'app_padding_widget.dart';
import 'more_post_widget.dart';

class TopSectionPostCard extends StatefulWidget {
  final String name;
  final DateTime postedTime;
  final String? authorImage;
  final bool isProfile;
  final VoidCallback? onClickDelete;
  final VoidCallback? onClickEdit;

  const TopSectionPostCard({
    super.key,
    required this.name,
    required this.postedTime,
    this.authorImage,
    this.isProfile = false,
    this.onClickDelete,
    this.onClickEdit,
  });

  @override
  State<TopSectionPostCard> createState() => _TopSectionPostCardState();
}

class _TopSectionPostCardState extends State<TopSectionPostCard> {
  late final Stream<String> _timeStream;

  @override
  void initState() {
    super.initState();
    _timeStream = Stream.periodic(
      const Duration(microseconds: 1),
      (_) => _getTimeAgo(),
    );
  }

  String _getTimeAgo() {
    return DateTimeHelper.timeAgoSinceDate(context, widget.postedTime);
  }

  void _onTapMoreIcon() {
    AppBottomSheet.showModal(context, (context) {
      return MorePostWidget(
        onClickDelete: widget.onClickDelete,
        onClickEdit: widget.onClickEdit,
      );
    });
  }

  @override
  Widget build(BuildContext context) {
    return AppPaddingWidget(
      top: 12.r,
      bottom: 8.r,
      child: Row(
        children: [
          ProfileImage(url: widget.authorImage, size: 45),
          12.horizontalSpace,
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  widget.name,
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                  style: AppStyles.s16W600.copyWith(
                    color: context.customColor.textColor,
                  ),
                ),
                StreamBuilder<String>(
                  stream: _timeStream,
                  builder: (context, snapshot) {
                    return Text(
                      snapshot.data.toString(),
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                      style: AppStyles.s14W400.copyWith(
                        color: context.customColor.textColor,
                      ),
                    );
                  },
                ),
              ],
            ),
          ),
          const Spacer(),
          if (widget.isProfile)
            AppGestureDetectorButton(
              onTap: _onTapMoreIcon,
              child: Icon(
                Icons.more_horiz_rounded,
                color: context.customColor.icon,
                size: 25.r,
              ),
            ),
        ],
      ),
    );
  }
}
