import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class LightTheme{
  static LightTheme? _instance;
  static LightTheme get instance {
    return _instance ??= LightTheme._init();
  }
  LightTheme._init();
  ThemeData get lightTheme => ThemeData(
    datePickerTheme: DatePickerThemeData(
      //rangePickerBackgroundColor: Colors.red,
      rangePickerHeaderForegroundColor: Colors.black,
    ),
    dropdownMenuTheme: DropdownMenuThemeData(
      inputDecorationTheme: InputDecorationTheme(border:OutlineInputBorder(borderRadius: BorderRadius.all(Radius.circular(25.r)))
      )
    ),
    inputDecorationTheme: InputDecorationTheme(
      border: OutlineInputBorder(borderRadius: BorderRadius.circular(20.r)),
      fillColor: Colors.red,
      //floatingLabelBehavior: FloatingLabelBehavior.auto,
      //alignLabelWithHint: true,

    ),
    sliderTheme:const SliderThemeData(
      showValueIndicator:ShowValueIndicator.always,
      valueIndicatorColor: Color(0xff6750A4),
      valueIndicatorShape: DropSliderValueIndicatorShape(),

    ),
    dividerTheme:const DividerThemeData(
      color: Colors.black,
    ),
    colorScheme: const ColorScheme.light(),
    appBarTheme: AppBarTheme(
      iconTheme: IconThemeData(color: Colors.black),
      titleTextStyle: TextStyle(fontWeight: FontWeight.w400,color: Color(0xff000000),fontSize: 20.sp),
      centerTitle: true,
      color: Colors.white,

    ),
    bottomNavigationBarTheme: const BottomNavigationBarThemeData(
      elevation: 20,
      unselectedLabelStyle: TextStyle(fontWeight: FontWeight.w600,),
      //showUnselectedLabels: true,
      selectedItemColor: Color(0XFF4DD773),
      selectedLabelStyle: TextStyle(fontWeight: FontWeight.w600),
      type: BottomNavigationBarType.fixed,
    ),
    elevatedButtonTheme: ElevatedButtonThemeData(
        style: ElevatedButton.styleFrom(
            elevation: 4,
            shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10.r))
        )
    ),
    dialogTheme: DialogTheme(
      backgroundColor: Color(0xFFF0EBEB),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.all(Radius.circular(10.r))),
    ),
    textTheme: TextTheme(
      headlineLarge: TextStyle(fontSize: 32.sp,fontWeight: FontWeight.w400,color: Color(0xff000000)),
      headlineSmall: TextStyle(fontWeight: FontWeight.w400,fontSize: 16.sp,color:Color(0xff000000)),
      headlineMedium: TextStyle(fontWeight: FontWeight.w400,color: Color(0xff000000),fontSize: 20.sp),
      bodySmall: TextStyle(fontWeight: FontWeight.w400,fontSize: 12.sp),
      bodyLarge: TextStyle(fontWeight: FontWeight.w400,fontSize: 14,color:Colors.black)
    ),
  );
}