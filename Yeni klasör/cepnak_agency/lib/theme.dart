import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

final appColorLightProvider = Provider<AppColor>((ref) => AppColor(
    indigo: indigo,
    greenish: greenish,
    purpleish: purpleish,
    redish: redish,
    yellowish: yellowish,
    blackish: blackish,
    greyish: greyish,
    whiteish: whiteish,
    blueish: blueish,
    orangish: orangish));
final textThemeProvider = Provider((ref) => null);

class AppColor {
  MaterialColor greenish;
  MaterialColor purpleish;
  MaterialColor redish;
  MaterialColor blackish;
  MaterialColor greyish;
  MaterialColor yellowish;
  MaterialColor orangish;
  MaterialColor blueish;
  MaterialColor indigo;

  MaterialColor whiteish;
  AppColor({
    required this.greenish,
    required this.redish,
    required this.blackish,
    required this.greyish,
    required this.yellowish,
    required this.whiteish,
    required this.orangish,
    required this.purpleish,
    required this.blueish,
    required this.indigo
  });
}

//-------------------------------------------------------
ThemeData lightThemeData = ThemeData(
  useMaterial3: true,
  textTheme: TextTheme(
    headlineLarge: TextStyle(fontSize: 32.sp, fontWeight: FontWeight.w400),
    headlineMedium: TextStyle(fontSize: 28.sp, fontWeight: FontWeight.w400),
    headlineSmall: TextStyle(fontSize: 24.sp, fontWeight: FontWeight.w400),
    titleLarge: TextStyle(fontSize: 22.sp, fontWeight: FontWeight.w400),
    titleMedium: TextStyle(fontSize: 16.sp, fontWeight: FontWeight.w500),
    titleSmall: TextStyle(fontSize: 14.sp, fontWeight: FontWeight.w500),
    bodyLarge: TextStyle(fontSize: 16.sp, fontWeight: FontWeight.w400),
    bodyMedium: TextStyle(fontSize: 14.sp, fontWeight: FontWeight.w400),
    bodySmall: TextStyle(fontSize: 12.sp, fontWeight: FontWeight.w400),
    labelLarge: TextStyle(fontSize: 14.sp, fontWeight: FontWeight.w500),
    labelMedium: TextStyle(fontSize: 12.sp, fontWeight: FontWeight.w500),
    labelSmall: TextStyle(fontSize: 11.sp, fontWeight: FontWeight.w500),
  ),
  // fontFamily: GoogleFonts.,
  colorScheme: colorSchemeLight,
  primaryColor: greenish,
  scaffoldBackgroundColor: whiteish,
  splashColor: whiteish,
  unselectedWidgetColor: redish,
  canvasColor: purpleish,
  dialogBackgroundColor: whiteish,
  datePickerTheme: DatePickerThemeData(
    backgroundColor: whiteish,
    dayBackgroundColor: MaterialStateProperty.resolveWith<Color>(
      (Set<MaterialState> states) {
        if (states.contains(MaterialState.selected)) {
          return orangish;
        }
        return whiteish;
      },
    ),
    todayBackgroundColor: MaterialStateProperty.resolveWith<Color>(
      (Set<MaterialState> states) {
        if (states.contains(MaterialState.selected)) {
          return orangish;
        }
        return whiteish;
      },
    ),
    todayForegroundColor: MaterialStateProperty.resolveWith<Color>(
      (Set<MaterialState> states) {
        if (states.contains(MaterialState.selected)) {
          return whiteish;
        }
        return blackish;
      },
    ),
    todayBorder: const BorderSide(color: blackish),
    dayForegroundColor: MaterialStateProperty.resolveWith<Color>(
      (Set<MaterialState> states) {
        if (states.contains(MaterialState.selected)) {
          return whiteish;
        }
        return blackish;
      },
    ),
  ),
  textSelectionTheme: const TextSelectionThemeData(
    cursorColor: blackish,
    selectionHandleColor: greenish,
  ),
  buttonTheme: const ButtonThemeData(
    buttonColor: greenish,
    alignedDropdown: true,
  ),
  radioTheme: RadioThemeData(
    fillColor: MaterialStateProperty.resolveWith<Color>(
      (Set<MaterialState> states) {
        if (states.contains(MaterialState.selected)) {
          return greenish;
        }
        return blackish;
      },
    ),
  ),
  textButtonTheme: TextButtonThemeData(
      style: TextButton.styleFrom(
    foregroundColor: blackish,
  )),
  elevatedButtonTheme: ElevatedButtonThemeData(
      style: ElevatedButton.styleFrom(
    shadowColor: Colors.transparent,
    elevation: 0,
    foregroundColor: orangish,
    shape: RoundedRectangleBorder(
      side: BorderSide(
        color: greyish.shade100,
        width: 1.0,
      ),
      borderRadius:
          BorderRadius.circular(10), // Adjust the borderRadius as needed
    ),
  )),
  inputDecorationTheme: InputDecorationTheme(
    fillColor: whiteish,
    focusedBorder: OutlineInputBorder(
      borderRadius: BorderRadius.circular(15),
      borderSide: BorderSide(
        color: greyish.shade100,
        width: 1.0,
      ),
    ),
    enabledBorder: OutlineInputBorder(
      borderRadius: BorderRadius.circular(15),
      borderSide: BorderSide(
        color: greyish.shade100,
        width: 1.0,
      ),
    ),
    errorBorder: OutlineInputBorder(
      borderRadius: BorderRadius.circular(15),
      borderSide: const BorderSide(
        color: redish,
        width: 1.0,
      ),
    ),
    border: OutlineInputBorder(
      borderRadius: BorderRadius.circular(15),
      borderSide: BorderSide(
        color: greyish.shade100,
        width: 1.0,
      ),
    ),
  ),
  bottomNavigationBarTheme: const BottomNavigationBarThemeData(
    elevation: 0,
    backgroundColor: Colors.white,
    showSelectedLabels: true,
    showUnselectedLabels: true,
    selectedItemColor: blackish,
    type: BottomNavigationBarType.fixed,
    selectedIconTheme: IconThemeData(color: blackish),
  ),
);

//light
var colorSchemeLight = ColorScheme(
    brightness: Brightness.light,
    primary: whiteish,
    onPrimary: blackish,
    secondary: orangish,
    onSecondary: greenish,
    error: redish,
    onError: redish,
    background: greenish,
    onBackground: whiteish,
    onSurface: blackish,
    surface: blackish,
    outline: whiteish.shade100);

const yellowish = MaterialColor(0xffF8B95C, {100: Color(0xffFFE70F)});

const redish = MaterialColor(0xffFD0E0E, {});
const whiteish = MaterialColor(0xffFFFFFF,
    {100: Color(0xffE1E1E1), 200: Color(0xffE1E1E1), 300: Color(0xffEEEEEE),
      400:Color(0xffD9D9D9)
    });
const blackish = MaterialColor(0xff000000, {100: Color(0xff515151)});
const greyish = MaterialColor(0xff8E8E8E,
    {100: Color(0xff414042),
      200: Color(0xffD0D5DD),
      300: Color(0xffDEDEDE),
      400:Color(0xffF5F5F5),
      500:Color(0xffA77E7E),
    });
const blueish = MaterialColor(0xff1DA1F2, {
  100:Color(0xffB8C5D0)
});

const greenish = MaterialColor(0xff1EF79C, {
  100: Color(0xff39CF51),
});
const orangish =
    MaterialColor(0xffF7901E, {100: Color(0xffF6BA77), 200: Color(0xffF6B95D)});
const indigo =
MaterialColor(0xff4B0082, {100: Color(0xffF6BA77), 200: Color(0xffF6B95D)});

const purpleish = MaterialColor(0xffB5B1F6, {});
