import 'package:get/get.dart';
import 'package:petro_one/features/home/presentations/controllers/home_controller.dart';

class HomeBinding implements Bindings {
  @override
  void dependencies() {
    Get.lazyPut<HomeController>(() => HomeController());
  }
}
