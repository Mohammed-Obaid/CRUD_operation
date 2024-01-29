import 'package:crud_operations/app/core/app_color.dart';
import 'package:crud_operations/app/core/app_style.dart';
import 'package:crud_operations/app/core/app_string.dart';
import 'package:flutter/material.dart';

class AppTheme {
  //Declares a private constructor,
  //preventing direct instantiation of the class.
  //This ensures that it's only used for its static members.
  AppTheme._();

  static ThemeData lightAppTheme = ThemeData(
    appBarTheme: const AppBarTheme(
      color: AppColor.mainThemeColor,
      centerTitle: true,
    ),
    dialogTheme: const DialogTheme(
      shape: RoundedRectangleBorder(
        side: BorderSide(color: AppColor.mainThemeColor, width: 1.0),
        borderRadius: BorderRadius.all(
          Radius.circular(15.0),
        ),
      ),
    ),
    inputDecorationTheme: const InputDecorationTheme(
        enabledBorder: enabledBorder,
        focusedBorder: focusedBorder,
        errorBorder: errorBorder,
        border: inputBorder),
    elevatedButtonTheme: ElevatedButtonThemeData(
      style: ElevatedButton.styleFrom(
        backgroundColor:  AppColor.mainThemeColor,
      ),
    ),
    floatingActionButtonTheme: const FloatingActionButtonThemeData(
      backgroundColor: AppColor.mainThemeColor,
    ),
    fontFamily: AppString.appFont,
    textButtonTheme: TextButtonThemeData(
      style: TextButton.styleFrom(
        foregroundColor: Colors.black54,
        shape: const RoundedRectangleBorder(
          side: BorderSide(color: Colors.grey),
        ),
      ),
    ),
    timePickerTheme: TimePickerThemeData(
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.all(Radius.circular(8)),
        side: BorderSide(color: Colors.grey, width: 2),
      ),
      dialHandColor:  AppColor.mainThemeColor,
      hourMinuteColor: MaterialStateColor.resolveWith((states) =>
          states.contains(MaterialState.selected)
              ?  AppColor.mainThemeColor
              : Colors.black12),
      hourMinuteTextColor: MaterialStateColor.resolveWith((states) =>
          states.contains(MaterialState.selected)
              ? Colors.black54
              : Colors.grey),
      dayPeriodBorderSide: const BorderSide(color: Colors.grey),
      dayPeriodShape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(5),
      ),
      dayPeriodColor: Colors.transparent,
      dayPeriodTextColor: MaterialStateColor.resolveWith((states) =>
          states.contains(MaterialState.selected)
              ?  AppColor.mainThemeColor
              : Colors.black12),
      hourMinuteShape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(10),
        side: const BorderSide(color: Colors.black12),
      ),
    ),
    bottomSheetTheme: const BottomSheetThemeData(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(20),
          topRight: Radius.circular(20),
        ),
      ),
    ),
  );
}
