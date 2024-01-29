import 'package:get/get.dart';
import 'package:petro_one/features/auth/profile/presentations/controllers/profile_controller.dart';

class ProfileBinding implements Bindings {
  @override
  void dependencies() {
    Get.lazyPut<ProfileController>(() => ProfileController());
  }
}
