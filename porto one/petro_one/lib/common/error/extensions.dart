import 'package:intl/intl.dart';

extension DoubleExtensions on double {}

extension IntExtensions on int {
  String get getDurationReminder {
    if (toString().length == 1) {
      return '0$this';
    } else {
      return '$this';
    } ////
  }
}

extension DateTimeExtensions on DateTime? {
  String get appDateFormat {
    if (this == null) {
      return '';
    }

    return DateFormat('MMM ,y,d', 'en').format(this!);
  }
}
