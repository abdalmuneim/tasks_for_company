import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:petro_one/common/resources/app_color.dart';
import 'package:sizer/sizer.dart';

ThemeData get applicationThemeDark => ThemeData(
      scaffoldBackgroundColor: AppColors.scaffoldColor1,

      /// Main Color
      primaryColor: AppColors.black,
      primaryColorLight: AppColors.white,
      primaryColorDark: Colors.black,
      disabledColor: Colors.grey,

      /// CheckboxThemeData
      checkboxTheme: const CheckboxThemeData(
        fillColor: MaterialStatePropertyAll(AppColors.grey),
        side: BorderSide(color: AppColors.green),
        visualDensity: VisualDensity.comfortable,
      ),
      dataTableTheme: DataTableThemeData(
        dataTextStyle: GoogleFonts.cairo(
          fontSize: 8.sp,
          fontWeight: FontWeight.bold,
          color: Colors.white,
        ),
        headingTextStyle: GoogleFonts.cairo(
          fontSize: 8.sp,
          fontWeight: FontWeight.bold,
          color: Colors.white,
        ),
      ),

      /// listTileTheme
      listTileTheme: ListTileThemeData(
        minLeadingWidth: 12,
        dense: true,
        visualDensity: VisualDensity.comfortable,
        contentPadding: EdgeInsets.only(left: 2.w),
        iconColor: AppColors.white,
        minVerticalPadding: 0,
        titleTextStyle: GoogleFonts.cairo(
          fontSize: 14.sp,
          fontWeight: FontWeight.bold,
          color: AppColors.white,
        ),
        subtitleTextStyle: GoogleFonts.cairo(
          fontSize: 8.sp,
          fontWeight: FontWeight.w100,
          color: AppColors.grey,
        ),
      ),

      /// tab bar theme
      tabBarTheme: TabBarTheme(
        labelStyle: GoogleFonts.cairo(
          fontSize: 10.sp,
          fontWeight: FontWeight.bold,
          color: Colors.white,
        ),
        unselectedLabelStyle: GoogleFonts.cairo(
          fontSize: 10.sp,
          fontWeight: FontWeight.bold,
          color: Colors.white,
        ),
      ),

      /// iconButtonTheme
      iconButtonTheme: const IconButtonThemeData(
        style: ButtonStyle(iconSize: MaterialStatePropertyAll(20)),
      ),

      /// textButtonTheme
      textButtonTheme: TextButtonThemeData(
        style: ButtonStyle(
          textStyle: MaterialStatePropertyAll(
            GoogleFonts.cairo(
              fontSize: 10.sp,
              fontWeight: FontWeight.bold,
              color: AppColors.primary,
            ),
          ),
        ),
      ),

      /// CardTheme
      cardTheme: CardTheme(
        color: AppColors.dark4.withOpacity(.2),
        elevation: 3,
        shape: const RoundedRectangleBorder(
            borderRadius: BorderRadius.all(Radius.circular(10))),
      ),
      dropdownMenuTheme: const DropdownMenuThemeData(
          inputDecorationTheme: InputDecorationTheme(
              fillColor: AppColors.white,
              filled: true,
              border: InputBorder.none,
              enabledBorder: InputBorder.none,
              disabledBorder: InputBorder.none)),

      /// dividerTheme
      dividerTheme: DividerThemeData(color: AppColors.white.withOpacity(.3)),

      /// progressIndicatorTheme
      progressIndicatorTheme:
          const ProgressIndicatorThemeData(color: AppColors.primary),

      /// floatingActionButtonTheme
      floatingActionButtonTheme:
          const FloatingActionButtonThemeData(backgroundColor: AppColors.green),

      /// switchTheme
      switchTheme: const SwitchThemeData(
        materialTapTargetSize: MaterialTapTargetSize.padded,
        trackColor: MaterialStatePropertyAll(AppColors.scaffoldColor2),
        trackOutlineColor: MaterialStatePropertyAll(AppColors.dark3),
      ),

      /// AppBar Theme
      appBarTheme: AppBarTheme(
        systemOverlayStyle: const SystemUiOverlayStyle(
          statusBarBrightness: Brightness.light,
          statusBarColor: Colors.transparent,
          statusBarIconBrightness: Brightness.light,
        ),
        backgroundColor: AppColors.white,
        elevation: 1,
        titleSpacing: 0,
        titleTextStyle: GoogleFonts.cairo(
          fontSize: 14.sp,
          fontWeight: FontWeight.bold,
          color: AppColors.white,
        ),
        centerTitle: false,
        iconTheme: const IconThemeData(color: AppColors.white, size: 20),
      ),

      /// drawer
      drawerTheme: const DrawerThemeData(backgroundColor: AppColors.white),

      /// Elevated Button Theme
      elevatedButtonTheme: ElevatedButtonThemeData(
        style: ElevatedButton.styleFrom(
          padding: EdgeInsets.zero,
          minimumSize: Size(20.w, 35),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(10),
          ),
          textStyle: GoogleFonts.cairo(
            fontSize: 12.sp,
            fontWeight: FontWeight.w600,
            color: AppColors.white,
          ),
          backgroundColor: AppColors.green,
        ),
      ),

      /// Text Theme
      textTheme: TextTheme(
        //
        headlineLarge: GoogleFonts.cairo(
            fontSize: 22.sp, fontWeight: FontWeight.bold, color: Colors.white),

        headlineMedium: GoogleFonts.cairo(
          fontSize: 20.sp,
          fontWeight: FontWeight.bold,
          color: Colors.white,
        ),
        headlineSmall: GoogleFonts.cairo(
          fontSize: 16.sp,
          fontWeight: FontWeight.w600,
          color: Colors.white,
        ),
        titleLarge: GoogleFonts.cairo(
          fontSize: 12.sp,
          fontWeight: FontWeight.bold,
          color: Colors.white,
        ),
        labelLarge: GoogleFonts.cairo(
          fontSize: 11.sp,
          fontWeight: FontWeight.bold,
          color: Colors.white,
        ),
        labelMedium: GoogleFonts.cairo(
          fontSize: 11.sp,
          fontWeight: FontWeight.w500,
          color: Colors.white,
        ),
        labelSmall: GoogleFonts.cairo(
          fontSize: 11.sp,
          fontWeight: FontWeight.w400,
          color: Colors.white,
        ),
        bodyMedium: GoogleFonts.cairo(
          fontSize: 10.sp,
          fontWeight: FontWeight.w500,
          color: Colors.white,
        ),
        bodySmall: GoogleFonts.cairo(
          fontSize: 10.sp,
          fontWeight: FontWeight.w400,
          color: Colors.white,
        ),
      ),

      /// text form field
      inputDecorationTheme: InputDecorationTheme(
        errorBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(10),
          borderSide: const BorderSide(color: AppColors.red),
        ),
        fillColor: AppColors.white.withOpacity(.1),
        hintStyle: GoogleFonts.cairo(color: AppColors.lightGreen),
        contentPadding: const EdgeInsets.symmetric(horizontal: 10),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(10),
          borderSide: const BorderSide(width: .2, color: AppColors.dark3),
        ),
        suffixIconColor: AppColors.black,
        prefixIconColor: AppColors.black,
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(10),
          borderSide: const BorderSide(width: .2, color: AppColors.dark3),
        ),
      ),

      /// iconTheme
      iconTheme: const IconThemeData(
        color: AppColors.white,
        size: 20,
      ),
    );

ThemeData get applicationThemeLight => ThemeData(
      scaffoldBackgroundColor: AppColors.scaffoldColor2,

      /// Main Color
      primaryColor: AppColors.white,
      primaryColorLight: AppColors.white,
      primaryColorDark: Colors.black,
      disabledColor: Colors.grey,

      /// CheckboxThemeData
      checkboxTheme: const CheckboxThemeData(
        fillColor: MaterialStatePropertyAll(AppColors.grey),
        side: BorderSide(color: AppColors.green),
        visualDensity: VisualDensity.comfortable,
      ),
      dataTableTheme: DataTableThemeData(
        dataTextStyle: GoogleFonts.cairo(
          fontSize: 8.sp,
          fontWeight: FontWeight.bold,
          color: Colors.black,
        ),
        headingTextStyle: GoogleFonts.cairo(
          fontSize: 8.sp,
          fontWeight: FontWeight.bold,
          color: Colors.black,
        ),
      ),

      /// listTileTheme
      listTileTheme: ListTileThemeData(
        minLeadingWidth: 12,
        dense: true,
        visualDensity: VisualDensity.comfortable,
        contentPadding: EdgeInsets.only(left: 2.w),
        iconColor: AppColors.black,
        minVerticalPadding: 0,
        titleTextStyle: GoogleFonts.cairo(
          fontSize: 14.sp,
          fontWeight: FontWeight.bold,
          color: AppColors.black,
        ),
        subtitleTextStyle: GoogleFonts.cairo(
          fontSize: 8.sp,
          fontWeight: FontWeight.w100,
          color: AppColors.grey,
        ),
      ),

      /// tab bar theme
      tabBarTheme: TabBarTheme(
        labelStyle: GoogleFonts.cairo(
          fontSize: 10.sp,
          fontWeight: FontWeight.bold,
          color: Colors.white,
        ),
        unselectedLabelStyle: GoogleFonts.cairo(
          fontSize: 10.sp,
          fontWeight: FontWeight.bold,
          color: Colors.white,
        ),
      ),

      /// iconButtonTheme
      iconButtonTheme: const IconButtonThemeData(
        style: ButtonStyle(iconSize: MaterialStatePropertyAll(20)),
      ),

      /// textButtonTheme
      textButtonTheme: TextButtonThemeData(
        style: ButtonStyle(
          textStyle: MaterialStatePropertyAll(
            GoogleFonts.cairo(
              fontSize: 10.sp,
              fontWeight: FontWeight.bold,
              color: AppColors.primary,
            ),
          ),
        ),
      ),

      /// CardTheme
      cardTheme: CardTheme(
        color: AppColors.dark4.withOpacity(.2),
        elevation: 3,
        shape: const RoundedRectangleBorder(
            borderRadius: BorderRadius.all(Radius.circular(10))),
      ),
      dropdownMenuTheme: const DropdownMenuThemeData(
          inputDecorationTheme: InputDecorationTheme(
              fillColor: AppColors.white,
              filled: true,
              border: InputBorder.none,
              enabledBorder: InputBorder.none,
              disabledBorder: InputBorder.none)),

      /// dividerTheme
      dividerTheme: DividerThemeData(color: AppColors.black.withOpacity(.3)),

      /// progressIndicatorTheme
      progressIndicatorTheme:
          const ProgressIndicatorThemeData(color: AppColors.primary),

      /// floatingActionButtonTheme
      floatingActionButtonTheme:
          const FloatingActionButtonThemeData(backgroundColor: AppColors.green),

      /// switchTheme
      switchTheme: const SwitchThemeData(
        materialTapTargetSize: MaterialTapTargetSize.padded,
        trackColor: MaterialStatePropertyAll(AppColors.scaffoldColor2),
        trackOutlineColor: MaterialStatePropertyAll(AppColors.dark3),
      ),

      /// AppBar Theme
      appBarTheme: AppBarTheme(
        systemOverlayStyle: const SystemUiOverlayStyle(
          statusBarBrightness: Brightness.light,
          statusBarColor: Colors.transparent,
          statusBarIconBrightness: Brightness.light,
        ),
        backgroundColor: AppColors.white,
        elevation: 1,
        titleSpacing: 0,
        titleTextStyle: GoogleFonts.cairo(
          fontSize: 14.sp,
          fontWeight: FontWeight.bold,
          color: AppColors.black,
        ),
        centerTitle: false,
        iconTheme: const IconThemeData(color: AppColors.black, size: 20),
      ),

      /// drawer
      drawerTheme: const DrawerThemeData(backgroundColor: AppColors.white),

      /// Elevated Button Theme
      elevatedButtonTheme: ElevatedButtonThemeData(
        style: ElevatedButton.styleFrom(
          padding: EdgeInsets.zero,
          minimumSize: Size(20.w, 35),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(10),
          ),
          textStyle: GoogleFonts.cairo(
            fontSize: 12.sp,
            fontWeight: FontWeight.w600,
            color: AppColors.white,
          ),
          backgroundColor: AppColors.green,
        ),
      ),

      /// Text Theme
      textTheme: TextTheme(
        //
        headlineLarge: GoogleFonts.cairo(
            fontSize: 22.sp, fontWeight: FontWeight.bold, color: Colors.black),

        headlineMedium: GoogleFonts.cairo(
          fontSize: 20.sp,
          fontWeight: FontWeight.bold,
          color: Colors.black,
        ),
        headlineSmall: GoogleFonts.cairo(
          fontSize: 16.sp,
          fontWeight: FontWeight.w600,
          color: Colors.black,
        ),
        titleLarge: GoogleFonts.cairo(
          fontSize: 12.sp,
          fontWeight: FontWeight.bold,
          color: Colors.black,
        ),
        labelLarge: GoogleFonts.cairo(
          fontSize: 11.sp,
          fontWeight: FontWeight.bold,
          color: Colors.black,
        ),
        labelMedium: GoogleFonts.cairo(
          fontSize: 11.sp,
          fontWeight: FontWeight.w500,
          color: Colors.black,
        ),
        labelSmall: GoogleFonts.cairo(
          fontSize: 11.sp,
          fontWeight: FontWeight.w400,
          color: Colors.black,
        ),
        bodyMedium: GoogleFonts.cairo(
          fontSize: 10.sp,
          fontWeight: FontWeight.w500,
          color: Colors.white,
        ),
        bodySmall: GoogleFonts.cairo(
          fontSize: 10.sp,
          fontWeight: FontWeight.w400,
          color: Colors.black,
        ),
      ),

      /// text form field
      inputDecorationTheme: InputDecorationTheme(
        errorBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(10),
          borderSide: const BorderSide(color: AppColors.red),
        ),
        fillColor: AppColors.black.withOpacity(.1),
        hintStyle: GoogleFonts.cairo(color: AppColors.lightGreen),
        contentPadding: const EdgeInsets.symmetric(horizontal: 10),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(10),
          borderSide: const BorderSide(width: .2, color: AppColors.dark3),
        ),
        suffixIconColor: AppColors.black,
        prefixIconColor: AppColors.black,
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(10),
          borderSide: const BorderSide(width: .2, color: AppColors.dark3),
        ),
      ),

      /// iconTheme
      iconTheme: const IconThemeData(
        color: AppColors.black,
        size: 20,
      ),
    );
