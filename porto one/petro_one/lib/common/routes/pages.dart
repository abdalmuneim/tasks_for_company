import 'package:get/get.dart';
import 'package:petro_one/common/widgets/appbar/app_bar_binding.dart';
import 'package:petro_one/common/widgets/drawer/my_drawer_binding.dart';
import 'package:petro_one/features/auth/presentations/bindings/login_binding.dart';
import 'package:petro_one/features/auth/presentations/pages/login_page.dart';
import 'package:petro_one/features/auth/profile/presentations/bindings/profile_binding.dart';
import 'package:petro_one/features/auth/profile/presentations/pages/profile_page.dart';
import 'package:petro_one/features/fill/presentations/bindings/fill_binding.dart';
import 'package:petro_one/features/fill/presentations/pages/fill_page.dart';
import 'package:petro_one/features/home/presentations/bindings/home_binding.dart';
import 'package:petro_one/features/home/presentations/pages/home_page.dart';
import 'package:petro_one/features/splash/binding/splash_binding.dart';
import 'package:petro_one/features/splash/page/splash_page.dart';
part 'pages_string.dart';

abstract class AppPages {
  static final pages = [
    /// initial
    GetPage(
      name: PagesString.initial,
      page: () => const SplashPage(),
      binding: SplashBinding(),
    ),

    /// login
    GetPage(
      name: PagesString.login,
      page: () => const LoginPage(),
      binding: LoginBinding(),
    ),

    /// ForgetPassword
    /* GetPage(
      name: PagesString.forgetPassword,
      page: () => const ForgetPasswordPage(),
      binding: ForgetPasswordBinding(),
    ), */

    /// home
    GetPage(
        name: PagesString.home,
        page: () => const HomePage(),
        binding: HomeBinding(),
        bindings: [
          AppBarBinding(),
        ]),
    GetPage(
        name: PagesString.fill,
        page: () => const FillPage(),
        binding: FillBinding(),
        bindings: [
          AppBarBinding(),
          MyDrawerBinding(),
        ]),
    GetPage(
        name: PagesString.profile,
        page: () => const ProfilePage(),
        binding: ProfileBinding(),
        bindings: [
          AppBarBinding(),
          MyDrawerBinding(),
        ]),
  ];
}
