import 'package:get/get.dart';
import 'package:petro_one/features/auth/presentations/controllers/login_controller.dart';

class LoginBinding implements Bindings {
  @override
  void dependencies() {
    Get.lazyPut<LoginController>(() => LoginController());
  }
}
