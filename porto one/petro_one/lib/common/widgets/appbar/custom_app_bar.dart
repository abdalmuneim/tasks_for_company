import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:petro_one/common/resources/app_color.dart';
import 'package:petro_one/common/utils/extension.dart';
import 'package:petro_one/common/widgets/appbar/app_bar_controller.dart';
import 'package:petro_one/common/widgets/custom_drop_down_button.dart';
import 'package:petro_one/common/widgets/custom_text.dart';
import 'package:petro_one/generated/assets/assets.dart';
import 'package:petro_one/generated/l10n.dart';
import 'package:sizer/sizer.dart';

class CustomAppBar extends StatelessWidget implements PreferredSizeWidget {
  const CustomAppBar({
    Key? key,
    this.title,
    this.heightAppBar,
    this.leading,
    this.actions,
  }) : super(key: key);
  final String? title;
  final Widget? leading;
  final List<Widget>? actions;
  final double? heightAppBar;
  @override
  Widget build(BuildContext context) {
    return GetBuilder<AppBarController>(
        init: AppBarController(),
        builder: (controller) {
          return AppBar(
            centerTitle: true,
            actions: [
              Row(
                children: [
                  const CircleAvatar(
                      backgroundImage:
                          AssetImage(Assets.assetsImagesPngAvatar)),
                  2.w.sw,
                  SizedBox(
                    width: 30.w,
                    child: CustomDropDownButton<String>(
                      dropdownColor: AppColors.white,
                      fillColor: Theme.of(context).appBarTheme.backgroundColor,
                      hintStyle: Theme.of(context).textTheme.bodyLarge,
                      hintText: controller.user?.name,
                      itemColor: AppColors.black,
                      items: [S.of(context).profile, S.of(context).logout],
                      onChanged: (String? value) => controller.navTo(value),
                    ),
                  ),
                ],
              ),
              TextButton(
                onPressed: () => controller.changeLocalization(
                    controller.locale == 'ar' ? 'en' : 'ar'),
                child: Row(
                  children: [
                    const Icon(Icons.language),
                    1.w.sw,
                    CustomText(
                      text: S.of(context).locale(controller.locale),
                    ),
                  ],
                ),
              ),
            ],
            leading: IconButton(
              onPressed: () =>
                  controller.scaffoldKey.currentState?.openDrawer(),
              icon: SvgPicture.asset(
                Assets.assetsImagesSvgBarsStaggeredSolid,
                color: AppColors.black,
                width: 30,
              ),
            ),
          );
        });
  }

  @override
  Size get preferredSize => Size.fromHeight(heightAppBar ?? 56);
}
