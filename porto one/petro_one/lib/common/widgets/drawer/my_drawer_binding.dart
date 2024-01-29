import 'package:get/get.dart';
import 'package:petro_one/common/widgets/drawer/my_drawer_controller.dart';

class MyDrawerBinding implements Bindings {
  @override
  void dependencies() {
    Get.lazyPut<MyDrawerController>(() => MyDrawerController());
  }
}
