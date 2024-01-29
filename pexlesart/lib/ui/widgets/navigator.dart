import 'package:flutter/material.dart';

class NavigatorScreen {

  pop(ctx) {
    Navigator.of(ctx).pop();
  }

  push(ctx,{required screen}) {
    Navigator.of(ctx).push(MaterialPageRoute(builder: (ctx) => screen));
  }
}
