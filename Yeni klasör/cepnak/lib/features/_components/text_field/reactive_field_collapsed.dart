import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:reactive_forms/reactive_forms.dart';

class ReactiveFieldCollapsed extends StatelessWidget {
  const ReactiveFieldCollapsed({super.key, required this.formControlName, this.hintText});
  final String formControlName;
  final String? hintText;
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(12.r),
      decoration: BoxDecoration(border: Border.all(),borderRadius: BorderRadius.circular(15.r)),
      height: 0.15.sh,//context.myHeight*.15
      child: ReactiveTextField(
        validationMessages: {
          ValidationMessage.required:(error) =>'Bu alan boş bırakılamaz'
        },
        textInputAction: TextInputAction.done,
        formControlName: formControlName,
        decoration: InputDecoration.collapsed(hintText: hintText ?? ''),
        expands: true,
        maxLines: null,
        minLines: null,
      ),
    );
  }
}
