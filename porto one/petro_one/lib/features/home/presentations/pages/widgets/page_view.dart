import 'package:flutter/material.dart';
import 'package:petro_one/common/resources/app_color.dart';
import 'package:petro_one/common/widgets/custom_elevated_button.dart';
import 'package:petro_one/common/widgets/custom_text.dart';
import 'package:sizer/sizer.dart';

class PageViewCrouse extends StatelessWidget {
  const PageViewCrouse({
    super.key,
    required this.title,
    required this.subtitle,
    this.textButton,
    this.onPressed,
  });
  final String title;
  final String subtitle;
  final String? textButton;
  final void Function()? onPressed;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        CustomElevatedButton(
          onPressed: onPressed,
          padding: const EdgeInsets.symmetric(
            horizontal: 10,
          ),
          color: AppColors.white,
          child: CustomText(
            fontWeight: FontWeight.w700,
            text: textButton ?? "",
            color: AppColors.primary,
          ),
        ),
        Column(
          children: [
            CustomText(
              color: AppColors.white,
              text: title,
              fontSize: 18.sp,
              textAlign: TextAlign.center,
            ),
            CustomText(
              color: AppColors.white,
              text: subtitle,
              textAlign: TextAlign.center,
            ),
          ],
        )
      ],
    );
  }
}
