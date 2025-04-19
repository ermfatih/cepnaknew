import 'package:cepnak/core/extensions/context_extensions.dart';
import 'package:cepnak/features/_components/text_field/custom_form_field.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class FilterTonnage extends StatelessWidget {
  const FilterTonnage({super.key, required this.formControlName, required this.text,});
  final String formControlName;
  final String text;
  @override
  Widget build(BuildContext context) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.end,
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Container(
          margin: EdgeInsets.symmetric(vertical: 15.h),
          height: 50.h,
          width: 0.5.sw,
          decoration: BoxDecoration(
            color: Color(0xffF0EBEB),
            boxShadow:const [BoxShadow(color:Colors.black,blurRadius: 2,offset: Offset(0,1) )],
            borderRadius: BorderRadius.circular(5.r),
          ),
          child: Center(child: Text('$text :',style: context.myTextTheme.headlineSmall,)),
        ),
        SizedBox(width:context.myWidth*.35,child: CustomReactiveField(formControlName:formControlName ,))
      ],
    );
  }
}
