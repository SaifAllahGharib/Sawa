import 'package:flutter/material.dart';

extension NumberExtensions on num {
  SizedBox get horizontalSpace => SizedBox(width: toDouble());

  SizedBox get verticalSpace => SizedBox(height: toDouble());
}
