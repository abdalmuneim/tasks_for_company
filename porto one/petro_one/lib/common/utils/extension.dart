import 'package:flutter/material.dart';

/// SizedBox
extension ExtBox on num {
  SizedBox get sh => SizedBox(height: toDouble());
  SizedBox get sw => SizedBox(width: toDouble());
}

///
extension IntExtensions on int {
  String get getDurationReminder {
    if (toString().length == 1) {
      return '0$this';
    } else {
      return '$this';
    }
  }
}
