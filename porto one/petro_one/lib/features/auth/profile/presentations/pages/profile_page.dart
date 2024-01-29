import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:petro_one/common/resources/app_color.dart';
import 'package:petro_one/common/widgets/appbar/app_bar_controller.dart';
import 'package:petro_one/common/widgets/appbar/custom_app_bar.dart';
import 'package:petro_one/common/widgets/custom_text.dart';
import 'package:petro_one/common/widgets/drawer/my_drawer.dart';
import 'package:petro_one/features/auth/profile/presentations/controllers/profile_controller.dart';
import 'package:petro_one/generated/l10n.dart';
import 'package:sizer/sizer.dart';

class ProfilePage extends StatelessWidget {
  const ProfilePage({super.key});

  @override
  Widget build(BuildContext context) {
    return GetBuilder<ProfileController>(
        init: ProfileController(),
        builder: (controller) {
          return Scaffold(
            key: AppBarController.to.scaffoldKey,
            drawer: const MyDrawer(),
            appBar: const CustomAppBar(),
            body: SingleChildScrollView(
                child: Container(
              padding: const EdgeInsets.all(16),
              alignment: Get.locale?.languageCode == 'ar'
                  ? Alignment.topRight
                  : Alignment.topLeft,
              color: AppColors.white,
              margin: const EdgeInsets.all(20),
              height: 100.h,
              width: 100.w,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  CustomText(
                    text: S.of(context).profile,
                    fontWeight: FontWeight.bold,
                    fontSize: 14.sp,
                  ),
                  Row(
                    children: [
                      CustomText(
                        text: '${controller.previousRoute} ',
                      ),
                      CustomText(
                        text: '/ ${S.of(context).profile}',
                        color: AppColors.black.withOpacity(.5),
                      ),
                    ],
                  ),
                ],
              ),
            )),
          );
        });
  }
}
