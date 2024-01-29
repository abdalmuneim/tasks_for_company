import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:petro_one/common/app_constant/app_constants.dart';
import 'package:petro_one/common/helper/cache.dart';
import 'package:petro_one/common/routes/pages.dart';
import 'package:petro_one/common/utils/utils.dart';
import 'package:petro_one/features/auth/data/models/user_model.dart';
import 'package:petro_one/generated/l10n.dart';

class LoginController extends GetxController {
  GlobalKey<FormState> globalKey = GlobalKey<FormState>(debugLabel: 'login');
  bool loading = false;

  final TextEditingController _password = TextEditingController();
  TextEditingController get password => _password;

  final TextEditingController _email = TextEditingController();
  TextEditingController get email => _email;

  login() async {
    if (globalKey.currentState!.validate()) {
      FocusScope.of(Get.context!).unfocus();
      loading = true;
      update();
      String us = checkEmail();
      log(us);
      if (us.isNotEmpty) {
        UserModel user = UserModel(
            name: us == '1'
                ? AppConstants.customerName
                : AppConstants.workerEmail,
            accountType: us,
            email: email.text,
            password: password.text);

        await CacheHelper.saveSecure(
            key: KeyStorage.user, value: user.toJson());
        await CacheHelper.saveData(key: KeyStorage.isFirst, value: false);

        Get.offAllNamed(PagesString.home);
      } else {
        Utils.showError(S.of(Get.context!).makeSureYourEmailOrPassword);
      }
      loading = false;
      update();
    }
  }

  String checkEmail() {
    /*  if (email.text == AppConstants.customerEmail &&
        password.text == AppConstants.customerPassword) {
      return '1';
    } else if (email.text == AppConstants.workerEmail &&
        password.text == AppConstants.workerPassword) {
      return '2';
    } else {
      return '';
    } */
    return '1';
  }
}
