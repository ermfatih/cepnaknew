import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

extension ContextExtension on BuildContext{
  MediaQueryData get mediaQuery=>MediaQuery.of(this);
}
extension MediaQueryExtension on BuildContext {
  double get myHeight => mediaQuery.size.height;
  double get myWidth => mediaQuery.size.width;

  double get veryLowValue=> 0.01.sw;
  double get lowValue => myWidth * 0.05;
  double get mediumValue => myHeight * 0.1;
  double get highValue => myHeight * 0.25;

  double dynamicWidth(double val) => myWidth * val;
  double dynamicHeight(double val) => myHeight * val;
}

extension ThemeExtension on BuildContext {
  ThemeData get myTheme => Theme.of(this);
  ColorScheme get colors => myTheme.colorScheme;
  TextTheme get myTextTheme => myTheme.textTheme;
  Brightness get brightness => myTheme.brightness;

}
extension PaddingExtensionAll on BuildContext {
  EdgeInsets get paddingLowAll => EdgeInsets.all(lowValue);
  EdgeInsets get paddingMediumAll => EdgeInsets.all(mediumValue);
  EdgeInsets get paddingHighAll => EdgeInsets.all(highValue);
}

extension PaddingExtensionSymmetric on BuildContext {
  EdgeInsets get paddingVeryLowVertical => EdgeInsets.symmetric(vertical: veryLowValue);
  EdgeInsets get paddingLowVertical => EdgeInsets.symmetric(vertical: lowValue);
  EdgeInsets get paddingMediumVertical => EdgeInsets.symmetric(vertical: mediumValue);
  EdgeInsets get paddingHighVertical => EdgeInsets.symmetric(vertical: highValue);

  EdgeInsets get paddingVeryLowHorizontal => EdgeInsets.symmetric(horizontal: veryLowValue);
  EdgeInsets get paddingLowHorizontal => EdgeInsets.symmetric(horizontal: lowValue);
  EdgeInsets get paddingMediumHorizontal => EdgeInsets.symmetric(horizontal: mediumValue);
  EdgeInsets get paddingHighHorizontal => EdgeInsets.symmetric(horizontal: highValue);
}

extension RadiusExtension on BuildContext {
  Radius get lowRadius => Radius.circular(myWidth * 0.02);
  Radius get normalRadius => Radius.circular(myWidth * 0.05);
  Radius get highRadius => Radius.circular(myWidth * 0.1);
  BorderRadius get borderLowRadius => BorderRadius.circular(5);
  BorderRadius get borderNormalRadius => BorderRadius.circular(10);
  BorderRadius get borderHigRadius => BorderRadius.circular(20);
}



extension DurationExtension on BuildContext {
  Duration get shortDuration => const Duration(milliseconds: 500);
  Duration get normalDuration => const Duration(seconds: 1);
}

extension SnackBarExtension on BuildContext {
  dynamic showSnackBar(String text) => ScaffoldMessenger.of(this).showSnackBar(SnackBar(
    content: Text(text, style: myTextTheme.bodyLarge),
//        backgroundColor: customColors.azure,
  ));
}