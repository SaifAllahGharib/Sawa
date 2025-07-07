import 'package:flutter/material.dart';

import '../../generated/l10n.dart';

extension BuildContextExtensions on BuildContext {
  ThemeData get theme => Theme.of(this);

  NavigatorState get navigator => Navigator.of(this);

  S get tr => S.of(this);

  Object? get arguments => ModalRoute.of(this)!.settings.arguments;
}
