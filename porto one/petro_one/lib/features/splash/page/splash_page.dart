import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:petro_one/common/utils/extension.dart';
import 'package:petro_one/features/splash/controller/splash_controller.dart';
import 'package:petro_one/generated/assets/assets.dart';
import 'package:sizer/sizer.dart';

class SplashPage extends StatelessWidget {
  const SplashPage({super.key});

  @override
  Widget build(BuildContext context) {
    return GetBuilder<SplashController>(
        init: SplashController(),
        builder: (controller) {
          return Scaffold(
            body: Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: <Widget>[
                  Image.asset(
                    Assets.assetsImagesPngLogo,
                    width: 50.w,
                  ),
                  3.h.sh,
                ],
              ),
            ),
          );
        });
  }
}
