import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:petro_one/common/helper/cache.dart';
import 'package:petro_one/common/routes/pages.dart';

class SplashController extends GetxController {
  nav() {
    Future.delayed(
        const Duration(seconds: 3), () async => Get.offAllNamed(await page()));
  }

  Future<String> page() async {
    bool? isFirst = CacheHelper.getData(key: KeyStorage.isFirst);
    if (isFirst != null) {
      if (isFirst) {
        /// TODO: change to on boarding
        return PagesString.login;
      } else {
        String? user = await _getUser();
        if (user != null) {
          return PagesString.home;
        }
        return PagesString.login;
      }
    }

    /// TODO: change to on boarding
    return PagesString.login;
  }

  Future<String?>? _getUser() async =>
      await CacheHelper.getSecure(key: KeyStorage.user);

  Future _getLocaleCode() async {
    final String? locale = await CacheHelper.getData(key: KeyStorage.locale);
    if (locale == null) {
      return;
    }
    Get.updateLocale(Locale(locale));
    update();
  }

  @override
  void onInit() async {
    Future.wait([
      _getLocaleCode(),
    ]);
    nav();
    super.onInit();
  }
}
