import 'package:get/get.dart';
import 'package:petro_one/common/widgets/appbar/app_bar_controller.dart';

class AppBarBinding implements Bindings {
  @override
  void dependencies() {
    Get.lazyPut<AppBarController>(() => AppBarController());
  }
}
