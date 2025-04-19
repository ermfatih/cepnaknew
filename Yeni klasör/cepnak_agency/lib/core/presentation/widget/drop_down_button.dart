import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class DropDownButton extends StatelessWidget {
  const DropDownButton(
      {super.key,
      required this.currentIndex,
      required this.onChange,
      this.end =8,
      this.label,
      this.start = 4,
      this.step = 2,
      this.labelStyle,
      this.backgroundColor = const Color(0xffFFFFFF),
      this.textColor = const Color(0xff32324D)});
  final int start;
  final int end;
  final int step;
  final int currentIndex;
  final Function(int)? onChange;
  final Color backgroundColor;
  final Color textColor;
  final String? label;
 final  TextStyle? labelStyle;
  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        Material(
       borderRadius: BorderRadius.circular(4.r),
       elevation: 4,
          child: Container(
              width: 55.w,
              height: 32.h,
              padding: EdgeInsets.symmetric(horizontal: 5.w),
              decoration: BoxDecoration(
                color: backgroundColor,
                borderRadius: BorderRadius.circular(4.r),
              ),
              child: DropdownButton<int>(
                underline: const SizedBox(),
                borderRadius: BorderRadius.circular(4.r),
                dropdownColor: backgroundColor,
                elevation: 10,
                isDense: true,
                style: Theme.of(context)
                    .textTheme
                    .labelSmall
                    ?.copyWith(color: textColor),
                value: currentIndex,
                items: [
                  for (int i = start; i <= end; i += step)
                    DropdownMenuItem(
                      value: i,
                      child: Text(
                        '$i',
                      ),
                    ),
                ],
                onChanged: (value) {
                  onChange?.call(value??start);
                },
              )),
        ),
            if(label!=null)SizedBox(width: 16.w,),
            if(label!=null)
            SizedBox(
              width: 168.w,
              child: Text(label!,style:labelStyle??Theme.of(context).textTheme.bodySmall?.copyWith(color:const Color(0xff8E8EA9)) ,),
            )
      ],
    );
  }
}
