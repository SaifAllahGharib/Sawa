import 'app_assets.dart';

enum ReactionType {
  like('like', AppAssets.like),
  love('love', AppAssets.love),
  haha('haha', AppAssets.haha),
  wow('wow', AppAssets.wow),
  sad('sad', AppAssets.sad),
  angry('angry', AppAssets.angry),
  care('care', AppAssets.care);

  final String type;
  final String icon;

  const ReactionType(this.type, this.icon);

  static ReactionType fromValue(String value) {
    return ReactionType.values.firstWhere(
      (r) => r.type == value,
      orElse: () => ReactionType.like,
    );
  }
}
