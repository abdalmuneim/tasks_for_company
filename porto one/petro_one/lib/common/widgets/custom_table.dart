import 'package:data_table_2/data_table_2.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:petro_one/common/resources/app_color.dart';
import 'package:sizer/sizer.dart';

class CustomTable extends StatelessWidget {
  const CustomTable({super.key, required this.columns, required this.rows});
  final List<DataColumn> columns;
  final List<DataRow> rows;

  @override
  Widget build(BuildContext context) {
    return DataTable2(
      dataTextStyle: GoogleFonts.cairo(
        fontSize: 3.sp,
      ),
      columnSpacing: 15,
      minWidth: 100.w,
      headingRowColor:
          MaterialStateColor.resolveWith((states) => AppColors.green),
      headingTextStyle: GoogleFonts.cairo(color: Colors.white),
      headingCheckboxTheme: const CheckboxThemeData(
          side: BorderSide(color: Colors.white, width: 2.0)),
      checkboxAlignment: Alignment.topRight,
      isHorizontalScrollBarVisible: true,
      isVerticalScrollBarVisible: true,
      horizontalScrollController: ScrollController(),
      scrollController: ScrollController(),
      columns: columns,
      rows: rows,
    );
  }
}
