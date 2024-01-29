import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:petro_one/common/resources/app_color.dart';
import 'package:petro_one/common/widgets/custom_text.dart';
import 'package:lottie/lottie.dart';
import 'package:petro_one/common/utils/extension.dart';
import 'package:shimmer/shimmer.dart';
import 'package:sizer/sizer.dart';
import 'package:fluttertoast/fluttertoast.dart';

class Utils {
  /// SHOW TOAST
  static showToast(
    String message, {
    ToastGravity? gravity = ToastGravity.BOTTOM,
    Toast? toastLength = Toast.LENGTH_SHORT,
    Color? backgroundColor = AppColors.black,
    Color? textColor = AppColors.white,
  }) {
    return Fluttertoast.showToast(
      msg: message,
      toastLength: toastLength, // Duration of the toast
      gravity: gravity, // Toast position
      timeInSecForIosWeb: 1, // Time for iOS/WEB
      backgroundColor: backgroundColor, // Background color of the toast
      textColor: textColor, // Text color of the toast
    );
  }

  /// SUCCESS NOTIFICATION
  static showSuccess(String message) {
    if (Get.isSnackbarOpen) {
      Get.closeAllSnackbars();
    }
    Get.rawSnackbar(
      message: message.tr,
      barBlur: 5,
      maxWidth: Get.width,
      backgroundColor:
          Get.isDarkMode ? AppColors.black : AppColors.white.withOpacity(.2),
      snackPosition: SnackPosition.TOP,
      // backgroundColor: ColorManager.green.withOpacity(0.7),
      padding: const EdgeInsets.symmetric(horizontal: 32, vertical: 16),
    );
  }

  /// ERROR NOTIFICATION
  static showError(String message) {
    if (Get.isSnackbarOpen) {
      Get.closeAllSnackbars();
    }
    Get.rawSnackbar(
      message: message,
      barBlur: 5,
      maxWidth: Get.width,
      backgroundColor: Colors.red,

      snackPosition: SnackPosition.TOP,
      // backgroundColor: ColorManager.red.withOpacity(0.7),
      padding: const EdgeInsets.symmetric(horizontal: 32, vertical: 16),
    );
  }

  static customBottomSheet({
    String? title,
    List<Widget>? children,
  }) {
    return Get.bottomSheet(
      shape: const RoundedRectangleBorder(
          borderRadius: BorderRadius.only(
              topLeft: Radius.circular(40), topRight: Radius.circular(40))),
      Container(
        padding: EdgeInsets.symmetric(horizontal: 3.w, vertical: 2.w),
        decoration: const BoxDecoration(
          color: AppColors.red,
          borderRadius: BorderRadius.only(
              topLeft: Radius.circular(40), topRight: Radius.circular(40)),
        ),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Text(
              title ?? "",
              style: Theme.of(Get.context!)
                  .textTheme
                  .headlineLarge
                  ?.copyWith(color: Colors.black),
            ),
            2.w.sh,
            if (children != null)
              Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: children),
          ],
        ),
      ),
      isDismissible: true,
      elevation: 0,
      enableDrag: false,
      backgroundColor: Colors.white,
    );
  }

  static showBottomSheet({
    String? title,
    List<String>? listData,
  }) {
    return Get.bottomSheet(
      shape: const RoundedRectangleBorder(
          borderRadius: BorderRadius.only(
              topLeft: Radius.circular(40), topRight: Radius.circular(40))),
      Container(
        padding: EdgeInsets.symmetric(horizontal: 3.w, vertical: 2.w),
        child: SingleChildScrollView(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Text(
                title ?? "",
                style: Theme.of(Get.context!)
                    .textTheme
                    .headlineLarge
                    ?.copyWith(color: Colors.black),
              ),
              2.w.sh,
              if (listData != null && listData.isNotEmpty)
                ...listData
                    .map((e) => Container(
                          width: 100.w,
                          padding: const EdgeInsets.all(8.0),
                          child: InkWell(
                              onTap: () {
                                Get.back(result: e);
                              },
                              child: CustomText(text: e)),
                        ))
                    .toList(),
            ],
          ),
        ),
      ),
      isDismissible: false,
      elevation: 0,
      enableDrag: false,
      backgroundColor: Colors.white,
    );
  }

  static showLottieDialog(
      {required String lottie, required String text, List<Widget>? action}) {
    Get.dialog(
      Dialog(
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
        child: WillPopScope(
          onWillPop: () async => false,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisSize: MainAxisSize.min,
            children: [
              LottieBuilder.asset(
                lottie,
              ),
              10.sh,
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Text(
                  text,
                  textAlign: TextAlign.center,
                ),
              ),
              20.sh,
              if (action != null) ...[
                Center(
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: action,
                  ),
                ),
                20.sh,
              ],
            ],
          ),
        ),
      ),
    );
  }

  static Widget buildShimmerEffect() {
    return Shimmer.fromColors(
      baseColor: AppColors.mainTints,
      highlightColor: AppColors.mainTints.withOpacity(.5),
      child: ListTile(
        leading: const CircleAvatar(),
        title: Container(
          height: 1.w,
          color: Colors.white,
        ),
        subtitle: Container(
          height: 2.w,
          color: Colors.white,
        ),
      ),
    );
  }

  Future<String?> displayDatePicker(
          {DateTime? initial, DateTime? selected}) async =>
      await showDialog(
        context: Get.context!,
        builder: (context) => Theme(
          data: Theme.of(context).copyWith(
            colorScheme: const ColorScheme.light(
              primary: AppColors.red,
            ),
          ),
          child: LayoutBuilder(
              builder: (_, constraints) => Center(
                    child: Material(
                      child: SizedBox(
                        width: constraints.maxWidth * 0.8,
                        child: CalendarDatePicker(
                          initialDate: selected ?? DateTime.now(),
                          firstDate: initial ?? DateTime.now(),
                          lastDate: DateTime(
                              DateTime.now().year, DateTime.now().month + 2),
                          onDateChanged: (DateTime value) {
                            Get.back(result: value);
                          },
                        ),
                      ),
                    ),
                  )),
        ),
      );
}
