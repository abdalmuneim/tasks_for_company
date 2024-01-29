import 'package:flutter/foundation.dart';

printInDebug(text){
  if(kDebugMode) {
    debugPrint(text);
  }else{}
}