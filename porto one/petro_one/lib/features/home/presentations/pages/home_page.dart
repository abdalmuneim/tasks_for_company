import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:petro_one/common/utils/extension.dart';
import 'package:petro_one/common/widgets/appbar/app_bar_controller.dart';
import 'package:petro_one/common/widgets/appbar/custom_app_bar.dart';
import 'package:petro_one/common/widgets/custom_text.dart';
import 'package:petro_one/common/widgets/drawer/my_drawer.dart';
import 'package:petro_one/features/home/presentations/controllers/home_controller.dart';
import 'package:petro_one/features/home/presentations/pages/widgets/user.dart';
import 'package:petro_one/features/home/presentations/pages/widgets/worker.dart';
import 'package:petro_one/generated/l10n.dart';
import 'package:sizer/sizer.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return GetBuilder<HomeController>(
      builder: (HomeController controller) {
        return Scaffold(
            key: AppBarController.to.scaffoldKey,
            drawer: const MyDrawer(),
            appBar: const CustomAppBar(),
            body: FutureBuilder(
                future: AppBarController.to.getUserData(),
                builder: (context, snapshot) {
                  if (snapshot.hasData) {
                    return _getUserType(
                        AppBarController.to.user?.accountType, controller);
                  } else {
                    return 0.w.sw;
                  }
                }));
      },
    );
  }

  Widget _getUserType(String? value, HomeController controller) {
    switch (value) {
      case '1':
        return User(controller: controller);
      case '2':
        return WorkerWidget(controller: controller);
      default:
        return Center(
          child: CustomText(text: S.of(Get.context!).notFound),
        );
    }
  }
}
