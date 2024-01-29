import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:petro_one/common/routes/pages.dart';
import 'package:petro_one/common/utils/extension.dart';
import 'package:petro_one/common/widgets/drawer/my_drawer_controller.dart';
import 'package:petro_one/generated/assets/assets.dart';
import 'package:petro_one/generated/l10n.dart';
import 'package:sizer/sizer.dart';

class MyDrawer extends StatelessWidget {
  const MyDrawer({super.key});

  @override
  Widget build(BuildContext context) {
    return GetBuilder<MyDrawerController>(
      init: MyDrawerController(),
      builder: (controller) {
        controller.updateL();
        return Drawer(
          child: SingleChildScrollView(
            padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 10),
            physics: const BouncingScrollPhysics(),
            child: Column(
              children: [
                3.h.sh,
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    1.w.sw,
                    IconButton(
                      onPressed: () => Get.back(),
                      icon: Container(
                        padding: const EdgeInsets.all(3),
                        decoration: BoxDecoration(
                          border: Border.all(),
                          borderRadius: BorderRadius.circular(8),
                        ),
                        child: const Icon(Icons.close),
                      ),
                    ),
                  ],
                ),
                Padding(
                  padding: const EdgeInsets.all(18.0),
                  child: Image.asset(
                    Assets.assetsImagesPngLogo,
                  ),
                ),
                2.h.sh,

                /// ---------------------------------
                ListTile(
                  contentPadding:
                      const EdgeInsets.symmetric(vertical: 10, horizontal: 10),
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(15)),
                  tileColor: controller.getStyle(PagesString.home).$2,
                  leading: Icon(
                    Icons.home_outlined,
                    color: controller.getStyle(PagesString.home).$1,
                  ),
                  onTap: () => controller.navTo(PagesString.home),
                  title: Text(
                    S.of(context).home,
                    style: Theme.of(context)
                        .listTileTheme
                        .titleTextStyle
                        ?.copyWith(
                            color: controller.getStyle(PagesString.home).$1),
                  ),
                ),
                1.h.sh,
                ListTile(
                  contentPadding:
                      const EdgeInsets.symmetric(vertical: 10, horizontal: 10),
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(15)),
                  tileColor: controller.getStyle(PagesString.fill).$2,
                  leading: Icon(
                    Icons.local_gas_station_outlined,
                    color: controller.getStyle(PagesString.fill).$1,
                  ),
                  onTap: () => controller.navTo(PagesString.fill),
                  title: Text(
                    S.of(context).fill,
                    style: Theme.of(context)
                        .listTileTheme
                        .titleTextStyle
                        ?.copyWith(
                            color: controller.getStyle(PagesString.fill).$1),
                  ),
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}
