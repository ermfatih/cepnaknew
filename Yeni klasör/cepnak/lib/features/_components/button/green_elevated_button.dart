import 'package:cepnak/core/extensions/context_extensions.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class GreenElevatedButton extends StatelessWidget {
  const GreenElevatedButton({super.key, this.text, this.onPressed, this.isFixedSize=true, this.color,});
  final String? text;
  final void Function()? onPressed;
  final bool isFixedSize;
  final Color? color;
  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
        style: ElevatedButton.styleFrom(
          elevation: 0,
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16.r)),
            backgroundColor:color ?? Color(0xff2AA14A),
            fixedSize:isFixedSize ?Size(300.w,36.h) :Size(88.w,40.h),
        ), onPressed: onPressed, child: Text(text ?? '',style: context.myTextTheme.headlineSmall!.copyWith(color: Colors.white)));
  }
}