import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:todowithmvc/utils/export.dart';

ThemeData appTheme() {
  return ThemeData(
      scaffoldBackgroundColor: Colors.white,
      appBarTheme: AppBarTheme(
        color: AppConstant.kBKDark,
        elevation: 1.0,
        centerTitle: true,
        titleTextStyle: TextStyle(fontSize: 20.sp),
      ),
      elevatedButtonTheme: ElevatedButtonThemeData(
        style: ElevatedButton.styleFrom(
          shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(10.sp)),
          backgroundColor: AppConstant.kBKDark,
          minimumSize: Size(double.infinity, 50.h),
        ),
      ),
      inputDecorationTheme: InputDecorationTheme(
          errorBorder: OutlineInputBorder(
              borderSide: const BorderSide(color: AppConstant.kRed),
              borderRadius: BorderRadius.circular(20.r)),
          border:
              OutlineInputBorder(borderRadius: BorderRadius.circular(20.r))));
}
