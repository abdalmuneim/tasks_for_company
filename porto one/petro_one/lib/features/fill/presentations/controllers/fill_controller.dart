import 'package:get/get.dart';
import 'package:petro_one/common/helper/helper_function.dart';

class FillController extends GetxController {
  String get previousRoute => HelperFunction.getRouteName(Get.arguments);
}
