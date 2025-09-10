import 'package:flutter/material.dart';

import '../constants/app_assets.dart';

enum ReactionType {
  like('like', AppAssets.like, Colors.blue),
  love('love', AppAssets.love, Colors.red),
  haha('haha', AppAssets.haha, Color(0xfff8ed00)),
  wow('wow', AppAssets.wow, Color(0xfff8ed00)),
  sad('sad', AppAssets.sad, Color(0xfff8ed00)),
  angry('angry', AppAssets.angry, Colors.orange),
  care('care', AppAssets.care, Color(0xfff8ed00));

  final String type;
  final String icon;
  final Color color;

  const ReactionType(this.type, this.icon, this.color);

  static ReactionType fromValue(String value) {
    return ReactionType.values.firstWhere(
      (r) => r.type == value,
      orElse: () => ReactionType.like,
    );
  }
}
