import 'package:get/get.dart';
import 'package:petro_one/features/fill/presentations/controllers/fill_controller.dart';

class FillBinding implements Bindings {
  @override
  void dependencies() {
    Get.lazyPut<FillController>(() => FillController());
  }
}
