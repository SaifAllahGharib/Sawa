import 'dart:async';

import 'package:flutter/material.dart';
import 'package:intern_intelligence_social_media_application/core/extensions/build_context_extensions.dart';
import 'package:intern_intelligence_social_media_application/core/widgets/profile_image.dart';

import '../extensions/number_extensions.dart';
import '../helpers/date_time_helper.dart';
import '../styles/app_styles.dart';
import 'app_padding_widget.dart';

class TopSectionPostCard extends StatefulWidget {
  final String? image;
  final String name;
  final DateTime postedTime;

  const TopSectionPostCard({
    super.key,
    required this.image,
    required this.name,
    required this.postedTime,
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

  @override
  Widget build(BuildContext context) {
    return AppPaddingWidget(
      top: 12.r,
      bottom: 8.r,
      child: Row(
        children: [
          const ProfileImage(size: 45),
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
        ],
      ),
    );
  }
}
