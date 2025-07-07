import 'package:flutter/material.dart';

import '../../generated/l10n.dart';
import '../responsive/rsponsive_config.dart';
import '../styles/app_styles.dart';

extension BuildContextExtensions on BuildContext {
  ResponsiveConfig get responsive => ResponsiveConfig.of(this);

  ThemeData get theme => Theme.of(this);

  NavigatorState get navigator => Navigator.of(this);

  AppStyles get textStyle => AppStyles.of(this);

  S get tr => S.of(this);

  Object? get arguments => ModalRoute.of(this)!.settings.arguments;
}
