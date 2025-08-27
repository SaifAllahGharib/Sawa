import '../../generated/l10n.dart';

extension LocalizationHelper on S {
  String lookup(String key) {
    switch (key) {
      case 'like':
        return like;
      case 'love':
        return love;
      case 'haha':
        return haha;
      case 'wow':
        return wow;
      case 'sad':
        return sad;
      case 'angry':
        return angry;
      case 'care':
        return care;
      default:
        return key;
    }
  }
}
