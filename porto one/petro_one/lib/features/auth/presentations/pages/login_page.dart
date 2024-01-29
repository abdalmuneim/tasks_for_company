import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:petro_one/common/helper/validator.dart';
import 'package:petro_one/common/resources/app_color.dart';
import 'package:petro_one/common/routes/pages.dart';
import 'package:petro_one/common/utils/extension.dart';
import 'package:petro_one/common/widgets/custom_elevated_button.dart';
import 'package:petro_one/common/widgets/custom_text.dart';
import 'package:petro_one/common/widgets/custom_text_form_field.dart';
import 'package:petro_one/features/auth/presentations/controllers/login_controller.dart';
import 'package:petro_one/generated/assets/assets.dart';
import 'package:petro_one/generated/l10n.dart';
import 'package:sizer/sizer.dart';

class LoginPage extends StatelessWidget {
  const LoginPage({super.key});

  @override
  Widget build(BuildContext context) {
    return GetBuilder<LoginController>(
      builder: (LoginController controller) {
        return Scaffold(
          body: Center(
            child: SingleChildScrollView(
              physics: const BouncingScrollPhysics(),
              padding: EdgeInsets.symmetric(horizontal: 8.w),
              child: Form(
                key: controller.globalKey,
                child: AutofillGroup(
                  child: Center(
                    child: Column(
                      children: [
                        SvgPicture.asset(
                          Assets.assetsImagesSvgLoginSvg,
                        ),
                        Container(
                          padding: const EdgeInsets.all(20),
                          decoration: BoxDecoration(
                            color: AppColors.white,
                            border:
                                Border.all(width: .5, color: AppColors.black),
                            borderRadius: BorderRadius.circular(20),
                          ),
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              Image.asset(
                                Assets.assetsImagesPngLogo,
                                width: 30.w,
                              ),
                              Text(
                                S.of(context).login,
                                style:
                                    Theme.of(context).textTheme.headlineLarge,
                              ),
                              3.h.sh,
                              CustomTextFormField(
                                autofillHints: const [AutofillHints.email],
                                labelText: S.of(context).email,
                                validator: (value) =>
                                    AppValidator.validateFields(
                                        value, ValidationType.email, context),
                                controller: controller.email,
                                labelAlign: TextAlign.start,
                                fillColor: AppColors.white,
                              ),
                              2.h.sh,
                              CustomTextFormField(
                                fillColor: AppColors.white,
                                obscureText: true,
                                autofillHints: const [AutofillHints.password],
                                labelAlign: TextAlign.start,
                                labelText: S.of(context).password,
                                validator: (value) =>
                                    AppValidator.validateFields(value,
                                        ValidationType.password, context),
                                controller: controller.password,
                              ),
                              TextButton(
                                onPressed: () =>
                                    Get.toNamed(PagesString.forgetPassword),
                                child: SizedBox(
                                  width: 100.w,
                                  child: CustomText(
                                    text: S.of(context).forgetPasswordQ,
                                    color: AppColors.primary,
                                    textAlign: TextAlign.start,
                                  ),
                                ),
                              ),
                              5.h.sh,
                              controller.loading
                                  ? const Center(
                                      child: CircularProgressIndicator(),
                                    )
                                  : CustomElevatedButton(
                                      minimumSize: Size(100.w, 56),
                                      onPressed: () => controller.login(),
                                      child: CustomText(
                                          color: AppColors.white,
                                          text: S.of(context).login),
                                    ),
                              2.h.sh,
                              Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                crossAxisAlignment: CrossAxisAlignment.center,
                                children: <Widget>[
                                  CustomText(
                                      text: S.of(context).notHaveAccount),
                                  TextButton(
                                      onPressed: () {},
                                      child: CustomText(
                                        text: S.of(context).createAccount,
                                        color: AppColors.primary,
                                      ))
                                ],
                              )
                            ],
                          ),
                        ),
                        5.h.sh,
                      ],
                    ),
                  ),
                ),
              ),
            ),
          ),
        );
      },
    );
  }
}
