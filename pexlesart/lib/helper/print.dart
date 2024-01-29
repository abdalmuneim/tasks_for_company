import 'dart:developer';

import 'package:flutter/foundation.dart';

printInDebug(String text) {
  if (kDebugMode) {
    log(text);
  } else {

  }
}
