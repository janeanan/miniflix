
import 'package:flutter/material.dart';

extension IntExtension on int? {
  int validate({int value = 0}) {
    return this ?? value;
  }

  Widget get sBoxHeight => SizedBox(height: this?.toDouble());
  Widget get sBoxWidth => SizedBox(width: this?.toDouble());
}

extension DoubleExtension on double? {
  double validate({double value = 0}) {
    return this ?? value;
  }

  Widget get sBoxHeight => SizedBox(height: this);
  Widget get sBoxWidth => SizedBox(width: this);
}
