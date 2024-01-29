import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:petro_one/common/resources/app_color.dart';
import 'package:petro_one/common/utils/extension.dart';
import 'package:petro_one/common/widgets/appbar/app_bar_controller.dart';
import 'package:petro_one/common/widgets/custom_elevated_button.dart';
import 'package:petro_one/common/widgets/custom_stepper.dart';
import 'package:petro_one/common/widgets/custom_text.dart';
import 'package:petro_one/features/home/presentations/controllers/home_controller.dart';
import 'package:petro_one/features/home/presentations/pages/widgets/page_view.dart';
import 'package:petro_one/generated/assets/assets.dart';
import 'package:petro_one/generated/l10n.dart';
import 'package:qr_flutter/qr_flutter.dart';
import 'package:sizer/sizer.dart';

class User extends StatelessWidget {
  const User({super.key, required this.controller});
  final HomeController controller;
  @override
  Widget build(BuildContext context) {
    return ListView(
      physics: const BouncingScrollPhysics(),
      children: [
        Padding(
          padding: const EdgeInsets.all(10),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              2.h.sh,
              CustomText(
                text: S.of(context).home,
                fontWeight: FontWeight.bold,
                fontSize: 22,
              ),
              2.h.sh,

              /// user data and qr code
              Container(
                padding:
                    const EdgeInsets.symmetric(horizontal: 10, vertical: 8),
                decoration: BoxDecoration(
                  color: AppColors.white,
                  border: Border.all(width: .1, color: AppColors.dark3),
                  borderRadius: BorderRadius.circular(20),
                ),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    ListTile(
                      leading: const CircleAvatar(
                        backgroundImage: AssetImage(
                          Assets.assetsImagesPngProfile2,
                        ),
                      ),
                      title: Text(
                        AppBarController.to.user?.name ?? "",
                        style: Theme.of(context)
                            .listTileTheme
                            .titleTextStyle
                            ?.copyWith(
                                fontSize: 14.sp, fontWeight: FontWeight.normal),
                      ),
                    ),
                    2.h.sh,
                    CustomElevatedButton(
                      onPressed: () {
                        Get.dialog(
                            barrierDismissible: false,
                            Dialog(
                              insetPadding:
                                  const EdgeInsets.symmetric(horizontal: 15),
                              shape: RoundedRectangleBorder(
                                  side: const BorderSide(
                                      color: AppColors.white, width: .3),
                                  borderRadius: BorderRadius.circular(20)),
                              child: Column(
                                mainAxisSize: MainAxisSize.min,
                                crossAxisAlignment: CrossAxisAlignment.center,
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  AppBar(
                                    shape: const RoundedRectangleBorder(
                                        borderRadius: BorderRadius.only(
                                            topLeft: Radius.circular(20),
                                            topRight: Radius.circular(20))),
                                    title: Text(
                                      S.of(context).qrCode,
                                      style: Theme.of(context)
                                          .textTheme
                                          .bodyLarge
                                          ?.copyWith(color: AppColors.white),
                                    ),
                                    backgroundColor: Colors.green,
                                    leading: IconButton(
                                      onPressed: () => Get.back(),
                                      icon: Container(
                                        padding: const EdgeInsets.all(6),
                                        decoration: BoxDecoration(
                                            border: Border.all(
                                                color: AppColors.white),
                                            shape: BoxShape.circle),
                                        child: const Icon(
                                          Icons.close,
                                          color: AppColors.white,
                                        ),
                                      ),
                                    ),
                                  ),
                                  2.h.sh,
                                  Center(
                                    child: Container(
                                      alignment: Alignment.center,
                                      width: 70.w,
                                      height: 20.h,
                                      margin: const EdgeInsets.symmetric(
                                          vertical: 16),
                                      decoration: BoxDecoration(
                                        borderRadius: BorderRadius.circular(20),
                                        border: Border.all(
                                          width: .5,
                                          color:
                                              AppColors.dark4.withOpacity(.5),
                                        ),
                                      ),
                                      child: QrImageView(
                                        padding: const EdgeInsets.symmetric(
                                            vertical: 10.0),
                                        data:
                                            '${AppBarController.to.user?.name}\n${AppBarController.to.user?.email}',
                                        version: QrVersions.auto,
                                        size: 30.w,
                                        gapless: false,
                                        embeddedImageStyle:
                                            const QrEmbeddedImageStyle(
                                          size: Size(80, 80),
                                        ),
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            ));
                      },
                      minimumSize: Size(40.w, 45),
                      maximumSize: Size(40.w, 45),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          Image.asset(Assets.assetsImagesPngQrCode, width: 25),
                          CustomText(
                            text: S.of(context).myQrCode,
                            color: AppColors.white,
                            fontWeight: FontWeight.w700,
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
              2.h.sh,
              Container(
                padding:
                    const EdgeInsets.symmetric(horizontal: 10, vertical: 8),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(20),
                  color: AppColors.lightYellow,
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Expanded(
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          2.h.sh,
                          CustomText(
                            text: S.of(context).remainingToAchieveGoal509Liter,
                            color: AppColors.lightBlue.withOpacity(.5),
                          ),
                          2.h.sh,
                          Column(
                            children: [
                              LinearProgressIndicator(
                                  borderRadius: BorderRadius.circular(100),
                                  value: 100,
                                  minHeight: 2.h,
                                  backgroundColor:
                                      AppColors.green.withOpacity(.5),
                                  valueColor: AlwaysStoppedAnimation(
                                      Theme.of(context).dividerTheme.color)),
                              2.h.sh,
                              CustomText(
                                textAlign: TextAlign.center,
                                text: '201.8%',
                                fontSize: 22.sp,
                                fontWeight: FontWeight.bold,
                                color: AppColors.green.withOpacity(.5),
                              ),
                              2.h.sh,
                            ],
                          ),
                        ],
                      ),
                    ),
                    3.w.sw,
                    Image.asset(
                      Assets.assetsImagesPngFuel,
                      width: 20.w,
                    ),
                  ],
                ),
              ),
              2.h.sh,
              Container(
                alignment: Alignment.bottomCenter,
                padding:
                    const EdgeInsets.symmetric(horizontal: 10, vertical: 8),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(20),
                  color: AppColors.primary,
                ),
                height: 20.h,
                child: Stack(
                  alignment: Alignment.bottomCenter,
                  children: [
                    PageView(
                      controller: controller.pageController,
                      onPageChanged: controller.pageViewChange,
                      physics: const BouncingScrollPhysics(),
                      children: [
                        PageViewCrouse(
                            title: 'إربح حتي 100 ريال إضافية إسبوعيا',
                            subtitle: 'إربح حتي 100 ريال إضافية إسبوعيا',
                            textButton: S.of(context).monthlyBonus),
                        PageViewCrouse(
                            title: 'إربح حتي 100 ريال إضافية إسبوعيا',
                            subtitle: 'إربح حتي 100 ريال إضافية إسبوعيا',
                            textButton: S.of(context).weeklyBonus),
                        PageViewCrouse(
                            title: 'إربح حتي 100 ريال إضافية إسبوعيا',
                            subtitle: 'إربح حتي 100 ريال إضافية إسبوعيا',
                            textButton: S.of(context).dailyBonus),
                      ],
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: List.generate(
                        3,
                        (index) => InkWell(
                          onTap: () => controller.onTapNext(index),
                          borderRadius: BorderRadius.circular(100),
                          child: Chip(
                            visualDensity: VisualDensity.comfortable,
                            label: CustomText(
                              textAlign: TextAlign.center,
                              text: (index + 1).toString(),
                            ),
                          ),
                        ),
                      ).toList(),
                    )
                  ],
                ),
              ),
              2.h.sh,
              Image.asset(
                Assets.assetsImagesPngTag,
              ),
              2.h.sh,
              const Divider(),
            ],
          ),
        ),
        2.h.sh,
        Container(
          height: 22.h,
          width: 100.w,
          alignment: Alignment.bottomCenter,
          padding: EdgeInsets.only(
              left: Get.locale?.languageCode == 'ar' ? 0 : 18,
              top: 18,
              right: Get.locale?.languageCode == 'ar' ? 18 : 0,
              bottom: 18),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(20),
            color: AppColors.white,
          ),
          child: Column(
            children: [
              Expanded(
                child: CustomStepper(
                  size: 10.w,
                  notActiveColor: AppColors.black.withOpacity(.2),
                  activeColor: AppColors.primary,
                  padding: EdgeInsets.zero,
                  shrinkWrap: false,
                  direction: Axis.horizontal,
                  currentStep: controller.activeStep,
                  steps: stepOne(controller.activeStep),
                  stepsDetails: stepDetails(controller.activeStep),
                ),
              ),
            ],
          ),
        ),
        5.h.sh,
      ],
    );
  }

  stepOne(int activeStep) => [
        const StepWidget(),
        const StepWidget(),
        const StepWidget(),
        const StepWidget(),
        const StepWidget(),
        CustomText(
          text: '6',
          fontSize: 10.sp,
          fontWeight: FontWeight.bold,
          color: AppColors.white,
          textAlign: TextAlign.center,
        )
      ];

  stepDetails(int activeStep) => [
        StepWidgetDetails(title: S.of(Get.context!).firstGoal),
         StepWidgetDetails(title: S.of(Get.context!).secondGoal),
         StepWidgetDetails(title: S.of(Get.context!).thirdGoal),
         StepWidgetDetails(title: S.of(Get.context!).fourthGoal),
         StepWidgetDetails(title: S.of(Get.context!).fifthGoal),
         StepWidgetDetails(title: S.of(Get.context!).sixthGoal),
      ];
}

class StepWidgetDetails extends StatelessWidget {
  const StepWidgetDetails({
    super.key,
    required this.title,
  });
  final String title;
  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        CustomText(
          text: title,
          fontSize: 10.sp,
          fontWeight: FontWeight.bold,
        ),
        CustomText(
          text: S.of(Get.context!).literLiter(500),
          color: AppColors.red,
        ),
        2.h.sh,
        CustomElevatedButton(
          child: CustomText(
            text: '${S.of(context).literLiter(10)} +',
            color: AppColors.white,
          ),
        ),
      ],
    );
  }
}

class StepWidget extends StatelessWidget {
  const StepWidget({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return const Icon(
      Icons.check,
      color: AppColors.white,
    );
  }
}
