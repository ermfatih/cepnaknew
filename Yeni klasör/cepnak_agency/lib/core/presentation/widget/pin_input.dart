import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:reactive_pinput/reactive_pinput.dart';

import '../../../theme.dart';

class PinInput extends ConsumerWidget {
  const PinInput({
    this.length = 4,
    super.key,
    required this.control,
    this.isSecure = false,
    this.isText = false,
    this.height,
    this.width,
  });
  final String? control;
  final int? length;
  final double? height;
  final double? width;

  final bool isSecure;
  final bool isText;

  @override
  Widget build(BuildContext context, ref) {
    final colorProvider = ref.read(appColorLightProvider);
    return Directionality(
      textDirection: TextDirection.ltr,
      child: ReactivePinPut<String>(
          obscureText: isSecure,
          keyboardType: isText ? TextInputType.text : TextInputType.number,
          formControlName: control,
          length: length ?? 4,
          defaultPinTheme: PinTheme(
            height: height ?? 45.h,
            width: width ?? 50.w,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(4.r),
              border: Border.all(color: colorProvider.greyish),
            ),
            textStyle: Theme.of(context).textTheme.bodyMedium,
          ),
          submittedPinTheme: PinTheme(
            height: height ?? 45.h,
            width: width ?? 50.w,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(4.r),
              border: Border.all(color: colorProvider.orangish),
            ),
            textStyle: Theme.of(context).textTheme.bodyMedium,
          ),
          focusedPinTheme: PinTheme(
            height: height ?? 45.h,
            width: width ?? 50.w,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(4.r),
              border: Border.all(color: colorProvider.orangish),
            ),
            textStyle: Theme.of(context).textTheme.bodyMedium,
          ),
          errorPinTheme: PinTheme(
            height: height ?? 45.h,
            width: width ?? 50.w,
            decoration: BoxDecoration(
              color: Theme.of(context).colorScheme.error,
              borderRadius: BorderRadius.circular(4.r),
            ),
          )),
    );
  }
}
