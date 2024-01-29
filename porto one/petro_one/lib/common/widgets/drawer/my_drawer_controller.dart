import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:petro_one/common/resources/app_color.dart';

class MyDrawerController extends GetxController {
  navTo(String rout) {
    log(rout);
    log(Get.currentRoute);
    if (rout == Get.currentRoute) {
      Get.back();
    } else {
      Get.offAllNamed(rout, arguments: Get.currentRoute);
    }
  }

  updateL() {
    /*  log('message');
    Stream.periodic(Duration.zero, (timer) {
      log('message');
      update();
    }); */
  }

  late Color activeColor;
  late Color notActiveColor;

  late Color activeTextColor;
  late Color notActiveTextColor;

  (Color, Color) getStyle(String rout) {
    update();
    if (rout == Get.currentRoute) {
      return (activeTextColor, activeColor);
    } else {
      return (notActiveTextColor, notActiveColor);
    }
  }

  @override
  void onInit() {
    activeColor = AppColors.green;
    activeTextColor = AppColors.white;

    notActiveColor = AppColors.white;
    notActiveTextColor = AppColors.black;

    super.onInit();
  }
}
