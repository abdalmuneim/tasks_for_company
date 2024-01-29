import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:petro_one/common/helper/cache.dart';
import 'package:petro_one/common/routes/pages.dart';
import 'package:petro_one/features/auth/data/models/user_model.dart';
import 'package:petro_one/features/auth/domin/user.dart';
import 'package:petro_one/generated/l10n.dart';

class AppBarController extends GetxController {
  static AppBarController get to => Get.find();

  final GlobalKey<ScaffoldState> scaffoldKey = GlobalKey<ScaffoldState>();

  User? user;
  String _locale = Get.locale!.languageCode;
  String get locale => _locale;

  Future getUserData() async {
    String? us = await CacheHelper.getSecure(key: KeyStorage.user);
    if (us != null) {
      return user = UserModel.fromJson(us);
    }
    update();
  }

  @override
  void onInit() async {
    await getUserData();
    update();
    super.onInit();
  }

  changeLocalization(String localeCode) async {
    await CacheHelper.saveData(key: KeyStorage.locale, value: localeCode);
    _locale = localeCode;
    update();
    Get.updateLocale(Locale(localeCode));
  }

  navTo(String? value) {
    if (value == S.of(Get.context!).profile) {
      Get.offNamed(PagesString.profile, arguments: Get.previousRoute);
    } else if (value == S.of(Get.context!).logout) {
      CacheHelper.clearSecure(key: KeyStorage.user);
      Get.offAllNamed(PagesString.login);
    }
  }
}
