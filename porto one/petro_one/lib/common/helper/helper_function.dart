import 'package:get/get.dart';
import 'package:petro_one/common/routes/pages.dart';
import 'package:petro_one/generated/l10n.dart';

class HelperFunction {
  static String getRouteName(String route) {
    switch (route) {
      case PagesString.home:
        return S.of(Get.context!).home;
      case PagesString.fill:
        return S.of(Get.context!).fill;
      case PagesString.profile:
        return S.of(Get.context!).profile;
      default:
        return '';
    }
  }
}
