import 'package:sawa/generated/l10n.dart';

import 's_extensions.dart';

extension LocalizationExtension on String {
  String get tr {
    return S.current.lookup(this);
  }
}
