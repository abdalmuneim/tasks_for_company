import 'package:data_table_2/data_table_2.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:petro_one/common/resources/app_color.dart';
import 'package:petro_one/common/utils/extension.dart';
import 'package:petro_one/common/widgets/appbar/app_bar_controller.dart';
import 'package:petro_one/common/widgets/appbar/custom_app_bar.dart';
import 'package:petro_one/common/widgets/custom_elevated_button.dart';
import 'package:petro_one/common/widgets/custom_table.dart';
import 'package:petro_one/common/widgets/custom_text.dart';
import 'package:petro_one/common/widgets/drawer/my_drawer.dart';
import 'package:petro_one/features/fill/presentations/controllers/fill_controller.dart';
import 'package:petro_one/generated/l10n.dart';
import 'package:sizer/sizer.dart';

class FillPage extends StatelessWidget {
  const FillPage({super.key});

  @override
  Widget build(BuildContext context) {
    return GetBuilder<FillController>(
        init: FillController(),
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
                    text: S.of(context).allMyFills,
                    fontWeight: FontWeight.bold,
                    fontSize: 14.sp,
                  ),
                  Row(
                    children: [
                      CustomText(
                        text: controller.previousRoute,
                      ),
                      CustomText(
                        text: '/ ${S.of(context).allMyFills}',
                        color: AppColors.black.withOpacity(.5),
                      ),
                    ],
                  ),
                  2.h.sh,
                  Expanded(
                    child: CustomTable(
                      columns: titleItems(context),
                      rows: List.generate(20, (index) => dataRow(index)),
                    ),
                  ),
                ],
              ),
            )),
          );
        });
  }

  List<DataColumn> titleItems(BuildContext context) {
    return [
      DataColumn2(
          numeric: true,
          tooltip: S.of(context).petrolType,
          label: Text(S.of(context).petrolType),
          size: ColumnSize.L),
      DataColumn2(
          numeric: true,
          tooltip: S.of(context).gasStation,
          label: Text(S.of(context).gasStation),
          size: ColumnSize.L),
      DataColumn2(
          numeric: true,
          tooltip: S.of(context).worker,
          label: Text(S.of(context).worker),
          size: ColumnSize.L),
      DataColumn2(
          numeric: true,
          tooltip: S.of(context).liters,
          label: Text(S.of(context).liters),
          size: ColumnSize.L),
      DataColumn2(
          numeric: true,
          tooltip: S.of(context).totalPayment,
          label: Text(S.of(context).totalPayment),
          size: ColumnSize.L),
      DataColumn2(
          numeric: true,
          tooltip: S.of(context).date,
          label: Text(S.of(context).date),
          size: ColumnSize.L),
    ];
  }

  DataRow2 dataRow(int index) {
    return DataRow2(
      cells: [
        DataCell(CustomElevatedButton(
            side: const BorderSide(width: .5),
            color: AppColors.mainTints.withOpacity(.5),
            child: CustomText(color: AppColors.green, text: '$index'))),
        DataCell(CustomText(color: AppColors.green, text: '$index')),
        DataCell(CustomText(color: AppColors.green, text: '$index')),
        DataCell(CustomText(color: AppColors.green, text: '$index')),
        DataCell(CustomText(color: AppColors.green, text: '$index')),
        DataCell(CustomText(
            color: AppColors.green,
            text: DateFormat.yMMMEd().format(DateTime.now()))),
      ],
    );
  }
}
