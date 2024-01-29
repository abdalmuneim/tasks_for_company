import 'package:flutter/material.dart';
import 'package:get/get.dart';

class ForgetPasswordController extends GetxController {
  final _phoneTEXT = TextEditingController();
  TextEditingController get phoneTEXT => _phoneTEXT;

  GlobalKey<FormState> globalKey =
      GlobalKey<FormState>(debugLabel: 'ForgetPassword');

  bool loading = false;

  continuoBut() async {
    if (globalKey.currentState!.validate()) {
      loading = true;
      update();

      loading = false;
      update();
    }
  }
}
